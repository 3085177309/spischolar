package com.wd.front.service.impl;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.model.Categorydata;
import com.wd.comm.context.SystemContext;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.bo.UniqueList;
import com.wd.front.context.FacetBuilderStrategyContext;
import com.wd.front.context.FilterStrategyContext;
import com.wd.front.context.QueryStrategyContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.SearchServiceI;
import com.wd.util.JournalResultConvertUtil;
import com.wd.util.SearchRequestUtil;
import com.wd.util.SimpleUtil;

/**
 * 期刊详细信息查询
 * 
 * @author pan
 * 
 */
@Service("journalDetailSearchService")
public class JournalDetailSearchService implements SearchServiceI {

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

		SearchCondition idSerchCondition = new SearchCondition();
		idSerchCondition.getQueryCdt().add("id_3_1_" + searchCondition.getId());
		// 主查询
		SearchRequestBuilder mainSearchRequest = SearchRequestUtil.buildSearchRequest(true, idSerchCondition, queryStrategyContext, filterStrategyContext, facetBuilderStrategyContext,
				Collections.EMPTY_LIST, false);

		SearchResponse searchResponse = mainSearchRequest.execute().actionGet();

		// 转换主查询结果
		List<Map<String, Object>> docList = JournalResultConvertUtil.convertDocList(searchResponse);
		searchResult.setDatas(docList);
		searchResult.setTotal(searchResponse.getHits().getTotalHits());

		if (SimpleUtil.collIsNull(docList)) {
			return searchResult;
		}
		// 标题相关查询
		Map<String, Object> doc = docList.get(0);
		Object docTitle = doc.get("docTitle");
		if (null != docTitle ) {

			SearchCondition relatedTitleSearchCondition = new SearchCondition();
			UniqueList queryCdtList = relatedTitleSearchCondition.getQueryCdt();
			queryCdtList.add("relatedDocTitle_3_1_" + docTitle.toString().trim());
			queryCdtList.add("id_2_1_" + searchCondition.getId());

			SystemContext.setPageSize(10);
			SearchRequestBuilder relatedTitleSearchRequest = SearchRequestUtil.buildSearchRequest(true, relatedTitleSearchCondition, queryStrategyContext, filterStrategyContext,
					facetBuilderStrategyContext, Collections.EMPTY_LIST, false);

			SearchResponse relatedTitleSearchResponse = relatedTitleSearchRequest.execute().actionGet();
			List<Map<String, Object>> relatedTitleDocList = JournalResultConvertUtil.convertDocList(relatedTitleSearchResponse);
			Map<String, List<Map<String, Object>>> relatedDatas = new HashMap<String, List<Map<String, Object>>>(1);
			relatedDatas.put("titleRelated", relatedTitleDocList);
			searchResult.setRelatedDatas(relatedDatas);
		}

		return searchResult;
	}

	@Override
	public List<Categorydata> find(String value) {
		return null;
	}
}
