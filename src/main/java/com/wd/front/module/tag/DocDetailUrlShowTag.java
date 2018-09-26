package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.front.bo.SearchCondition;
import com.wd.util.SimpleUtil;

/**
 * 获取本系统的文档详细信息的url地址,如果text为null，则输出一个淡出的url地址，如果text不为空，则输出一个a标签
 * 
 * @author pan
 * 
 */
public class DocDetailUrlShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;
	private String text;
	/**
	 * 指定哪个字段为id字段
	 */
	private String idField = "_id";

	@Override
	public void doTag() throws JspException, IOException {
		Object idObj = doc.get(idField);
		if (null == idObj) {
            return;
        }
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		SearchCondition searchCondition = (SearchCondition) request.getAttribute("cdt");
		String siteFlag = (String) request.getAttribute("siteFlag");
		if (SimpleUtil.strIsNull(siteFlag)) {
			return;
		}
		String link = null;
		if (null == searchCondition) {
			if (null == text) {
				link = "detail/result?id=" + idObj.toString();
			} else {
				link = "<a href='detail/result?id=" + idObj.toString() + "'>" + text + "</a>";
			}
		} else {
			if (null == text) {
				link = "detail/result?value=" + URLEncoder.encode(searchCondition.getValue(), "UTF-8") + "&field=" + searchCondition.getField() + "&lan="
						+ searchCondition.getLan() + "&id=" + idObj.toString();
			} else {
				link = "<a href='detail/result?value=" + URLEncoder.encode(searchCondition.getValue(), "UTF-8") + "&field=" + searchCondition.getField() + "&lan="
						+ searchCondition.getLan() + "&id=" + idObj.toString() + "'>" + text + "</a>";
			}
		}
		JspWriter out = pageContext.getOut();
		out.print(link);
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}

	public void setText(String text) {
		this.text = text;
	}

	public void setIdField(String idField) {
		this.idField = idField;
	}
}
