package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.wd.util.ShouLuSortUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;
import com.wd.util.SystemLinkUtil;

/**
 * 期刊收录的详细展示
 * 
 * <pre>
 * 输出格式如下：
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
public class ShouLuDetailShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

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

		// key为体系，value为按照年排序的学科集合
		LinkedHashMap<String, Map<Integer, Set<SysOB>>> shouluMap = null;
		List<Map<String, Object>> shouluList = (List<Map<String, Object>>) doc.get("shouLu");
		if (SimpleUtil.collNotNull(shouluList) && SimpleUtil.mapNotNull(authorityDbMap)) {
			shouluMap = ShouLuSortUtil.sortShouLu(shouluList, authorityDbMap, Comm.isShouLu);
		}
		if (SimpleUtil.mapNotNull(shouluMap)) {
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.append("<table class=\"sl_table\" id=\"sl_table\" RunJsBj='no'><tbody><tr class=\"hide\"><th width='30%'></th><th width='70%'></th></tr></tbody><tbody>");
			Set<Map.Entry<String, Map<Integer, Set<SysOB>>>> entrySet = shouluMap.entrySet();
			if (entrySet.size() > 0) {
				stringBuilder.append("<tr><th colspan=2 class='tl'> 收 录 : ");
				Iterator<Map.Entry<String, Map<Integer, Set<SysOB>>>> iter = entrySet.iterator();
				while (iter.hasNext()) {
					Map.Entry<String, Map<Integer, Set<SysOB>>> entry = iter.next();
					if("SJR".equalsIgnoreCase(entry.getKey())){
						stringBuilder.append("SCOPUS");
					}else{
						stringBuilder.append(entry.getKey());
					}
					if (iter.hasNext()) {
						stringBuilder.append("、");
					}
				}
				stringBuilder.append("</th></tr>");
			}
			stringBuilder.append("</tbody><tbody>");
			for (Map.Entry<String, Map<Integer, Set<SysOB>>> entry : entrySet) {
				stringBuilder.append("<tr>");
				stringBuilder.append("<td class=\"tr\">" + ("SJR".equals(entry.getKey()) ? "SCOPUS" : entry.getKey()) + "： </td>");
				stringBuilder.append("<td><div class=\"rela\">");
				Map<Integer, Set<SysOB>> mutilYearShouLu = entry.getValue();
				if (mutilYearShouLu.size() > 1) {
					stringBuilder.append("<a class=\"more\" href=\"#\" open='no'>更多</a>");
					stringBuilder.append("<div class=\"table_list_box\" style='height: 0px'><ol>");
				} else {
					stringBuilder.append("<div class=\"table_list_box\"><ol>");
				}

				Set<Integer> yearSet = mutilYearShouLu.keySet();
				AuthorityDatabase authorityDatabase = AuthorityDbUtil.findPartition(allDbPartitionList, entry.getKey());
				for (Integer year : yearSet) {
					Set<SysOB> subjSet = mutilYearShouLu.get(year);
					if (subjSet.isEmpty()) {
						continue;
					}
					stringBuilder.append("<li>");
					stringBuilder.append("<strong>[" + year + "]</strong>");
					for (SysOB sysOB : subjSet) {
						String sortCdt = SystemLinkUtil.buildSortCondition(entry.getKey(), authorityDbMap, sysOB.getSubject(), disciplineMap, sysOB.getYear());
						String url = SystemLinkUtil.buildSubjectUrl(siteFlag, entry.getKey(), sysOB.getSubject(), sysOB.getYear()) + sortCdt;
						stringBuilder.append("<p class=\"year_\"><a href=\"" + url + "\">" + sysOB.getSubject() + "</a>");
						if (null != sysOB.getPartition()) {
							String partitionUrl = SystemLinkUtil.buildPartitionUrl(siteFlag, entry.getKey(), sysOB.getSubject(), year, sysOB.getPartition()) + sortCdt;
							if (null != authorityDatabase) {
								stringBuilder.append("&nbsp;&nbsp;<a href=\"" + partitionUrl + "\">" + authorityDatabase.getPrefix() + sysOB.getPartition() + authorityDatabase.getSuffix() + "</a>");
							} else {
								stringBuilder.append("&nbsp;&nbsp;<a href=\"" + partitionUrl + "\">" + sysOB.getPartition() + "</a>");
							}
						}
						stringBuilder.append("</p>");
					}
					stringBuilder.append("</li>");
				}
				stringBuilder.append("</ol></div>");
				stringBuilder.append("</div></td>");
				stringBuilder.append("</tr>");
			}
			stringBuilder.append("</tbody></table>");
			// 向页面输出
			super.getJspContext().getOut().print(stringBuilder.toString());
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
