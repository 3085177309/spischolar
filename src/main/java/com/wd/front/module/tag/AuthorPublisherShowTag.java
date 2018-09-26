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

public class AuthorPublisherShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	@Override
	public void doTag() throws JspException, IOException {
		Object publisherJsonObj = doc.get("publisherJson");
		StringBuilder stringBuilder = new StringBuilder();

		appendPublisher(publisherJsonObj, stringBuilder);
		Object publishingJsonObj = appendPublishing(stringBuilder);
		appendAuthor(stringBuilder, publishingJsonObj);

		if (stringBuilder.length() > 0) {
			PageContext pageContext = (PageContext) getJspContext();
			JspWriter out = pageContext.getOut();
			out.print(stringBuilder.toString());
		}
	}

	private void appendPublisher(Object publisherJsonObj, StringBuilder stringBuilder) {
		if (null != publisherJsonObj) {
			Map<String, String> publisherJsonMap = JsonUtil.json2Obj(publisherJsonObj.toString(), Map.class);
			if (SimpleUtil.mapIsNull(publisherJsonMap)) {
				stringBuilder.append("<tbody><tr><th class=\"tl\">商业出版社</th></tr></tbody>");
				stringBuilder.append("<tbody>");
				if (SimpleUtil.strNotNull(publisherJsonMap.get("name"))) {
					stringBuilder.append("<tr><td>").append(publisherJsonMap.get("name")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("company"))) {
					stringBuilder.append("<tr><td>公司:").append(publisherJsonMap.get("company")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("website"))) {
					stringBuilder.append("<tr><td>网站:").append(publisherJsonMap.get("website")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("address"))) {
					stringBuilder.append("<tr><td>地址:").append(publisherJsonMap.get("address")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("phone"))) {
					stringBuilder.append("<tr><td>电话:").append(publisherJsonMap.get("phone")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("email"))) {
					stringBuilder.append("<tr><td>email:").append(publisherJsonMap.get("email")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publisherJsonMap.get("fax"))) {
					stringBuilder.append("<tr><td>传真:").append(publisherJsonMap.get("fax")).append("</td></tr>");
				}
				stringBuilder.append("</tbody>");
			}
		}
	}

	private Object appendPublishing(StringBuilder stringBuilder) {
		Object publishingJsonObj = doc.get("publishingJson");
		if (null != publishingJsonObj) {
			Map<String, String> publishingJsonMap = JsonUtil.json2Obj(publishingJsonObj.toString(), Map.class);
			if (SimpleUtil.mapIsNull(publishingJsonMap)) {
				stringBuilder.append("<tbody><tr><th class=\"tl\">商业出版社（订阅）</th></tr></tbody>");
				stringBuilder.append("<tbody>");
				if (SimpleUtil.strNotNull(publishingJsonMap.get("address"))) {
					stringBuilder.append("<tr><td>地址:").append(publishingJsonMap.get("address")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publishingJsonMap.get("phone"))) {
					stringBuilder.append("<tr><td>电话:").append(publishingJsonMap.get("phone")).append("</td></tr>");
				}
				if (SimpleUtil.strNotNull(publishingJsonMap.get("company"))) {
					stringBuilder.append("<tr><td>公司:").append(publishingJsonMap.get("company")).append("</td></tr>");
				}
				stringBuilder.append("</tbody>");
			}
		}
		return publishingJsonObj;
	}

	private void appendAuthor(StringBuilder stringBuilder, Object publishingJsonObj) {
		Object authorsJsonObj = doc.get("authorsJson");
		if (null != authorsJsonObj) {
			List<Map<String, String>> publishingJsonList = JsonUtil.json2Obj(authorsJsonObj.toString(), List.class);
			if (SimpleUtil.collNotNull(publishingJsonList)) {
				stringBuilder.append("<tbody><tr><th class=\"tl\">公司作者</th></tr></tbody>");
				stringBuilder.append("<tbody>");
				for (Map<String, String> map : publishingJsonList) {
					if (SimpleUtil.strNotNull(map.get("name"))) {
						stringBuilder.append("<tr><td>").append(map.get("name")).append("</td></tr>");
					}
					if (SimpleUtil.strNotNull(map.get("website"))) {
						stringBuilder.append("<tr><td>网站:").append(map.get("website")).append("</td></tr>");
					}
					if (SimpleUtil.strNotNull(map.get("email"))) {
						stringBuilder.append("<tr><td>email:").append(map.get("email")).append("</td></tr>");
					}
					if (SimpleUtil.strNotNull(map.get("fax"))) {
						stringBuilder.append("<tr><td>传真:").append(map.get("fax")).append("</td></tr>");
					}
					if (SimpleUtil.strNotNull(map.get("address"))) {
						stringBuilder.append("<tr><td>地址:").append(map.get("address")).append("</td></tr>");
					}
					if (SimpleUtil.strNotNull(map.get("phone"))) {
						stringBuilder.append("<tr><td>电话:").append(map.get("phone")).append("</td></tr>");
					}
				}
				stringBuilder.append("</tbody>");
			}
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
