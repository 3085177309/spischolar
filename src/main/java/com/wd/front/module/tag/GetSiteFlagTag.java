package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.comm.Comm;

public class GetSiteFlagTag extends SimpleTagSupport {

	public GetSiteFlagTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute(Comm.SITE_FLAG_NAME);
		pageContext.getOut().print(siteFlag);
	}
}
