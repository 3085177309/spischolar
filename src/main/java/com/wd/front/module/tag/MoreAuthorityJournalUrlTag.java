package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.model.DisciplineSystem;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.SpringContextUtil;

/**
 * 某学科体系下更多更具有影响力的期刊列表地址
 * 
 * @author pan
 * 
 */
public class MoreAuthorityJournalUrlTag extends SimpleTagSupport {

	private DisciplineSystem disciplineSystem;

	@Override
	public void doTag() throws JspException, IOException {
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

		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		if (null == siteFlag) {
			return;
		}
		String url = null;
		url = URLEncoder.encode(disciplineSystem.getAuthorityDatabase(), "UTF-8") + "^" + disciplineSystem.getYear() + "^"
				+ URLEncoder.encode(disciplineSystem.getDiscipline().replaceAll(",", "%320").replace(" ", "%310"), "UTF-8") + "&viewStyle=list" + "&authorityDb="
				+ URLEncoder.encode(disciplineSystem.getAuthorityDatabase(), "UTF-8") + "&subject=" + URLEncoder.encode(disciplineSystem.getDiscipline(), "UTF-8");
		String sortField = "";
		if (null != authorityDbMap && null != disciplineMap) {
			Integer dbId = authorityDbMap.get(disciplineSystem.getAuthorityDatabase());
			Integer subjectId = disciplineMap.get(disciplineSystem.getDiscipline());
			if (null != dbId && null != subjectId) {
				sortField = dbId + "|" + subjectId + "|" + disciplineSystem.getYear();
			}
		}
		if (Comm.subjectNO.contains(disciplineSystem.getAuthorityDatabase())) {
			// 按学科序号排序
			url += "&sort=" + 8 + "&sortField=" + sortField + "&effectSort=8";
		} else if (Comm.eval.contains(disciplineSystem.getAuthorityDatabase().trim().toUpperCase())) {
			// 按评价值排序
			url += "&sort=" + 7 + "&sortField=" + sortField + "&effectSort=7";
		}
		url = "list/result?" + "&queryCdt=shouLuSubjects_3_1_" + url + "&detailYear=" + disciplineSystem.getYear();
		JspWriter out = pageContext.getOut();
		out.println(url);
	}

	public void setDisciplineSystem(DisciplineSystem disciplineSystem) {
		this.disciplineSystem = disciplineSystem;
	}
}
