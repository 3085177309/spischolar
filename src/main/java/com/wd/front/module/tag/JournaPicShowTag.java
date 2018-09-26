package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 输出刊名图片地址
 * 
 * @author pan
 * 
 */
public class JournaPicShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;
	private static final String default_pic = "resources/images/qk_default.png";

	@Override
	public void doTag() throws JspException, IOException {
		Object pic = doc.get("image");
		String picUrl = "http://img.hnlat.com:8080/image/";
		if (null == pic) {
			picUrl = default_pic;
		} else {
			picUrl += pic.toString();
		}
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		out.println(picUrl);
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
