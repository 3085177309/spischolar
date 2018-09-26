package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

import com.wd.backend.model.DisciplineSystem;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.SpringContextUtil;

public class AuthorityDBTag extends BodyTagSupport{
	
	public static final Logger log=Logger.getLogger(AuthorityDBTag.class);

	private static final long serialVersionUID = 1L;
	
	private Iterator<Map.Entry<String, Set<DisciplineSystem>>> ite;

	@Override
	public int doStartTag() throws JspException {
		CacheModuleI cacheModule = SpringContextUtil.getBean(CacheModuleI.class);
		try {
			Map<String, Set<DisciplineSystem>> disciplineSystemMap = cacheModule.loadDisciplineSystemFromCache();
			if(disciplineSystemMap != null && disciplineSystemMap.size()>0){
				ite=disciplineSystemMap.entrySet().iterator();
				return EVAL_BODY_INCLUDE;
			}
		} catch (SystemException e) {
			log.error("获取DisciplineSystem缓存失败!",e);
		}
		return SKIP_BODY;
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	@Override
	public int doAfterBody() throws JspException {
		if(ite.hasNext()){
			Map.Entry<String, Set<DisciplineSystem>> entry=ite.next();
			//String key=entry.getKey();
			this.pageContext.setAttribute("key", entry.getKey());
			this.pageContext.setAttribute("value", entry.getValue());
			return EVAL_BODY_AGAIN;
		}
		return SKIP_BODY;
	}

}
