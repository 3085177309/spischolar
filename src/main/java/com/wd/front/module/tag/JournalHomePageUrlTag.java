package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.backend.model.JournalUrl;
import com.wd.util.SimpleUtil;

/**
 * 期刊主页地址
 * 
 * @author pan
 * 
 */
public class JournalHomePageUrlTag extends SimpleTagSupport {

	private Map<String, Object> doc;
	private String text;

	@Override
	public void doTag() throws JspException, IOException {
		String homePage= null;
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		JournalUrl mainLink = (JournalUrl) doc.get("mainLink");
		if(mainLink!=null){
			homePage=mainLink.getTitleUrl();
		}
		if (null != homePage) {
			if (SimpleUtil.strNotNull(text)) {
				out.print("<a onclick='writeLinkLog(this)' field='link' value='"+doc.get("docTitle").toString()+"' target='_blank' href='" + homePage + "'>" + text + "</a>");
			} else {
				out.print(homePage+"\" target=\"_blank");
			}
		}else{
			if (SimpleUtil.strIsNull(text)) {
				out.print("javascript:void(0);");
			}
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}

	public void setText(String text) {
		this.text = text;
	}
}
