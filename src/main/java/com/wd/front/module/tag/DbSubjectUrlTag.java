package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 权威数据库的学科列表页面地址（用于浏览页）
 * 
 * @author pan
 * 
 */
public class DbSubjectUrlTag extends SimpleTagSupport {

	/**
	 * 权威数据库
	 */
	private String db;
	/**
	 * 收录年
	 */
	private int detailYear;

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		if (null == siteFlag) {
            return;
        }
		JspWriter out = pageContext.getOut();
		String url = "subjectList/result?queryCdt=scDB_3_1_" + URLEncoder.encode(db, "UTF-8") + "&queryCdt=scYear_3_1_" + detailYear;
		out.println(url);
	}

	public void setDb(String db) {
		this.db = db;
	}

	public void setDetailYear(int detailYear) {
		this.detailYear = detailYear;
	}

}
