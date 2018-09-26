package com.wd.front.module.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.util.ChineseUtil;
import com.wd.util.SimpleUtil;

/**
 * 显示简短标题
 * 
 * @author pan
 * 
 */
public class ShortTitleShowTag extends SimpleTagSupport {

	private Object title;

	@Override
	public void doTag() throws JspException, IOException {
		if (SimpleUtil.stringObjNotNull(title)) {
			String titleStr = title.toString();
			if (ChineseUtil.isChinese(titleStr) && titleStr.length() > 9) {
				// 中文显示9个字
				titleStr = titleStr.substring(0, 9);
			} else {
				// 英文最少显示3个单词，如果三个单词的长度不超过20，则新增加单词的显示数量，直到单词长度超过20个
                String[] arr = titleStr.split("[ ]+");
				if (arr.length > 3) {
					String tmp = arr[0] + arr[1] + arr[2] + arr[3];
					if (tmp.length() > 20) {
						titleStr = arr[0] + " " + arr[1] + " " + arr[2];
					} else {
						titleStr = arr[0] + " " + arr[1] + " " + arr[2] + " " + arr[3];
					}
				}
			}
			PageContext pageContext = (PageContext) getJspContext();
			pageContext.getOut().print(titleStr);
		}
	}

	public void setTitle(Object title) {
		this.title = title;
	}
}
