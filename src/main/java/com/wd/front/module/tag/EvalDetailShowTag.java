package com.wd.front.module.tag;

import java.io.IOException;
import java.util.HashSet;
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
 * 期刊评价信息的详细展示
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
public class EvalDetailShowTag extends SimpleTagSupport {

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
		LinkedHashMap<String, Map<Integer, Set<SysOB>>> evalMap = null;
		List<Map<String, Object>> shouluList = (List<Map<String, Object>>) doc.get("shouLu");
		if (SimpleUtil.collNotNull(shouluList) && SimpleUtil.mapNotNull(authorityDbMap)) {
			evalMap = ShouLuSortUtil.sortShouLu(shouluList, authorityDbMap, Comm.isEval.keySet());
		}
		if (SimpleUtil.mapNotNull(evalMap)) {
			// 用来去重
			Set<String> evlHead = new HashSet<String>();

			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.append("<table class=\"pj_table\" id=\"pj_table\" RunJsBj='no'>");
			stringBuilder.append("<tbody><tr class=\"hide\"><td width='30%'></td><td width='70%'></td></tr></tbody><tbody><tr><th colspan=2 class='tl'> 评 价</th></tr></tbody>");
			stringBuilder.append("<tbody>");

			// 遍历输出所有评价体系
			Set<String> keySet = evalMap.keySet();
			for (String sysName : keySet) {
				String newSysName = Comm.isEval.get(sysName);
				if (null == keySet || !evlHead.add(newSysName)) {
					continue;
				}
				AuthorityDatabase authorityDatabase = AuthorityDbUtil.findPartition(allDbPartitionList, sysName);
				stringBuilder.append("<tr>");
				stringBuilder.append("<td class=\"tr\">" + newSysName + "： </td>");

				stringBuilder.append("<td>");
				stringBuilder.append("<div class=\"rela\">");
				Map<Integer, Set<SysOB>> mutilYearEval = evalMap.get(sysName);
				Set<Integer> yearSet = mutilYearEval.keySet();
				if (yearSet.size() > 1) {
					stringBuilder.append("<a class=\"more\" href=\"#\" open='no'>更多</a>");
					stringBuilder.append("<div class=\"table_list_box\" style='height: 0px'><ol>");
				} else {
					stringBuilder.append("<div class=\"table_list_box\"><ol>");
				}
				for (Integer year : yearSet) {
					stringBuilder.append("<li>");
					stringBuilder.append("<strong>[" + year + "]</strong>");
					Set<SysOB> evalSet = mutilYearEval.get(year);
					Set<String> hasEval = new HashSet<String>();
					for (SysOB sysOB : evalSet) {
						if (!Comm.jcrType.contains(sysName)) {
							if (hasEval.add(sysOB.getEval())) {
								stringBuilder.append("<p class=\"year_\">" + sysOB.getEval() + "</p>");
							}
						} else {
							String sortCdt = SystemLinkUtil.buildSortCondition(sysName, authorityDbMap, sysOB.getSubject(), disciplineMap, sysOB.getYear());
							String url = SystemLinkUtil.buildSubjectUrl(siteFlag, sysName, sysOB.getSubject(), sysOB.getYear()) + sortCdt;
							stringBuilder.append("<p class=\"year_\"><a href=\"" + url + "\">" + sysOB.getSubject() + "</a>");
							if (null != sysOB.getPartition()) {
								String partitionUrl = SystemLinkUtil.buildPartitionUrl(siteFlag, sysName, sysOB.getSubject(), year, sysOB.getPartition()) + sortCdt;
								if (null != authorityDatabase) {
									stringBuilder.append("&nbsp;&nbsp;<a href=\"" + partitionUrl + "\">" + authorityDatabase.getPrefix() + sysOB.getPartition() + authorityDatabase.getSuffix()
											+ "</a>");
								} else {
									stringBuilder.append("&nbsp;&nbsp;<a href=\"" + partitionUrl + "\">" + sysOB.getPartition() + "</a>");
								}
							}
							stringBuilder.append("</p>");
						}
					}
					stringBuilder.append("</li>");
				}
				stringBuilder.append("</ol></div>");
				stringBuilder.append("</div>");
				stringBuilder.append("</td>");
				stringBuilder.append("</tr>");
			}

			stringBuilder.append("</tbody>");
			stringBuilder.append("</table>");

			// 向页面输出
			super.getJspContext().getOut().print(stringBuilder.toString());
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
