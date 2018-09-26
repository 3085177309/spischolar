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

/**
 * 用来对abstractjson和onlines进行展示
 * 
 * <pre>
 * 	输出格式：
 * <tr>
 * 		<td class="tr"><strong>Copyright Clearance Center</strong></td>
 * 		<td>
 * 			<ul>
 * 				<li><a href="#">Get It Now, 1969-</a></li>
 * 				<li><a href="#">Get It Now - International Schools Only</a></li>
 * 			</ul>
 * 		</td>
 * 	</tr>
 * </pre>
 * 
 * @author pan
 * 
 */
public class AbstractOnlinesJsonShowTag extends SimpleTagSupport {

	private Map<String, Object> doc;
	private String field;

	@Override
	public void doTag() throws JspException, IOException {
		super.doTag();
		Object jsonObj = doc.get(field);
		if (null == jsonObj) {
            return;
        }
		List<Map<String, Object>> jsonList = JsonUtil.json2Obj(jsonObj.toString(), List.class);
		StringBuilder stringBuilder = new StringBuilder();
		for (Map<String, Object> jsonMap : jsonList) {
			stringBuilder.append("<tr>");
			stringBuilder.append("<td class=\"tr\"><strong>" + jsonMap.get("name").toString() + "</strong></td>");
			List<Map<String, String>> list = (List<Map<String, String>>) jsonMap.get("groups");
			stringBuilder.append("<td>");
			if (SimpleUtil.collNotNull(list)) {
				stringBuilder.append("<ul>");
				for (Map<String, String> detailMap : list) {
					if (null != detailMap) {
						String detailName = detailMap.get("name");
						String detailYear = detailMap.get("years");
						if (SimpleUtil.strNotNull(detailName)) {
							stringBuilder.append("<li>");
							if (null != detailYear) {
								stringBuilder.append(detailName + "&nbsp;&nbsp;" + detailYear);
							} else {
								stringBuilder.append(detailName);
							}
							stringBuilder.append("</li>");
						}
					}
				}
				stringBuilder.append("</ul>");
			}
			stringBuilder.append("</td>");
			stringBuilder.append("</tr>");
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

	public void setField(String field) {
		this.field = field;
	}
}
