package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 获取机构标识
 * 
 * @author pan
 * 
 */
public class GetOrgFlagTag extends SimpleTagSupport {

	public GetOrgFlagTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String orgFlag = (String) request.getAttribute("orgFlag");
		pageContext.getOut().print(orgFlag);
	}
}
