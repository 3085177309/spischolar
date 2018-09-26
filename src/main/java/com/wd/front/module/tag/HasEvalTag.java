package com.wd.front.module.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.util.SimpleUtil;

/**
 * 判断期刊是否有评价
 * 
 * @author pan
 * 
 */
public class HasEvalTag extends SimpleTagSupport {

	private Map<String, Object> doc;

	@Override
	public void doTag() throws JspException, IOException {
		List<Map<String, Object>> shouLuList = (List<Map<String, Object>>) doc.get("shouLu");
		if (SimpleUtil.collIsNull(shouLuList)) {
			return;
		}
		boolean hasShouLu = false;
		for (Map<String, Object> singleShouLu : shouLuList) {
			List<Map<String, Object>> mutilYearShouLu = (List<Map<String, Object>>) singleShouLu.get("detailList");
			if (!SimpleUtil.collIsNull(mutilYearShouLu)) {
				for (Map<String, Object> yearShouLu : mutilYearShouLu) {
					String detail = (String) yearShouLu.get("detail");
                    String[] mutilDetail = detail.split(";");
					for (String singleDetial : mutilDetail) {
						if (SimpleUtil.strNotNull(singleDetial)) {
                            String[] tmpArr = singleDetial.split("\\^");
							if (tmpArr.length == 5) {
								if (SimpleUtil.strNotNull(tmpArr[4])) {
									hasShouLu = true;
								}
							}
						}
					}
				}
			}
		}
		if (hasShouLu) {
			PageContext pageContext = (PageContext) getJspContext();
			JspWriter out = pageContext.getOut();
			getJspBody().invoke(out);
		}
	}

	public void setDoc(Map<String, Object> doc) {
		this.doc = doc;
	}
}
