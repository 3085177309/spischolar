package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.model.AuthorityDatabase;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SysOB;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.AuthorityDbUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;
import com.wd.util.SystemLinkUtil;

/**
 * <pre>
 * 
 *  	输出格式如下：
 * <div class="related_qk">
 * 	<span class="close" title="关闭" onclick="this.parentNode.style.display='none'">×</span>
 * 	<h3>以下学科与“”有关:</h3>
 * 	<p><span>cscd(1990) :</span>数学&nbsp;&nbsp;q1&nbsp;&nbsp;</p><p><span>cscd(2001) :</span>语文&nbsp;&nbsp;q2&nbsp;&nbsp;语文&nbsp;&nbsp;q4&nbsp;&nbsp;</p><p><span>北大核心(2011) :</span>历史&nbsp;&nbsp;q1&nbsp;&nbsp;</p><p><span>jcr(2010) :</span>政治&nbsp;&nbsp;q3&nbsp;&nbsp;</p>
 * </div>
 * </pre>
 * 
 * @author pan
 * 
 */
public class ShouLuFacetShowTag extends SimpleTagSupport {

	private Map<String, Map<String, String>> facetMap;

	public ShouLuFacetShowTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		String zkyFlag= facetMap.get("zky").get("zky");
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
		List<AuthorityDatabase> allDbPartitionList = null;
		Map<String, Integer> disciplineMap = null;
		Map<String, Integer> authorityDbMap = null;
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		SearchCondition condition = (SearchCondition) request.getAttribute("cdt");
		String siteFlag = (String) request.getAttribute("siteFlag");
		try {
			allDbPartitionList = cacheModule.findDbPartitionFromCache();
			disciplineMap = cacheModule.findAllDisciplineFromCache();
			authorityDbMap = cacheModule.findAllAuthorityDbFromCache();
		} catch (SystemException e) {
			e.printStackTrace();
		}

		StringBuilder stringBuilder = new StringBuilder();
		Map<String, String> map = facetMap.get("dbYearDiscipline");
		if (SimpleUtil.mapIsNull(map)) {
			if (SimpleUtil.strNotNull(condition.getValue()) ) {
				stringBuilder.append("<div class=\"related_qk\" style=\"display:none\" >");
				stringBuilder.append("<span class=\"close\" title=\"关闭\" onClick=\"this.parentNode.style.display='none'\">×</span>");
				stringBuilder.append("<h3>未找到与“" + condition.getValue() + "”有关的学科！</h3>");
				stringBuilder.append("</div>");
				super.getJspContext().getOut().print(stringBuilder);
			}
			return;
		}
		Set<String> valueSet = map.keySet();
		Map<String, Set<SysOB>> shouLuMap = new HashMap<String, Set<SysOB>>();
		for (String value : valueSet) {
            String[] arr = value.split("\\|");
			if (arr.length >= 4) {
				SysOB systemBO = new SysOB();
				systemBO.setSubject(arr[3]);
				//为了区分 购买和试用 的用户是否有使用中科院JCR“最新”数据的权限 zkyFlag=1：购买，其他没权限 (检索列表页--相关学科)其他地方都在jsp页面上控制
				if(("中科院JCR分区(大类)".equals(arr[0])||"中科院JCR分区(小类)".equals(arr[0]))&&!"1".equals(zkyFlag)){
					systemBO.setYear(2016);
				}else{
					try {
						systemBO.setYear(Integer.parseInt(arr[2]));
					} catch (NumberFormatException e) {
						continue;
					}
				}
				String key = arr[0] + "(" + systemBO.getYear() + ")";
				Set<SysOB> subjSet = shouLuMap.get(key);
				if (null == subjSet) {
					subjSet = new TreeSet<SysOB>(new Comparator<SysOB>() {

						@Override
						public int compare(SysOB o1, SysOB o2) {
							if (null == o1 || SimpleUtil.strIsNull(o1.getSubject())) {
								return -1;
							}
							if (null == o2 || SimpleUtil.strIsNull(o2.getSubject())) {
								return 1;
							}
							String subA = o1.getSubject().toLowerCase();
							String subB = o2.getSubject().toLowerCase();
							int len = Math.min(subA.length(), subB.length());
							for (int i = 0; i < len; i++) {
								int t_a = subA.charAt(i);
								int t_b = subB.charAt(i);
								if (t_a > t_b) {
									return 1;
								} else if (t_a < t_b) {
									return -1;
								}
							}
							return 1;
						}
					});
					shouLuMap.put(key, subjSet);
				}
				subjSet.add(systemBO);
			}
		}
		if (SimpleUtil.mapNotNull(authorityDbMap) && SimpleUtil.mapNotNull(shouLuMap)) {
			stringBuilder.append("<div class=\"related_qk\">");
			stringBuilder.append("<span class=\"close\" title=\"关闭\" onClick=\"this.parentNode.style.display='none'\">×</span>");
			stringBuilder.append("<h3>以下学科与“" + condition.getValue() + "”有关:</h3>");
			// 获取已排序的学科体系列表
			Set<String> sysSet = authorityDbMap.keySet();
			for (String sys : sysSet) {
				Set<Map.Entry<String, Set<SysOB>>> entrySet = shouLuMap.entrySet();
				for (Map.Entry<String, Set<SysOB>> entry : entrySet) {
					if (entry.getKey().startsWith(sys + "(")) {
						Set<SysOB> subjSet = shouLuMap.get(entry.getKey());
						if (subjSet.isEmpty()) {
							continue;
						}
						stringBuilder.append("<p>");
						stringBuilder.append("<span>" + entry.getKey() + " : </span>");
						Iterator<SysOB> iter = subjSet.iterator();
						while (iter.hasNext()) {
							SysOB subj = iter.next();
							String sortCdt = "&sort=11"; //SystemLinkUtil.buildSortCondition(sys, authorityDbMap, subj.getSubject(), disciplineMap, subj.getYear());
							if("CSSCI".equals(sys)){
								sortCdt = "&sort=3";
							}
							String url = SystemLinkUtil.buildSubjectUrl(siteFlag, sys, subj.getSubject(), subj.getYear()) + sortCdt;
							stringBuilder.append("<a href=\"" + url + "\">" + subj.getSubject() + "</a>");
							AuthorityDatabase authorityDatabase = AuthorityDbUtil.findPartition(allDbPartitionList, sys);
							if (null != authorityDatabase) {
								String allPartition = authorityDatabase.getAllPartition();
								if (SimpleUtil.strNotNull(allPartition)) {
									stringBuilder.append("&nbsp;&nbsp;");
									String[] partitionArr = allPartition.split(";");
									for (int i = 0; i < partitionArr.length; i++) {
										String par = partitionArr[i];
										try {
											String partitionUrl = SystemLinkUtil.buildPartitionUrl(siteFlag, sys, subj.getSubject(), subj.getYear(), Integer.parseInt(par));
											stringBuilder.append("<a href=\"" + partitionUrl + "\">" + authorityDatabase.getPrefix() + par + authorityDatabase.getSuffix() + "</a>");
											if (i != partitionArr.length - 1) {
												stringBuilder.append("&nbsp;&nbsp;");
											} else {
												stringBuilder.append("<br/>");
											}
										} catch (NumberFormatException e) {
										}
									}
								} else {
									stringBuilder.append("<br/>");
								}
							}
						}
						stringBuilder.append("</p>");
					}
				}
			}
			stringBuilder.append("</div>");
			super.getJspContext().getOut().print(stringBuilder);
		}

		super.doTag();
	}

	public void setFacetMap(Map<String, Map<String, String>> facetMap) {
		this.facetMap = facetMap;
	}

}
