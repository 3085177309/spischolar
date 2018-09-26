package com.wd.front.module.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.model.Org;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.util.ChineseUtil;
import com.wd.util.GetFirstLetter;
import com.wd.util.SpringContextUtil;
/**
 * 学校首字母排序（手机注册页）
 * @author yang
 *
 */
public class SchoolShowTag extends SimpleTagSupport {

	private static final GetFirstLetter getFirstLetter = new GetFirstLetter();
	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		
		StringBuilder stringBuilder = new StringBuilder();
		
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		OrgInfoServiceI orgService = (OrgInfoServiceI) applicationContext.getBean("orgInfoService");
		List<Org> list=orgService.findAll();
		Collections.sort(list);
		Set<String> tmpSet = new TreeSet<String>();
		Map<String,List> map = new HashMap<String, List>();
		for (Org org : list) {
			String orgName = org.getName();
			String firstLetter = null;
			if (ChineseUtil.isChinese(orgName)) {
				firstLetter = getFirstLetter.getFirstLetter(orgName).toUpperCase();
			} else {
				try {
					firstLetter = orgName.substring(0, 1).toUpperCase();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if("纬度科技".equals(org.getName()) || "临时IP".equals(org.getName()) || "Spis".equals(org.getName())) {
			} else {
				tmpSet.add(firstLetter);
			}
			List<Org> orgList = map.get(firstLetter);
			if(null != orgList) {
				orgList.add(org);
			} else {
				orgList = new ArrayList<Org>();
				orgList.add(org);
			}
			map.put(firstLetter, orgList);
		}
		
		stringBuilder.append("<div class='page out' data-callback='callback' data-params='onpagefirstinto=home&&amp;animationstart=start&amp;animationend=end'>");
		stringBuilder.append("<div class='ui-scroller ui-scroller2'>");
		stringBuilder.append("<div class='scroller-container'>");
		stringBuilder.append("<div style='overflow:auto;height: 100%;'>");
		stringBuilder.append("<header>"
				+ "<div class='headwrap'>"
				+ "<a class='return-back'  href='#pageHome' data-rel='back'>"
				+ "<i class='icon iconfont'>&#xe610;</i>"
				+ "<span>返回</span>"
				+ "</a>"
				+ "<p class='section-tit'>学校选择</p>"
				+ "<div class='clear'></div>"
				+ "</div></header>");
		stringBuilder.append("<div class='item-section'><div class='school-list'>");
		
		
		
		
		if (tmpSet.size() > 0) {
			for (String firstLetter : tmpSet) {
				stringBuilder.append("<p class='list-top-info' id='"+firstLetter+"'>"+firstLetter+"</p>");
				stringBuilder.append("<ul class='school-data-list'>");
				List<Org> orgList = map.get(firstLetter);
				for(Org org : orgList) {
					if("纬度科技".equals(org.getName()) || "临时IP".equals(org.getName())|| "Spis".equals(org.getName())) {
					} else {
					stringBuilder.append("<li><a href='#pageHome' data-rel='back' data-flag='"+org.getFlag()+"' schoolId='"+org.getId()+"'>"+org.getName()+"</a></li>");
					}
				}
				stringBuilder.append("</ul>");
			}
			stringBuilder.append("</div></div></div></div></div>");
			
			//右侧字母
			//stringBuilder.append("<div id='container'>");
			stringBuilder.append("<div class='school-side-chose'><div class='in-side-choose'><div class='table-cell'>");
			for (String firstLetter : tmpSet) {
				stringBuilder.append("<a href='#"+firstLetter+"' data-preventdefault='FUN.schoolScroll'>"+firstLetter+"</a>");
			}
			stringBuilder.append("</div></div></div>");
			stringBuilder.append("</div>");
		}
		
		
		if (stringBuilder.length() > 0) {
			JspWriter out = pageContext.getOut();
			out.println(stringBuilder);
		}
		
	}
}
