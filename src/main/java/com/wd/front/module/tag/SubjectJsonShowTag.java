package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.util.JsonUtil;

/**
 * 主题分类
 * 
 * @author pan
 * 
 */
public class SubjectJsonShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	public SubjectJsonShowTag() {
	}

	@Override
	public void doTag() throws JspException, IOException {
		Object jsonObj = doc.get("subjectJson");
		if (null == jsonObj) {
            return;
        }
		@SuppressWarnings("unchecked")
		Map<String, Object> map = JsonUtil.json2Obj(jsonObj.toString(), Map.class);
		StringBuilder stringBuilder = new StringBuilder();
		Set<String> keys = map.keySet();
		for (String key : keys) {
			stringBuilder.append("<tr><td class=\"tr\"><strong>" + key + "</strong></td><td>" + map.get(key) + "</td></tr>");
		}
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		out.print(stringBuilder.toString());
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
