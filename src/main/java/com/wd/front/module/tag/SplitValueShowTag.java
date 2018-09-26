package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.comm.Comm;
import com.wd.util.SimpleUtil;

/**
 * 展示被特定分隔符分割的文档值
 * 
 * @author pan
 * 
 */
public class SplitValueShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;
	private String field;
	private String splitStr;

	public SplitValueShowTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		Object valObj = doc.get(field + Comm.highlight_field_name_suffix);
		if (null == valObj) {
            valObj = doc.get(field);
        }
		if (null != valObj) {
			String val = valObj.toString();
            String[] arr = val.split(splitStr);
			PageContext pageContext = (PageContext) getJspContext();
			JspWriter out = pageContext.getOut();
			out.print(SimpleUtil.substring(arr[0], arr[0].length()));
		}
	}

	public Map<String, Object> getDoc() {
		return doc;
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getSplitStr() {
		return splitStr;
	}

	public void setSplitStr(String splitStr) {
		this.splitStr = splitStr;
	}
}
