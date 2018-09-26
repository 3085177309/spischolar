package com.wd.front.service;

import java.util.List;

import com.wd.backend.model.Categorydata;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;

public interface SearchServiceI {

	SearchResult search(SearchCondition searchCondition);
	
	/**
	 * 去数据库获取云空间接口所需数据
	 * @param value
	 * @return
	 */
	public List<Categorydata> find(String value);
	
}
