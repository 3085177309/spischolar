package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.Hot;
import com.wd.comm.Comm;
import com.wd.front.service.SearchLogServiceI;
import com.wd.util.SpringContextUtil;

/**
 * 热门期刊/热搜词
 * @author Shenfu
 *
 */
public class HotTag extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private Integer size;
	
	/**
	 * 分页,在新的一页处会输出newPage=true
	 */
	private Integer page;
	
	private Iterator<Hot> ite;
	
	private int count=0;
	
	private Short type=Hot.TYPE_JOURNAL;

	@Override
	public int doEndTag() throws JspException {
		this.pageContext.removeAttribute("hot");
		this.pageContext.removeAttribute("newPage");
		this.pageContext.removeAttribute("index");
		return EVAL_PAGE;
	}

	@Override
	public int doAfterBody() throws JspException {
		if(ite.hasNext()){
			if(page!=null && count%page==0 && count!=0){
				this.pageContext.setAttribute("newPage", true);
			}
			count++;
			this.pageContext.setAttribute("index", count);
			this.pageContext.setAttribute("hot", ite.next());
			return EVAL_BODY_AGAIN;
		}else{
			ite=null;
			return SKIP_BODY;
		}
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}
}
