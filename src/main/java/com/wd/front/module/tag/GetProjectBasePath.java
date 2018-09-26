package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 获取项目根路径
 * 
 * @author pan
 * 
 */
public class GetProjectBasePath extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		String path = request.getContextPath();
		// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		pageContext.getOut().print(basePath);
	}
}
