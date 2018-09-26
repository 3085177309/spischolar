package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
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
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SysOB;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.AuthorityDbUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;
import com.wd.util.SystemLinkUtil;

/**
 * 期刊评价的简单展示(只展示最近一年的收录情况) 输出格式如下：
 * 
 * <pre>
 * <table class="pj_table" runjsbj="no">
 * 	<!--下面的tbody是控制表格的宽度的-->
 * 	<tbody>
 * 		<tr class="hide">
 * 			<td width="30%"></td>
 * 			<td width="70%"></td>
 * 		</tr>
 * 		<tr>
 * 			<th colspan="2" class="tl">评 价</th>
 * 		</tr>
 * 	</tbody>
 * 	<!--下面的tbody是调的数据-->
 * 	<tbody>
 * 		<tr>
 * 			<td class="tr">SCI-E(2012)：</td>
 * 			<td>Mathtics Q1 Enginering Q1</td>
 * 		</tr>
 * 		<tr>
 * 			<td class="tr">CSCD (2012)：</td>
 * 			<td>数学</td>
 * 		</tr>
 * 		<tr>
 * 			<td class="tr">北大核心（2011）：</td>
 * 			<td>数学</td>
 * 		</tr>
 * 	</tbody>
 * </table>
 * </pre>
 * 
 * @author pan
 * 
 */
