package com.wd.front.module.ntag;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class BatchIdTag extends SimpleTagSupport{
	
	@Override
	public void doTag() throws JspException, IOException {
		super.getJspContext().getOut().print(UUID.randomUUID());
	}

}
