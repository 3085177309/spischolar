package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

import com.wd.backend.model.News;
import com.wd.front.service.NewsServiceI;
import com.wd.util.SpringContextUtil;

/**
 * Top新闻输出标签
 * @author shenfu
 *
 */
public class NewsTag extends BodyTagSupport{
	
	private static final Logger log=Logger.getLogger(NewsTag.class);
	
	private static final long serialVersionUID = 1L;
	
	private Iterator<News> ite;
	
	private Integer top=10;

	@Override
	public int doStartTag() throws JspException {
		NewsServiceI newsService=SpringContextUtil.getApplicationContext().getBean(NewsServiceI.class);
		List<News> list=newsService.findToN(top);
		log.info("共查找到:"+list.size()+"条数据!");
		if(list==null || list.size()==0){
			return SKIP_BODY;
		}else{
			ite=list.iterator();
			this.pageContext.setAttribute("news", ite.next());
			return EVAL_BODY_INCLUDE;
		}
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	@Override
	public int doAfterBody() throws JspException {
		if(ite.hasNext()){
			this.pageContext.setAttribute("news", ite.next());
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
