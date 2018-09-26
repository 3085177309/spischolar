package com.wd.front.module.tag;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class FirstLetterNavicationTag extends SimpleTagSupport {

	/**
	 * 1、表示中文首字母 2、表示英文首字母 3、表示oa刊首字母
	 */
	private Integer type;

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String siteFlag = (String) request.getAttribute("siteFlag");
		StringBuilder stringBuilder = new StringBuilder();
		if (type == 1) {
			stringBuilder.append("<a class='in' href='list/result?queryCdt=lan_3_1_" + type + "&viewStyle=list&firstLetter=" + URLEncoder.encode("检索全部中文期刊", "UTF-8")
					+ "&lan=" + type + "'>全部</a>");
		} else if (type == 2) {
			stringBuilder.append("<a class='in' href='list/result?queryCdt=lan_3_1_" + type + "&viewStyle=list&firstLetter=" + URLEncoder.encode("检索全部外文期刊", "UTF-8")
					+ "&lan=" + type + "'>全部</a>");
		} else {
			stringBuilder.append("<a class='in' href='list/result?queryCdt=oa_3_1_1&viewStyle=list&firstLetter="+URLEncoder.encode("检索全部OA期刊", "UTF-8")+"&lan=" + type + "'>全部</a>");
		}
		for (int i = 97; i < 123; i++) {
			char firstLetter = (char) i;
			String tmp = null;
			if (type == 1) {
				tmp = "<a href='list/result?queryCdt=firstLetter_3_1_" + firstLetter + "&queryCdt=lan_3_1_" + type + "&viewStyle=list&firstLetter="
						+ URLEncoder.encode("检索到首字母为“" + new String(firstLetter + "").toUpperCase() + "”的中文期刊", "UTF-8") + "&lan=" + type + "'>" + new String("" + firstLetter).toUpperCase() + "</a>";
			} else if (type == 2) {
				tmp = "<a href='list/result?queryCdt=firstLetter_3_1_" + firstLetter + "&queryCdt=lan_3_1_" + type + "&viewStyle=list&firstLetter="
						+ URLEncoder.encode("检索到首字母为“" + new String(firstLetter + "").toUpperCase() + "”的外文期刊", "UTF-8") + "&lan=" + type + "'>" + new String("" + firstLetter).toUpperCase() + "</a>";
			} else {
				tmp = "<a href='list/result?queryCdt=firstLetter_3_1_" + firstLetter + "&queryCdt=oa_3_1_1&viewStyle=list&firstLetter="
						+ URLEncoder.encode("检索到首字母为“" + new String(firstLetter + "").toUpperCase() + "”的OA期刊", "UTF-8") + "&lan=" + type + "'>" + new String("" + firstLetter).toUpperCase() + "</a>";
			}
			stringBuilder.append(tmp);
		}
		JspWriter out = pageContext.getOut();
		out.println(stringBuilder.toString());
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
