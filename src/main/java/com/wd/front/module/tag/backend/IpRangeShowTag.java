package com.wd.front.module.tag.backend;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.wd.backend.model.Org;
import com.wd.util.SimpleUtil;

/**
 * 用于后台输出ip范围
 * 
 * @author pan
 * 
 */
public class IpRangeShowTag extends SimpleTagSupport {

	private Org org;

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		JspWriter out = pageContext.getOut();
		if (null != org) {
			String ipRanges = org.getIpRanges();
			if (SimpleUtil.strNotNull(ipRanges)) {
                String[] ipRangesArr = ipRanges.split(";");
				for (String ipRange : ipRangesArr) {
					String content = "<div><strong>" + ipRange + "</strong><button class=\"btn btn-mini btn-warning\" onclick=\"removeIpRange(this)\">删除</button></div>";
					out.println(content);
				}
			}
		}
	}

	public void setOrg(Org org) {
		this.org = org;
	}
}
