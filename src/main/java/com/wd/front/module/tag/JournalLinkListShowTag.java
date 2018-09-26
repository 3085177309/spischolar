package com.wd.front.module.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import net.sf.json.JSONArray;

import com.wd.backend.bo.LatSourceIndentifier;
import com.wd.front.bo.SearchCondition;

public class JournalLinkListShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	@SuppressWarnings({ "unchecked", "deprecation" })
	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		Object articleUrl = doc.get("url");
		SearchCondition cdt = (SearchCondition) request.getAttribute("cdt");
		JSONArray array = JSONArray.fromObject(articleUrl);
		List<LatSourceIndentifier> list = JSONArray.toList(array, LatSourceIndentifier.class);
		JspWriter out = pageContext.getOut();
		Object homePage = doc.get("homePage");
		if (null != homePage) {
			out.print("<li><a onclick='writeLinkLog(this)' field='link' value='"+doc.get("docTitle").toString()+"' target='_blank' href='" + homePage.toString() + "'>主页地址</a></li>");
		}
		if (!list.isEmpty()) {
			for (LatSourceIndentifier latSourceIndentifier : list) {
				if (-1 == latSourceIndentifier.getSource()) {

				} else {
					/*
					List<LinkRule> rules = org.getDbRules().get(latSourceIndentifier.getSource());
					if (null != rules) {
						for (LinkRule linkRule : rules) {
							String ruleStr = linkRule.getLinkRule();
							String url = null;
							if (SimpleUtil.strIsNull(ruleStr) || SimpleUtil.strIsNull(latSourceIndentifier.getParam())) {
								url = latSourceIndentifier.getExtParam();
							} else {
								url = ruleStr.replace("[key]", latSourceIndentifier.getParam().replace("key=", ""));
							}
							out.print("<li><a href='javascript:return false;' onclick=\"latWinOpen('" + url + "',this)\" field='link' value='"+doc.get("docTitle").toString()+"'>" + linkRule.getName() + "</a></li>");
						}
					}*/
				}
			}
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
