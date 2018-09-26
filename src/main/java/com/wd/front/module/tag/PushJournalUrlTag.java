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
 * 推送列表地址（用于首页）
 * 
 * @author pan
 * 
 */
public class PushJournalUrlTag extends SimpleTagSupport {

	private DisciplineSystem disciplineSystem;
	/**
	 * 1、表示点击量最多的期刊 2、表示最有影响的期刊
	 */
	private String type;
	private static final String hot = "1";
	@SuppressWarnings("unused")
	private static final String authority = "2";

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		if (null == siteFlag) {
			return;
		}

		String url = null;
		if (hot.equals(type.trim())) {
			url = "hotList/list?detailYear=" + disciplineSystem.getYear() + "&authorityDb=" + URLEncoder.encode(disciplineSystem.getAuthorityDatabase(), "UTF-8")
					+ "&subject=" + URLEncoder.encode(disciplineSystem.getDiscipline(), "UTF-8") + "&sort=5";
		} else {
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
			String sortField = "";
			if (null != authorityDbMap && null != disciplineMap) {
				Integer dbId = authorityDbMap.get(disciplineSystem.getAuthorityDatabase());
				Integer subjectId = disciplineMap.get(disciplineSystem.getDiscipline());
				if (null != dbId && null != subjectId) {
					sortField = dbId + "|" + subjectId + "|" + disciplineSystem.getYear();
				}
			}
			String sort = "";
			if (Comm.subjectNO.contains(disciplineSystem.getAuthorityDatabase())) {
				// 按学科序号排序
				sort += "&sort=" + 8 + "&sortField=" + sortField + "&effectSort=8";
			} else if (Comm.eval.contains(disciplineSystem.getAuthorityDatabase().toUpperCase())) {
				// 按评价值排序
				sort += "&sort=" + 7 + "&sortField=" + sortField + "&effectSort=7";
			}
			String key = URLEncoder.encode(disciplineSystem.getAuthorityDatabase(), "UTF-8") + "^" + disciplineSystem.getYear() + "^"
					+ URLEncoder.encode(disciplineSystem.getDiscipline().replaceAll(",", "%320"), "UTF-8");
			url = "authorityList/list?" + "&queryCdt=shouLuSubjects_3_1_" + key + sort;
		}
		JspWriter out = pageContext.getOut();
		out.println(url);
	}

	public void setDisciplineSystem(DisciplineSystem disciplineSystem) {
		this.disciplineSystem = disciplineSystem;
	}

	public void setType(String type) {
		this.type = type;
	}
}
