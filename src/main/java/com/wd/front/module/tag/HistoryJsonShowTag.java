package com.wd.front.module.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;

public class HistoryJsonShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	@Override
	public void doTag() throws JspException, IOException {
		Object jsonObj = doc.get("historyJson");
		if (null == jsonObj) {
            return;
        }
		@SuppressWarnings("unchecked")
		List<Map<String, String>> jsonList = JsonUtil.json2Obj(jsonObj.toString(), List.class);
		StringBuilder stringBuilder = new StringBuilder();
		for (Map<String, String> jsonMap : jsonList) {
			stringBuilder.append("<tr><td>");
			if (SimpleUtil.strNotNull(jsonMap.get("year"))) {
				stringBuilder.append("(").append(jsonMap.get("year")).append("):");
			}
			if (SimpleUtil.strNotNull(jsonMap.get("name"))) {
				stringBuilder.append(jsonMap.get("name"));
			}
			if (SimpleUtil.strNotNull(jsonMap.get("country"))) {
				stringBuilder.append("(").append(jsonMap.get("country")).append(")");
			}
			if (SimpleUtil.strNotNull(jsonMap.get("issn"))) {
				stringBuilder.append("(").append(jsonMap.get("issn")).append(")");
			}
			stringBuilder.append("</td></tr>");
		}
		if (stringBuilder.length() > 0) {
			PageContext pageContext = (PageContext) getJspContext();
			JspWriter out = pageContext.getOut();
			out.print(stringBuilder.toString());
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
