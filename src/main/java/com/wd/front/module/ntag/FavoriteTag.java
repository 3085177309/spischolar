package com.wd.front.module.ntag;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.springframework.beans.factory.annotation.Autowired;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.JournalImage;
import com.wd.backend.model.JournalUrl;
import com.wd.backend.model.Member;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.bo.ShouluMap;
import com.wd.front.service.DetailServiceI;
import com.wd.front.service.FavoriteServiceI;
import com.wd.front.service.JournalImageServiceI;
import com.wd.front.service.JournalLinkServiceI;
import com.wd.util.DetailParserUtil;
import com.wd.util.SpringContextUtil;

/**
 * 收藏
 * @author Administrator
 *
 */
public class FavoriteTag extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private Iterator<Favorite> ite;
	
	private Integer top;
	
	private Integer type;
	
	private Integer result;

	@Override
	public int doStartTag() throws JspException {
		FavoriteServiceI service=SpringContextUtil.getBean(FavoriteServiceI.class);
		Member user=(Member)this.pageContext.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user == null){
			return SKIP_BODY;
		}
		List<Favorite> list=service.findTopN(top,user.getId(),type);
		if(type == 2 && list.size()>0) {
			findJournal(list);
		}
		if(list==null || list.size()==0){
			String favorite = null;
			this.pageContext.setAttribute("favoriteIndex", favorite);
			result = 0;
			return EVAL_BODY_INCLUDE;
			//return SKIP_BODY;
		}else{
			result =1;
			ite=list.iterator();
			this.pageContext.setAttribute("favoriteIndex", ite.next());
			return EVAL_BODY_INCLUDE;
		}
	}
	
	public void findJournal(List<Favorite> list) {
		DetailServiceI detailService=SpringContextUtil.getBean(DetailServiceI.class);
		if(list == null || list.size() == 0) {
            return;
        }
		for(int i=0;i<list.size();i++) {
			Favorite favorite = list.get(i);
			String id = favorite.getDocId();
			Map<String, Object> doc=detailService.getDoc(id);
			/*JournalUrl mainLink = journalLinkService.searchMainLink(id);
			doc.put("mainLink", mainLink);
			List<JournalUrl> list = journalLinkService.searchDbLinks(id);
			doc.put("dbLinks", list);
			JournalImage jImage = journalImageService.findImage(id);
			if(jImage!=null&&jImage.getLogo()!=null){
				if(jImage.getLogo().length>0){
					doc.put("jImage", jImage);
				}
			}
			try {
				Map<String,ShouluMap> map = DetailParserUtil.parseShoulu((List<Map<String, Object>>) doc.get("shouLu"));
				favorite.setShoulu(map);
			} catch (SystemException e) {
				e.printStackTrace();
			}*/
			favorite.setDocJournal(doc);
			list.set(i, favorite);
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
			this.pageContext.setAttribute("favoriteIndex", ite.next());
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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}
