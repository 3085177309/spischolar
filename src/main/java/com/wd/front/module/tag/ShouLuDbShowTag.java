package com.wd.front.module.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.comm.Comm;

/**
 * 期刊被哪些数据库收录（用于列表页）
 * 
 * @author pan
 * 
 */
public class ShouLuDbShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	@SuppressWarnings("unchecked")
	@Override
	public void doTag() throws JspException, IOException {
		List<Map<String, Object>> shouLuList = (List<Map<String, Object>>) doc.get("shouLu");
		if (null == shouLuList) {
            return;
        }
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < shouLuList.size(); i++) {
			Map<String, Object> shouluInfo = shouLuList.get(i);
			if (!Comm.isShouLu.contains(shouluInfo.get("authorityDatabase").toString().toUpperCase())) {
				continue;
			}
			if ("SJR".equals(shouluInfo.get("authorityDatabase"))) {
				stringBuilder.append("SCOPUS").append("、");
			} else {
				stringBuilder.append(shouluInfo.get("authorityDatabase")).append("、");
			}
		}
		int pos = stringBuilder.lastIndexOf("、");
		if (pos > 0) {
			stringBuilder.delete(pos, stringBuilder.length());
		}
		if (stringBuilder.length() > 0) {
			PageContext pageContext = (PageContext) getJspContext();
			JspWriter out = pageContext.getOut();
			stringBuilder.insert(0, "<li><strong>收录：</strong>");
			stringBuilder.append("</li>");
			out.println(stringBuilder.toString());
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
