package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 获取浏览页地址
 * 
 * @author pan
 * 
 */
public class OverviewPageShowTag extends SimpleTagSupport {

	private String text;

	public OverviewPageShowTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		if (null != text) {
			out.print("<a href='overview'>" + text + "</a>");
		} else {
			out.print("overview");
		}
	}

	public void setText(String text) {
		this.text = text;
	}
}
