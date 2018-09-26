package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
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
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SysOB;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.AuthorityDbUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;
import com.wd.util.SystemLinkUtil;

/**
 * 期刊收录的简单展示(只展示最近一年的收录情况) 输出格式如下：
 * 
 * <pre>
 * <tr>
 * 		<td class="tr">SCI-E(2012)：</td>
 * 		<td>Mathtics Q1 Enginering Q1</td>
 * 	</tr>
 * 	<tr>
 * 		<td class="tr">CSCD (2012)：</td>
 * 		<td>数学</td>
 * 	</tr>
 * 	<tr>
 * 		<td class="tr">北大核心（2011）：</td>
 * 		<td>数学</td>
 * 	</tr>
 * </pre>
 * 
 * @author pan
 * 
 */
public class ShouLuSimpleShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	public ShouLuSimpleShowTag() {
	}

	@SuppressWarnings("unchecked")
	@Override
	public void doTag() throws JspException, IOException {
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
		List<AuthorityDatabase> allDbPartitionList = null;
		Map<String, Integer> disciplineMap = null;
		Map<String, Integer> authorityDbMap = null;
		try {
			allDbPartitionList = cacheModule.findDbPartitionFromCache();
			disciplineMap = cacheModule.findAllDisciplineFromCache();
			authorityDbMap = cacheModule.findAllAuthorityDbFromCache();
		} catch (SystemException e) {
			e.printStackTrace();
		}
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");

		List<Map<String, Object>> shouluList = (List<Map<String, Object>>) doc.get("shouLu");
		if (SimpleUtil.collNotNull(shouluList)) {
			// key为体系(年) value为学科集合
			Map<String, Set<SysOB>> allShouLu = new HashMap<String, Set<SysOB>>();
			for (Map<String, Object> singleShouLu : shouluList) {
				// 获取最新收录
				String lastShouLu = (String) singleShouLu.get("last");
				if (SimpleUtil.strNotNull(lastShouLu)) {
                    String[] mutilShouLu = lastShouLu.split(";");
					for (String oneShouLu : mutilShouLu) {
                        String[] arr = oneShouLu.split("\\^");
						if (arr.length >= 3 && Comm.isShouLu.contains(arr[0])) {
							Integer year = null;
							try {
								year = Integer.parseInt(arr[1]);
							} catch (RuntimeException e) {
								continue;
							}
							String key = arr[0] + "(" + arr[1] + ")";
							Integer partition = null;
							if (arr.length > 3) {
								try {
									partition = Integer.parseInt(arr[3]);
								} catch (NumberFormatException e) {
								}
							}
							SysOB systemBO = new SysOB();
							systemBO.setSubject(arr[2]);
							systemBO.setYear(year);
							systemBO.setPartition(partition);
							Set<SysOB> shouLuSet = allShouLu.get(key);
							if (null == shouLuSet) {
								shouLuSet = new TreeSet<SysOB>(new Comparator<SysOB>() {

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
								allShouLu.put(key, shouLuSet);
							}
							shouLuSet.add(systemBO);
						}
					}
				}
			}
			if (!allShouLu.isEmpty() && SimpleUtil.mapNotNull(authorityDbMap)) {
				Set<String> _sysSet = allShouLu.keySet();
				// 已排序的体系集合
				Set<String> sortSysSet = authorityDbMap.keySet();

				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.append("<table class=\"sl_table\" RunJsBj='no'>");
				stringBuilder.append("<tbody><tr class=\"hide\"><th width='30%'></th><th width='70%'></th></tr></tbody>");
				stringBuilder.append("<tbody><tr><th colspan=2 class='tl'> 收 录 : ");
				StringBuilder tmp = new StringBuilder();
				for (String sys : sortSysSet) {
					for (String lo_sys : _sysSet) {
						if (lo_sys.startsWith(sys + "(")) {
							if("SJR".equals(sys)){
								tmp.append("SCOPUS");
							}else{
								tmp.append(sys);
							}
							tmp.append("、");
						}
					}
				}
				if (tmp.length() > 0) {
					stringBuilder.append(tmp.delete(tmp.length() - 1, tmp.length()));
				}
				stringBuilder.append("</th></tr></tbody>");
				stringBuilder.append("<tbody>");
				for (String sys : sortSysSet) {
					for (String lo_sys : _sysSet) {
						if (lo_sys.startsWith(sys + "(")) {
							stringBuilder.append("<tr>");
							stringBuilder.append("<td class=\"tr\">" + lo_sys + "： </td>");
							stringBuilder.append("<td>");
							Set<SysOB> subjSet = allShouLu.get(lo_sys);
							stringBuilder.append("<ul>");
							AuthorityDatabase ad = AuthorityDbUtil.findPartition(allDbPartitionList, sys);
							for (SysOB ob : subjSet) {
								stringBuilder.append("<li>");
								String sortCdt = SystemLinkUtil.buildSortCondition(sys, authorityDbMap, ob.getSubject(), disciplineMap, ob.getYear());
								String url = SystemLinkUtil.buildSubjectUrl(siteFlag, sys, ob.getSubject(), ob.getYear()) + sortCdt;
								stringBuilder.append("<a target='_blank' href='" + url + "'>" + ob.getSubject() + "</a>");
								if (null != ob.getPartition()) {
									String partitionUrl = SystemLinkUtil.buildPartitionUrl(siteFlag, sys, ob.getSubject(), ob.getYear(), ob.getPartition()) + sortCdt;
									if (null != ad) {
										stringBuilder.append("&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='" + partitionUrl + "'>" + ad.getPrefix() + ob.getPartition() + ad.getSuffix() + "</a>");
									} else {
										stringBuilder.append("&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='" + partitionUrl + "'>" + ob.getPartition() + "</a>");
									}
								}
								stringBuilder.append("</li>");
							}
							stringBuilder.append("</ul>");
							stringBuilder.append("</td>");
							stringBuilder.append("</tr>");
						}
					}
				}
				stringBuilder.append("</tbody>");
				stringBuilder.append("</table>");
				super.getJspContext().getOut().println(stringBuilder.toString());
			}
		}
	}

	private AuthorityDatabase findPartition(List<AuthorityDatabase> allDbPartitionList, String db) {
		if (null != allDbPartitionList) {
			for (AuthorityDatabase tmp : allDbPartitionList) {
				if (db.equals(tmp.getFlag())) {
					return tmp;
				}
			}
		}
		return null;
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
