package com.wd.browse.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.wd.backend.model.AuthorityDatabase;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.bo.UniqueList;
import com.wd.front.context.SearchServiceContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.SearchServiceI;
import com.wd.util.MatchUtil;

@Component
public class ESSearchService {
	
	@Autowired
	private SearchServiceContext searchServiceContext;
	
	@Autowired
	private CacheModuleI cacheModule;
	
	/**
	 * 获取学科分类下的数据
	 */
	public Map<String,Object> getSubject(String url)  throws Exception {
		Map<String,Object> data = new HashMap<String, Object>();
		String pattern = ".*journal/subject\\/";
		url = url.replaceAll(pattern, "");
		SearchCondition condition =new SearchCondition();
		String[] dbs = {"SCI-E","中科院JCR分区(小类)","中科院JCR分区(大类)","CSCD","Eigenfactor","CSSCI","北大核心","SSCI","SCOPUS","ESI"};
		String[] subjectNames = {"人文社科类","理学","工学","农学","医学","综合"};
		
		int subjectNameId = Integer.parseInt(url.substring(0, 1));
		int id =  Integer.parseInt(url.substring(2, url.length()-5));
		String db = dbs[id-1];
		String subjectName = subjectNames[subjectNameId-1];
		String year = url.substring(url.length()-4, url.length());
		
		condition.setSearchComponentFlag("subject_system_search");
		condition.addQueryCdt("scSName_3_1_"+subjectName);
		condition.addQueryCdt("scDB_3_1_"+db);
		condition.addQueryCdt("scYear_3_1_"+year);
		
		SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
		SearchResult result=searchService.search(condition);
		List<Map<String,Object>> list = result.getDatas();
		String discipline = null,name = null;
		if(list != null && list.size()>0) {
			Map<String,Object> map = list.get((int) (Math.random()*list.size()));
			discipline = map.get("discipline").toString();
			name = map.get("name").toString();
		}
		url = "http://www.spischolar.com/journal/category/list?queryCdt=shouLuSubjects_3_1_"
				+db+"^"+year+"^"+discipline +"&viewStyle=list&authorityDb="+db+"&subject="
				+discipline+"&sort=11&detailYear="+year;
		data.put("url", url);
		data.put("name", db + " " + name + " (" + year + ")");
		data.put("db", db);
		return data;
	}
	
	/**
	 * 搜索期刊(列表)
	 * @param value
	 */
	public SearchResult searchJournal(String value)  throws Exception {
		SearchCondition condition =new SearchCondition();
		condition.setSearchComponentFlag("journal_search");
		condition.setValue(value);
		SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
		SearchResult searchResult = searchService.search(condition);
		return searchResult;
	}
	
	/**
	 * 浏览期刊（列表）
	 * @param url
	 * @throws SystemException
	 */
	public SearchResult categoryJournal(String url)  throws Exception {
		String detailYear = MatchUtil.getMatcher(url, "&detailYear=\\d+").replace("&detailYear=", "");
		String sort = MatchUtil.getMatcher(url, "&sort=.*&detailYear").replace("&sort=", "").replace("&detailYear", "");
		String subject = MatchUtil.getMatcher(url, "&subject=.*&sort").replace("&subject=", "").replace("&sort", "");
		String authorityDb = MatchUtil.getMatcher(url, "&authorityDb=.*&subject").replace("&authorityDb=", "").replace("&subject", "");
		String viewStyle = MatchUtil.getMatcher(url, "&viewStyle=.*&authorityDb").replace("&viewStyle=", "").replace("&authorityDb", "");
		String queryCdt = MatchUtil.getMatcher(url, "queryCdt=.*&viewStyle").replace("queryCdt=", "").replace("&viewStyle", "");
		UniqueList queryCdts = new UniqueList();
		queryCdts.add(queryCdt);
		SearchCondition condition =new SearchCondition();
		List<AuthorityDatabase> dbs;
		try {
			dbs = cacheModule.findDbPartitionFromCache();
			for(AuthorityDatabase db :dbs){
				if(db.getFlag().equals(authorityDb)){
					if(condition.getSort()==11){
						condition.setSortField(db.getId()+"");
					}
				}
			}
		} catch (SystemException e) {
			e.printStackTrace();
		}
		condition.setSearchComponentFlag("journal_search");
		condition.setAuthorityDb(authorityDb);
		condition.setSort(Integer.parseInt(sort));
		condition.setQueryCdt(queryCdts);
		condition.setSortField("");
		condition.setDetailYear(Integer.parseInt(detailYear));
		condition.setDocType(0);
		condition.setLan(0);
		condition.setSearchType(0);
		condition.setSubject(subject);
		condition.setViewStyle(viewStyle);
		SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
		SearchResult searchResult = searchService.search(condition);
		return searchResult;
	}

	public SearchServiceContext getSearchServiceContext() {
		return searchServiceContext;
	}

	public void setSearchServiceContext(SearchServiceContext searchServiceContext) {
		this.searchServiceContext = searchServiceContext;
	}

	public CacheModuleI getCacheModule() {
		return cacheModule;
	}

	public void setCacheModule(CacheModuleI cacheModule) {
		this.cacheModule = cacheModule;
	}

}
