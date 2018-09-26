package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 获取文章检索首页地址
 * 
 * @author pan
 * 
 */
public class ArticleIndexPageUrlTag extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		String url = "docIndex";
		pageContext.getOut().print(url);
	}
}