public class EvalSimpleShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	public EvalSimpleShowTag() {
	}

	@SuppressWarnings("unchecked")
	@Override
	public void doTag() throws JspException, IOException {
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
		Map<String, Integer> disciplineMap = null;
		Map<String, Integer> authorityDbMap = null;
		List<AuthorityDatabase> allDbPartitionList = null;
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
		if (SimpleUtil.collIsNull(shouluList)) {
			return;
		}

		Map<String, Set<SysOB>> sysBOmap = buildDataStruct(shouluList);
		String htmlStr = dataStruct2HtmlStr(siteFlag, sysBOmap, disciplineMap, authorityDbMap, allDbPartitionList);
		super.getJspContext().getOut().print(htmlStr);
	}

	private String dataStruct2HtmlStr(String siteFlag, Map<String, Set<SysOB>> sysBOmap, Map<String, Integer> disciplineMap, Map<String, Integer> authorityDbMap,
			List<AuthorityDatabase> allDbPartitionList) {
		if (sysBOmap.isEmpty()) {
			return "";
		}
		StringBuilder stringBuilder = new StringBuilder("<table class='pj_table' runjsbj='no'>");

		stringBuilder.append("<tbody><tr class=\"hide\"><td width=\"30%\"></td><td width=\"70%\"></td></tr><tr><th colspan=\"2\" class=\"tl\">评 价</th></tr></tbody>");
		stringBuilder.append("<tbody>");

		Set<String> keySet = sysBOmap.keySet();
		for (String key : keySet) {
			stringBuilder.append("<tr>");
			stringBuilder.append("<td class=\"tr\">" + key + "</td>");
			Set<SysOB> setOB = sysBOmap.get(key);
			if (isJcrType(key)) {
				stringBuilder.append(buildJcrShowHtml(siteFlag, setOB, disciplineMap, authorityDbMap, allDbPartitionList));
			} else {
				stringBuilder.append(buildEvalShowHtml(setOB));
			}
			stringBuilder.append("</tr>");
		}

		stringBuilder.append("</tbody>");
		stringBuilder.append("</table>");
		return stringBuilder.toString();
	}

	private String buildEvalShowHtml(Set<SysOB> setOB) {
		Set<String> evalSet = new HashSet<String>();
		for (SysOB ob : setOB) {
			if (SimpleUtil.strIsNull(ob.getEval())) {
                continue;
            }
			evalSet.add(ob.getEval());
		}
		if (evalSet.isEmpty()) {
			return "";
		}
		StringBuilder builder = new StringBuilder();
		builder.append("<td>");
		Iterator<String> iter = evalSet.iterator();
		while (iter.hasNext()) {
			builder.append(iter.next());
			if (iter.hasNext()) {
				builder.append("、");
			}
		}
		builder.append("</td>");
		return builder.toString();
	}

	private String buildJcrShowHtml(String siteFlag, Set<SysOB> setOB, Map<String, Integer> disciplineMap, Map<String, Integer> authorityDbMap, List<AuthorityDatabase> allDbPartitionList) {
		StringBuilder builder = new StringBuilder();
		builder.append("<td><ul>");
		for (SysOB ob : setOB) {
			String sortCdt = SystemLinkUtil.buildSortCondition(ob.getDb(), authorityDbMap, ob.getSubject(), disciplineMap, ob.getYear());
			builder.append("<li>");
			String url = SystemLinkUtil.buildSubjectUrl(siteFlag, ob.getDb(), ob.getSubject(), ob.getYear()) + sortCdt;
			builder.append("<a target='_blank' href='" + url + "'>" + ob.getSubject() + "</a>");
			if (null != ob.getPartition()) {
				AuthorityDatabase authorityDatabase = AuthorityDbUtil.findPartition(allDbPartitionList, ob.getDb());
				String partitionUrl = SystemLinkUtil.buildPartitionUrl(siteFlag, ob.getDb(), ob.getSubject(), ob.getYear(), ob.getPartition()) + sortCdt;
				if (null != authorityDatabase) {
					builder.append("&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='" + partitionUrl + "'>" + authorityDatabase.getPrefix() + ob.getPartition() + authorityDatabase.getSuffix()
							+ "</a>");
				} else {
					builder.append("&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='" + partitionUrl + "'>" + ob.getPartition() + "</a>");
				}
			}

			builder.append("</li>");
		}
		builder.append("</ul></td>");
		return builder.toString();
	}

	private boolean isJcrType(String key) {
		for (String jcrType : Comm.jcrType) {
			if (key.startsWith(jcrType)) {
				return true;
			}
		}
		return false;
	}

	private Map<String, Set<SysOB>> buildDataStruct(List<Map<String, Object>> shouluList) {
		Map<String, Set<SysOB>> sysBOmap = new HashMap<String, Set<SysOB>>();

		for (Map<String, Object> evalMap : shouluList) {
			if (SimpleUtil.mapIsNull(evalMap)) {
				continue;
			}
			String lastEval = (String) evalMap.get("last");
			if (SimpleUtil.strIsNull(lastEval)) {
				continue;
			}

			// 数据结构：SCI-E^2013^ACOUSTICS^1^3.816;SCI-E^2013^CHEMISTRY,
			// MULTIDISCIPLINARY^1^3.816;
            String[] mutilEvalArr = lastEval.split(";");
			for (String singleEval : mutilEvalArr) {
				if (SimpleUtil.strIsNull(singleEval)) {
					continue;
				}
                String[] infoArr = singleEval.split("\\^");
				if (infoArr.length < 3) {
					continue;
				}
				String db = infoArr[0];
				String newDbName = Comm.isEval.get(db);
				if (SimpleUtil.strIsNull(newDbName)) {
					continue;
				}
				Integer year = null;
				try {
					year = Integer.parseInt(infoArr[1]);
				} catch (Exception e) {
					continue;
				}
				String subject = infoArr[2];
				if (SimpleUtil.strIsNull(subject)) {
					continue;
				}
				Integer partition = null;
				if (infoArr.length > 3) {
					try {
						partition = Integer.parseInt(infoArr[3]);
					} catch (NumberFormatException e) {
					}
				}
				String eval = null;
				if (infoArr.length > 4) {
					eval = infoArr[4];
				}
				SysOB ob = new SysOB(year, subject, partition, eval);
				ob.setDb(db);
				String key = newDbName + "(" + year + "):";
				Set<SysOB> setOB = sysBOmap.get(key);
				if (null == setOB) {
					setOB = new TreeSet<SysOB>(new Comparator<SysOB>() {
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
					sysBOmap.put(key, setOB);
				}
				setOB.add(ob);
			}
		}

		return sysBOmap;
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
