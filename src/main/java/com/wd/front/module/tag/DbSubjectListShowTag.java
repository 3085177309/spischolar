package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.model.AuthorityDatabase;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.ChineseUtil;
import com.wd.util.GetFirstLetter;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;

/**
 * 权威数据库的学科分类列表（用于浏览页）
 * 
 * @author pan
 * 
 */
public class DbSubjectListShowTag extends SimpleTagSupport {

	private static final GetFirstLetter getFirstLetter = new GetFirstLetter();
	private List<Map<String, Object>> docList;

	private boolean contains(Set<Map<String, Object>> set, String dis) {
		for (Map<String, Object> single : set) {
			if (single.get("discipline").toString().toUpperCase().trim().equals(dis.trim().toUpperCase())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void doTag() throws JspException, IOException {
		StringBuilder stringBuilder = new StringBuilder();
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
		Map<String, Integer> disciplineMap = null;
		Map<String, Integer> authorityDbMap = null;
		try {
			disciplineMap = cacheModule.findAllDisciplineFromCache();
			authorityDbMap = cacheModule.findAllAuthorityDbFromCache();
		} catch (SystemException e1) {
			e1.printStackTrace();
		}

		List<AuthorityDatabase> dbPartitions = null;
		try {
			dbPartitions = cacheModule.findDbPartitionFromCache();
		} catch (SystemException e) {
			e.printStackTrace();
		}

		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		stringBuilder.append("<input type='hidden' id='siteFlag' value='" + siteFlag + "'/>");
		// 按照首字母分类
		Map<String, Set<Map<String, Object>>> docMap = new HashMap<String, Set<Map<String, Object>>>();
		// 将学科按照首字母分类
		for (Map<String, Object> doc : docList) {
			Object disciplineObj = doc.get("discipline");
			if (!SimpleUtil.stringObjNotNull(disciplineObj)) {
                continue;
            }
			String discipline = disciplineObj.toString().trim();
			String firstLetter = null;
			if (ChineseUtil.isChinese(discipline)) {
				firstLetter = getFirstLetter.getFirstLetter(discipline).toUpperCase();
			} else {
				try {
					firstLetter = discipline.substring(0, 1).toUpperCase();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			Set<Map<String, Object>> set = docMap.get(firstLetter);
			if (null == set) {
				set = new TreeSet<Map<String, Object>>(new Comparator<Map<String, Object>>() {

					private int getMinLength(String o1, String o2) {
						int lenth1 = o1.length(), length2 = o2.length();
						return Math.min(lenth1, length2);
					}

					@Override
					public int compare(Map<String, Object> o1, Map<String, Object> o2) {
						char a, b;
						String o1Str = o1.get("discipline").toString().trim();
						String o2Str = o2.get("discipline").toString().trim();
						int len = getMinLength(o1Str, o2Str);
						for (int i = 0; i < len; i++) {
							a = o1Str.charAt(i);
							b = o2Str.charAt(i);
							if (a > b) {
								return 1;
							} else if (a < b) {
								return -1;
							}
						}
						return 1;
					}
				});
				docMap.put(firstLetter, set);
			}
			Object discObj = doc.get("discipline");
			if (null != discObj && !contains(set, discObj.toString())) {
                set.add(doc);
            }
		}

		Set<String> keySet = docMap.keySet();
		// 按首字母排序
		Set<String> tmpSet = new TreeSet<String>(new Comparator<String>() {

			@Override
			public int compare(String o1, String o2) {
				int o1Int = o1.charAt(0);
				int o2Int = o2.charAt(0);
				if (o1Int > o2Int) {
					return 1;
				} else if (o1Int < o2Int) {
					return -1;
				}
				return 0;
			}
		});
		tmpSet.addAll(keySet);
		String isMobiles = (String) request.getSession().getAttribute("isMobile");
		if (tmpSet.size() > 0) {
			stringBuilder.append("<div class=\"letter-list border\" id=\"goto_fixed\">");
			for (String firstLetter : tmpSet) {
				if(!Comm.Mobile.equals(isMobiles)) {
					stringBuilder.append("<a href='journal#" + firstLetter + "'>" + firstLetter + "</a>");
				}else{
					stringBuilder.append("<a data-href='journal#" + firstLetter + "'>" + firstLetter + "</a>");
				}
				
			}
			stringBuilder.append("</div>");
		}

		stringBuilder.append("<div class='ll_nr' id='ll_nr'>");
		// key为实际值，value为encode之后的值
		Map<String, String> simpleCache = new HashMap<String, String>();
		for (String firstLetter : tmpSet) {
			stringBuilder.append("<h3 id='" + firstLetter + "'>" + firstLetter + "</h3>");
			Set<Map<String, Object>> docs = docMap.get(firstLetter);
			for (Map<String, Object> singleDoc : docs) {
				String authorityDatabase = singleDoc.get("authorityDatabase").toString().trim();
				String authorityDatabaseEncode = simpleCache.get(authorityDatabase);
				if (null == authorityDatabaseEncode) {
					authorityDatabaseEncode = URLEncoder.encode(singleDoc.get("authorityDatabase").toString(), "UTF-8");
					simpleCache.put(authorityDatabase, authorityDatabaseEncode);
					stringBuilder.append("<input type='hidden' id='authorityDatabaseEncode' value='" + authorityDatabaseEncode + "'/>");
					if (null != authorityDbMap && null != disciplineMap) {
						Integer dbId = authorityDbMap.get(authorityDatabase);
						stringBuilder.append("<input type='hidden' id='dbId' value='" + dbId + "'/>");
					}
				}
				String discRep = singleDoc.get("discipline").toString().trim().replaceAll(",", "%320").replace(" ", "%310");
				String discRepEncode = simpleCache.get(discRep);
				if (null == discRepEncode) {
					discRepEncode = URLEncoder.encode(discRep, "UTF-8");
					simpleCache.put(discRep, discRepEncode);
				}
				String disc = singleDoc.get("discipline").toString().trim();
				String discEncode = simpleCache.get(disc);
				if (null == discEncode) {
					discEncode = URLEncoder.encode(disc, "UTF-8");
					simpleCache.put(disc, discEncode);
				}
				String year = simpleCache.get("year");
				if (null == year) {
					year = singleDoc.get("year").toString().trim();
					simpleCache.put("year", year);
					stringBuilder.append("<input type='hidden' id='year' value='" + year + "'/>");
				}
				String sortField = "";
				if (null != authorityDbMap && null != disciplineMap) {
					Integer dbId = authorityDbMap.get(authorityDatabase);
					Integer subjectId = disciplineMap.get(disc);
					if (null != dbId && null != subjectId) {
						sortField = dbId + "|" + subjectId + "|" + year;
					}
				}
				String sort = "&sort=11";
				if("CSSCI".equals(authorityDatabase) || "EI".equals(authorityDatabase)){
					sort = "&sort=3";
				}
				//if(){}
				/*if (Comm.subjectNO.contains(authorityDatabase)) {
					// 按学科序号排序
					sort += "&sort=8&sortField=" + sortField + "&effectSort=8";
				} else if (Comm.eval.contains(authorityDatabase)) {
					// 按评价值排序
					sort += "&sort=7&sortField=" + sortField + "&effectSort=7";
				}*/
				/*手机pc都新建窗口打开
				StringBuilder tmp = new StringBuilder("<li sort='" + sort + "' discEncode='" + discEncode + "' discRepEncode='" + discRepEncode
						+ "'><a onclick='buildSubjUrl(this)' target='_blank' class='a1' href='javascript:void(0);'>" + disc);
				*/
				String isMobile = (String) request.getSession().getAttribute("isMobile");
				StringBuilder tmp = new StringBuilder("<li sort='" + sort + "' discEncode='" + discEncode + "' discRepEncode='" + discRepEncode
						+ "'><a onclick='buildSubjUrl(this)' ");
				if(!Comm.Mobile.equals(isMobile)) {
					tmp.append("target='_blank' ");
				}
				tmp.append( "class='a1' href='javascript:void(0);'>" + disc);
				
				if (SimpleUtil.stringObjNotNull(singleDoc.get("name"))) {
					tmp.append("<br/>").append(" <span>[ " + singleDoc.get("name").toString() + " ]</span>");
				}
				tmp.append("</a>");
				AuthorityDatabase dbPartiton = findDbPartition(authorityDatabase, dbPartitions);
				if (null != dbPartiton && SimpleUtil.strNotNull(dbPartiton.getPartitionName())) {
					tmp.append("<div class='inShowBoxNr'><i></i><p><span>" + dbPartiton.getPartitionName() + "：</span>");
					String partition = dbPartiton.getAllPartition();
					if (SimpleUtil.strNotNull(partition)) {
                        String[] partitionArr = partition.split(";");
						for (int i = 0; i < partitionArr.length; i++) {
							tmp.append("<a onclick='buildPartitionUrl(this)' ");
							if(!Comm.Mobile.equals(isMobile)) {
								tmp.append("target='_blank' ");
							}
							tmp.append( "partition='" + partitionArr[i] + "' href='javascript:void(0);'>");
							if (SimpleUtil.strNotNull(dbPartiton.getPrefix())) {
								tmp.append(dbPartiton.getPrefix().trim());
							}
							tmp.append(partitionArr[i]);
							if (SimpleUtil.strNotNull(dbPartiton.getSuffix())) {
								tmp.append(dbPartiton.getSuffix().trim());
							}
							tmp.append("</a>");
						}
					}
					tmp.append("</div>");
				}
				tmp.append("</li>");
				stringBuilder.append(tmp.toString());
			}
		}
		stringBuilder.append("</div>");
		
		
		stringBuilder.append("<script type='text/javascript'>$('.letter-list a').click(function(){"
				
				+ "$(this).addClass('in').siblings('a').removeClass('in');"
				+ "var target = $(this).attr('href');"
				
				+ "if(target){"
				+ "var ids = target.split('#')[1];"
				+ "var targetEle=$('#'+ids);"
				+ "if(targetEle.length==1){ "
				+ "var top = targetEle.offset().top-90;"
				+ "if(top > 0){ "
				+ "$('html,body').animate({scrollTop:top}, 1000); "
				+ "} "
				+ "} "
				+ "}"
				+ "}); "
				+ "</script>");
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		if(isMobile.equals(Comm.Mobile)) {
			/*stringBuilder.append("<script type='text/javascript'>$('.letter-list a').click(function(){"
					
				+ "$(this).addClass('in').siblings('a').removeClass('in');"
				+ "var target = $(this).attr('href');"
				
				+ "if(target){"
				+ "var ids = target.split('#')[1];"
				+ "var targetEle=$('#'+ids);"
				+ "if(targetEle.length==1){ "
				+ "var top = targetEle.offset().top;"
				+ "if(top > 0){ "
				+ "$('html,body').animate({scrollTop:top}, 1000); "
				+ "} "
				+ "} "
				+ "}"
				+ "}); "
				+ "</script>");*/
		}
		if(docList.size()<=0) {
			stringBuilder = new StringBuilder();
			stringBuilder.append("<div class='not-subject'></div>");
		}
		if (stringBuilder.length() > 0) {
			JspWriter out = pageContext.getOut();
			out.println(stringBuilder);
		}
	}

	private AuthorityDatabase findDbPartition(String dbName, List<AuthorityDatabase> dbPartitions) {
		if (null == dbPartitions) {
            return null;
        }
		for (AuthorityDatabase db : dbPartitions) {
			if (dbName.equals(db.getFlag())) {
				return db;
			}
		}
		return null;
	}

	public void setDocList(List<Map<String, Object>> docList) {
		this.docList = docList;
	}
}
