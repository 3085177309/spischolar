package com.wd.front.module.tag;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.util.SimpleUtil;

/**
 * 判断期刊是否有收录
 * 
 * @author pan
 * 
 */
public class HasShouLuTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	private List<String> isShouLu = Arrays.asList("SCI-E", "SSCI", "SJR", "CSCD", "CSSCI", "北大核心");

	@Override
	public void doTag() throws JspException, IOException {
		List<Map<String, Object>> shouLuList = (List<Map<String, Object>>) doc.get("shouLu");
		if (SimpleUtil.collIsNull(shouLuList)) {
			return;
		}
		Set<String> set = new HashSet<String>();
		for (Map<String, Object> singleShouLu : shouLuList) {
			String db = (String) singleShouLu.get("authorityDatabase");
			if (null != db && isShouLu.contains(db.toUpperCase())) {
				set.add(db);
			}
		}
		if (set.isEmpty()) {
			return;
		}
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		getJspBody().invoke(out);
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
