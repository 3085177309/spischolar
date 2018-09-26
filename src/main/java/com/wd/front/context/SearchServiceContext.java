package com.wd.front.context;

import java.util.HashMap;
import java.util.Map;

import com.wd.front.service.SearchServiceI;

public class SearchServiceContext {

	private Map<String, SearchServiceI> searchServiceContext = new HashMap<String, SearchServiceI>();

	public SearchServiceContext() {
	}

	public SearchServiceI findSearchServiceImpl(String strategyFlag) {
		return searchServiceContext.get(strategyFlag.trim());
	}

	public Map<String, SearchServiceI> getSearchServiceContext() {
		return searchServiceContext;
	}

	public void setSearchServiceContext(Map<String, SearchServiceI> searchServiceContext) {
		this.searchServiceContext = searchServiceContext;
	}
}
