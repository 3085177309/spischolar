package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.wd.backend.model.DocDelivery;
import com.wd.backend.model.Member;
import com.wd.comm.Comm;
import com.wd.front.service.DocDiliveryServiceI;
import com.wd.util.SpringContextUtil;

/**
 * 文献传递标签
 * @author Administrator
 *
 */
public class DocDeliveryTag extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private Iterator<DocDelivery> ite;
	
	private Integer top;
	
	private Integer result;

	@Override
	public int doStartTag() throws JspException {
		DocDiliveryServiceI service=SpringContextUtil.getBean(DocDiliveryServiceI.class);
		Member user=(Member)this.pageContext.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user == null){
			return SKIP_BODY;
		}
		List<DocDelivery> list=service.findTopN(user.getId(),top);
		if(list==null || list.size()==0){
			this.pageContext.setAttribute("delivery", null);
			result = 0;
			return EVAL_BODY_INCLUDE;
		}else{
			result =1;
			ite=list.iterator();
			this.pageContext.setAttribute("delivery", ite.next());
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
		if(ite.hasNext() && result != 0){
			this.pageContext.setAttribute("delivery", ite.next());
			return EVAL_BODY_AGAIN;
		}
		return SKIP_BODY;
	}

	public Integer getTop() {
		return top;
	}

	public void setTop(Integer top) {
		this.top = top;
	}


}
