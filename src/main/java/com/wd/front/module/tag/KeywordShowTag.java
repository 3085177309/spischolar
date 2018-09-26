package com.wd.front.module.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.springframework.context.ApplicationContext;

import com.wd.backend.model.AuthorityDatabase;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.ChineseUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;

public class KeywordShowTag extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		SearchResult searchResult = (SearchResult) request.getAttribute("searchResult");
		ApplicationContext context = SpringContextUtil.getApplicationContext();
		CacheModuleI cacheModule = (CacheModuleI) context.getBean("cacheModule");
		List<AuthorityDatabase> authorityDatabases = null;
		try {
			authorityDatabases = cacheModule.findDbPartitionFromCache();
		} catch (SystemException e) {
			e.printStackTrace();
		}

		SearchCondition searchCondition = (SearchCondition) request.getAttribute("cdt");
		if (null == searchCondition) {
            return;
        }
		AuthorityDatabase authorityDatabase = find(authorityDatabases, searchCondition.getAuthorityDb());
		String prefix = null;
		String stuffix = null;
		if (null != authorityDatabase) {
			prefix = authorityDatabase.getPrefix();
			stuffix = authorityDatabase.getSuffix();
		}
		prefix = prefix == null ? "" : prefix;
		stuffix = stuffix == null ? "" : stuffix;
		JspWriter out = pageContext.getOut();
		if (!SimpleUtil.strIsNull(searchCondition.getAuthorityDb())) {
			String version = null != searchCondition.getDetailYear() ? "(" + searchCondition.getDetailYear() + ")" : "";
			if("CSSCI".equals(searchCondition.getAuthorityDb())){
				if (searchCondition.getDetailYear() == 2018){
					version="("+ (searchCondition.getDetailYear()-1)+"-"+ searchCondition.getDetailYear() + ")";
				} else {
					version="("+ (searchCondition.getDetailYear()-2)+"-"+ searchCondition.getDetailYear() + ")";
				}
			}
			if (SimpleUtil.strNotNull(searchCondition.getPartition())) {
				if ("SJR".equals(searchCondition.getAuthorityDb())) {
					out.print("SCOPUS" + version + " --> " + searchCondition.getSubject() + " &nbsp;" + prefix + searchCondition.getPartition() + stuffix + " &nbsp;"
							+ pageContext.getAttribute("total") + "本期刊");
				} else {
					out.print(searchCondition.getAuthorityDb() + version + " --> " + searchCondition.getSubject() + " &nbsp;" + prefix + searchCondition.getPartition() + stuffix
							+ " &nbsp;" + pageContext.getAttribute("total") + "本期刊");
				}
			} else {
				if ("SJR".equals(searchCondition.getAuthorityDb())) {
					out.print("SCOPUS" + version + " --> " + searchCondition.getSubject() + " " + pageContext.getAttribute("total") + "本期刊");
				} else {
					out.print(searchCondition.getAuthorityDb() + version + " --> " + searchCondition.getSubject() + " " + pageContext.getAttribute("total") + "本期刊");
				}
			}
		} else if (SimpleUtil.strNotNull(searchCondition.getFirstLetter())) {
			out.print(searchCondition.getFirstLetter() + pageContext.getAttribute("total") + "本");
		} else {
			String val = searchCondition.getValue();
			if (ChineseUtil.isChinese(val)) {
				if (val.length() > 30) {
					val = val.substring(0, 30) + "...";
				}
			} else {
				if (val.length() > 50) {
					val = val.substring(0, 50) + "...";
				}
			}
			long time = 0;
			if (null != searchResult) {
				time = searchResult.getTime();
			}
			out.print("检索“" + val + "”找到" + pageContext.getAttribute("total") + "本期刊 （用时" + (time / (float) 1000) + " 秒）");
		}
	}

	public AuthorityDatabase find(List<AuthorityDatabase> authorityDatabases, String dbName) {
		if (null == authorityDatabases) {
            return null;
        }
		for (AuthorityDatabase database : authorityDatabases) {
			if (database.getFlag().equals(dbName)) {
				return database;
			}
		}
		return null;
	}
}
