package com.wd.front.service.impl;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.model.Categorydata;
import com.wd.comm.context.SystemContext;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.context.FacetBuilderStrategyContext;
import com.wd.front.context.FilterStrategyContext;
import com.wd.front.context.QueryStrategyContext;
import com.wd.front.service.SearchServiceI;
import com.wd.util.JournalResultConvertUtil;
import com.wd.util.SearchRequestUtil;

/**
 * 学科体系搜索
 * 
 * @author pan
 * 
 */
@Service("subjectSystemSearch")
public class SubjectSystemSearchService implements SearchServiceI {

	private static Logger logger = Logger.getLogger(SubjectSystemSearchService.class);

	@Autowired
	private QueryStrategyContext queryStrategyContext;
	@Autowired
	private FilterStrategyContext filterStrategyContext;
	@Autowired
	private FacetBuilderStrategyContext facetBuilderStrategyContext;

	@Override
	@SuppressWarnings("unchecked")
	public SearchResult search(SearchCondition searchCondition) {

		SearchResult searchResult = new SearchResult();

		searchCondition.getQueryCdt().add("docType_3_1_10");
		SystemContext.setPageSize(5000);
		// 主查询
		SearchRequestBuilder mainSearchRequest = SearchRequestUtil.buildSearchRequest(false, searchCondition, queryStrategyContext, filterStrategyContext, facetBuilderStrategyContext,
				Collections.EMPTY_LIST, false);

		SearchResponse searchResponse = mainSearchRequest.execute().actionGet();

		// 转换主查询结果
		List<Map<String, Object>> docList = JournalResultConvertUtil.convertDocList(searchResponse);
		if (logger.isDebugEnabled()) {
			logger.debug(searchResponse);
		}
		//Collections.sort(docList,new MapComparator());//学科检索两个使用到的地方排序方式不一样。
		searchResult.setDatas(docList);
		searchResult.setTotal(searchResponse.getHits().getTotalHits());

		return searchResult;
	}

	@Override
	public List<Categorydata> find(String value) {
		return null;
	}
}
