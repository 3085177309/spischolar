package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class CmsUrl extends SimpleTagSupport {

	private String value;

	@Override
	public void doTag() throws JspException, IOException {
		if (null != value) {
            super.getJspContext().getOut().print(URLEncoder.encode(value, "UTF-8"));
        }
	}

	public void setValue(String value) {
		this.value = value;
	}
}
