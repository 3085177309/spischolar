package com.wd.front.module.tag;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.Product;
import com.wd.comm.Comm;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.SpringContextUtil;

/**
 * 检测购买的产品,如果购买了就显示标签内容
 * @author Administrator
 *
 */
public class CheckPurchasedTag extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private Integer pid;
	
	@Override
	public int doStartTag() throws JspException {
		if(pid==null){
			return SKIP_BODY;
		}
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
		OrgBO org = (OrgBO) this.pageContext.getSession().getAttribute(Comm.ORG_SESSION_NAME);
		String orgFlag=org.getFlag();
		List<Product> products=cacheModule.getOrgProductList(orgFlag);
		for(Product p:products){
			if(p.getProductId().intValue()==pid.intValue()){
				return EVAL_BODY_INCLUDE;
			}
		}
		return SKIP_BODY;
	}
	
	@Override
	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}

	@Override
	public int doAfterBody() throws JspException {
		return SKIP_BODY;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

}
