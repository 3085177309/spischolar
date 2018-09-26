package com.wd.front.service;

import java.util.Map;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.index.query.QueryBuilder;

import com.alibaba.fastjson.JSONArray;

/**
 * 期刊详情服务
 * @author Administrator
 *
 */
public interface DetailServiceI {
	
	public Map<String, Object> getDoc(String id);

	public SearchResponse getDoc(QueryBuilder queryBuilder);

	
}
