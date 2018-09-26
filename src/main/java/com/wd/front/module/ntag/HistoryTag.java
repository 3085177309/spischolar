package com.wd.front.module.ntag;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.wd.backend.model.History;
import com.wd.backend.model.Member;
import com.wd.comm.Comm;
import com.wd.front.service.HistoryServiceI;
import com.wd.util.SpringContextUtil;

public class HistoryTag extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private Integer systemId;
	
	private Integer size;
	
	private String mobile;
	
	private Iterator<History> ite;
	
	private Integer result;

	@Override
	public int doStartTag() throws JspException {
		HistoryServiceI historyService=SpringContextUtil.getBean(HistoryServiceI.class);
		Member user=(Member)this.pageContext.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user==null){
			return SKIP_BODY;
		}
		List<History> list=historyService.findTopN(size, systemId, user.getId(),1);
		List<History> list2=historyService.findTopN(size, systemId, user.getId(),2);
		
		List<History> list3 = new ArrayList<History>();
		if(list != null && list.size()>0){
			for(int j=0; j< list.size(); j++) {
				list3.add(list.get(j));
				for(int i = 0; i < list2.size(); i++) {
					if(list.get(j).getBatchId().equals(list2.get(i).getBatchId()) && list.get(j).getSystemId().equals(list2.get(i).getSystemId())) {
						list3.add(list2.get(i));
					}
				}
			}
			int a = size;
			while (list3.size() > a) {
				list3.remove(a);
			}
			if(mobile != null && !"".equals(mobile)) {
				ite=list.iterator();
			} else {
				ite=list3.iterator();
			}
			this.pageContext.setAttribute("history", ite.next());
			result = 1;
			return EVAL_BODY_INCLUDE;
		}else{
			this.pageContext.setAttribute("history", null);
			result = 0;
			return EVAL_BODY_INCLUDE;
		}
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	@Override
	public int doAfterBody() throws JspException {
		if(result == 0) {
			return EVAL_BODY_INCLUDE;
		}
		if(ite.hasNext()  && result != 0){
			this.pageContext.setAttribute("history", ite.next());
			return EVAL_BODY_AGAIN;
		}
		return SKIP_BODY;
	}

	public Integer getSystemId() {
		return systemId;
	}

	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	

	

}
