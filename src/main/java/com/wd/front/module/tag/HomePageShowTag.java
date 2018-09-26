package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 获取站点首页,如果text有值，则打印一个a标签，如果text没值，则直接返回链接地址
 * 
 * @author pan
 * 
 */
public class HomePageShowTag extends SimpleTagSupport {

	private String text;

	public HomePageShowTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		if (null == siteFlag) {
			return;
		}
		JspWriter out = pageContext.getOut();
		if (null != text) {
			out.print("<a href=''>" + text + "</a>");
		} else {
			out.print("");
		}
	}

	public void setText(String text) {
		this.text = text;
	}
}
