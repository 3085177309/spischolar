package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.alibaba.druid.util.StringUtils;
import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.service.PurchaseDBServiceI;
import com.wd.comm.Comm;
import com.wd.util.SpringContextUtil;

/**
 * 用户购买的数据库
 * @author Shenfu
 *
 */
public class PurchaseDBTag extends BodyTagSupport{
	
	private Iterator<PurchaseDB> ite;

	private static final long serialVersionUID = 1L;

	@Override
	public int doStartTag() throws JspException {
		OrgBO org = (OrgBO) this.pageContext.getSession().getAttribute(Comm.ORG_SESSION_NAME);
		String orgFlag=null;
		if(org != null){
			orgFlag=org.getFlag();
		}else{
			//获取登录用户所在的机构信息
		}
		if(StringUtils.isEmpty(orgFlag)){
			return SKIP_BODY;
		}
		PurchaseDBServiceI service=SpringContextUtil.getBean(PurchaseDBServiceI.class);
		List<PurchaseDB> list=service.findByOrg(orgFlag);
		if(list == null  || list.size()==0){
			return SKIP_BODY;
		}else{
			this.pageContext.setAttribute("purchaseDb", ite.next());
			return EVAL_BODY_BUFFERED;
		}
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	@Override
	public int doAfterBody() throws JspException {
		if(ite.hasNext()){
			this.pageContext.setAttribute("purchaseDb", ite.next());
			return EVAL_BODY_AGAIN;
		}else{
			return SKIP_BODY;
		}
	}

}
