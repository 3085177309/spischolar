package com.wd.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.Client;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.aggregations.AbstractAggregationBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.context.ApplicationContext;

import com.wd.comm.Comm;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchCondition;
import com.wd.front.context.FacetBuilderStrategyContext;
import com.wd.front.context.FilterStrategyContext;
import com.wd.front.context.QueryStrategyContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.module.es.strategy.FacetBuilderStrategyI;

public class SearchRequestUtil {

	private static Logger logger = Logger.getLogger(SearchRequestUtil.class);

	/**
	 * 构建检索请求
	 * 
	 * @param searchCondition
	 * @param queryStrategyContext
	 * @param filterStrategyContext
	 * @param facetBuilderStrategyContext
	 * @param facetComponentNames
	 * @return
	 */
	public static SearchRequestBuilder buildSearchRequest(boolean autoAddDocTypeFieldLan, SearchCondition searchCondition, QueryStrategyContext queryStrategyContext,
			FilterStrategyContext filterStrategyContext, FacetBuilderStrategyContext facetBuilderStrategyContext, List<String> facetComponentNames, boolean onlySearchCount) {
		// 构建query条件
		if (autoAddDocTypeFieldLan) {
			searchCondition.addDocTypeFieldLan();
		}
		QueryBuilder queryBuilder = QueryBuilderUtil.convertQueryBuilder(searchCondition.getQueryCdt(), queryStrategyContext);
		
		// 构建filter条件
		BoolQueryBuilder filterBuilder = FilterBuilderUtil.convert(searchCondition.getFilterMap(), filterStrategyContext);

		// 构建分面条件
		List<AbstractAggregationBuilder> aggregationList = buildFacetCondition(searchCondition, facetBuilderStrategyContext, facetComponentNames);

		Client client = ClientUtil.getClient();
		SearchRequestBuilder searchRequest = client.prepareSearch(Comm.DEFAULT_INDEX).setPreference("_primary_first");
		// 构建排序条件
		if (0 != searchCondition.getSort()) {
			ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
			CacheModuleI cacheModule = (CacheModuleI) applicationContext.getBean("cacheModule");
			Set<String> subjectSortSet = new HashSet<String>();
			Set<String> evalSortSet = new HashSet<String>();
			try {
				subjectSortSet = cacheModule.findAllSortFieldByTypeFromCache("subject_sort_no");
				evalSortSet = cacheModule.findAllSortFieldByTypeFromCache("eval_sort_no");
			} catch (SystemException e) {
				e.printStackTrace();
			}
			switch (searchCondition.getSort()) {
			case 1: {
				searchRequest.addSort("year", SortOrder.ASC);
				break;
			}
			case 2: {
				searchRequest.addSort("year", SortOrder.DESC);
				break;
			}
			case 3: {
				searchRequest.addSort("titleSort", SortOrder.ASC);
				break;
			}
			case 4: {
				searchRequest.addSort("titleSort", SortOrder.DESC);
				break;
			}
			case 5: {
				searchRequest.addSort("clickCount", SortOrder.DESC);
				break;
			}
			case 6: {
				searchRequest.addSort("impactFactor", SortOrder.DESC);
				break;
			}
			case 7: {
				// 按评价值排序
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					if (evalSortSet.contains(searchCondition.getSortField())) {
						searchRequest.addSort("evalSort." + searchCondition.getSortField(), SortOrder.DESC);
					}
				}
				break;
			}
			case 8: {
				// 学科序号排序
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					if (subjectSortSet.contains(searchCondition.getSortField())) {
						searchRequest.addSort("subjectNumSort." + searchCondition.getSortField(), SortOrder.ASC);
					}
				}
				break;
			}
			case 9:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.DESC);
				}
				break;
			}
			case 10:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.ASC);
				}
				break;
			}
			case 11:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					if(searchCondition.getDetailYear()!=null && searchCondition.getDetailYear()>1000){
						searchRequest.addSort("sort." + searchCondition.getSortField()+"|"+searchCondition.getDetailYear(), SortOrder.DESC);
					}else{
						searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.DESC);
					}
				}
			}
			}
		}
		if (onlySearchCount) {
			searchRequest.setSize(0);
		} else {
			searchRequest.setSearchType(SearchType.QUERY_THEN_FETCH);
			searchRequest.setSize(SystemContext.getPageSize());
		}
		int offset = SystemContext.getOffset();
		if (null != searchCondition.getLimit()) {
			// 限制显示记录数
			offset = offset > 40 ? 40 : offset;
		}
		searchRequest.setFrom(offset);
		
		if (null != queryBuilder && null != filterBuilder) {
            searchRequest.setQuery(queryBuilder).setPostFilter(filterBuilder);
        } else if (null != queryBuilder) {
            searchRequest.setQuery(queryBuilder);
        } else if (null != filterBuilder) {
            searchRequest.setPostFilter(filterBuilder);
        }
		for (AbstractAggregationBuilder aggregation : aggregationList) {
			searchRequest.addAggregation(aggregation);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("\r\n检索语句:\r\n" + searchRequest + "\r\n-----------\r\n");
		}

		return searchRequest;
	}
	
	
	/**
	 * 构建检索请求
	 * 
	 * @param searchCondition
	 * @param queryStrategyContext
	 * @param filterStrategyContext
	 * @param facetBuilderStrategyContext
	 * @param facetComponentNames
	 * @return
	 */
	public static SearchRequestBuilder buildSearchRequestForSubject(boolean autoAddDocTypeFieldLan, SearchCondition searchCondition, QueryStrategyContext queryStrategyContext,
			FilterStrategyContext filterStrategyContext, FacetBuilderStrategyContext facetBuilderStrategyContext, List<String> facetComponentNames, boolean onlySearchCount) {
		
		// 构建query条件
		if (autoAddDocTypeFieldLan) {
			searchCondition.addDocTypeFieldLan();
		}
		
		QueryBuilder queryBuilder = QueryBuilderUtil.convertQueryBuilder(searchCondition.getQueryCdt(), queryStrategyContext);

		
		// 构建filter条件
		BoolQueryBuilder filterBuilder = FilterBuilderUtil.convert(searchCondition.getFilterMap(), filterStrategyContext);
		
		// 构建分面条件
		List<AbstractAggregationBuilder> aggregationList = buildFacetCondition(searchCondition, facetBuilderStrategyContext, facetComponentNames);

		Client client = ClientUtil.getClient();
		SearchRequestBuilder searchRequest = client.prepareSearch(Comm.DEFAULT_INDEX).setPreference("_primary_first");
		// 构建排序条件
		if (0 != searchCondition.getSort()) {
			switch (searchCondition.getSort()) {
			case 1: {
				searchRequest.addSort("year", SortOrder.ASC);
				break;
			}
			case 2: {
				searchRequest.addSort("year", SortOrder.DESC);
				break;
			}
			case 3: {
				searchRequest.addSort("titleSort", SortOrder.ASC);
				break;
			}
			case 4: {
				searchRequest.addSort("titleSort", SortOrder.DESC);
				break;
			}
			case 5: {
				searchRequest.addSort("clickCount", SortOrder.DESC);
				break;
			}
			case 6: {
				searchRequest.addSort("impactFactor", SortOrder.DESC);
				break;
			}
			
			case 9:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.DESC);
				}
				break;
			}
			case 10:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.ASC);
				}
				break;
			}
			case 11:{
				if (SimpleUtil.strNotNull(searchCondition.getSortField())) {
					if(searchCondition.getDetailYear()!=null && searchCondition.getDetailYear()>1000){
						searchRequest.addSort("sort." + searchCondition.getSortField()+"|"+searchCondition.getDetailYear(), SortOrder.DESC);
					}else{
						searchRequest.addSort("sort." + searchCondition.getSortField(), SortOrder.DESC);
					}
				}
			}
			}
		}
		if (onlySearchCount) {
			//searchRequest.setSearchType(SearchType.COUNT);
			searchRequest.setSize(0);
		} else {
			searchRequest.setSearchType(SearchType.QUERY_THEN_FETCH);
		}
		int offset = SystemContext.getOffset();
		if (null != searchCondition.getLimit()) {
			// 限制显示记录数
			offset = offset > 40 ? 40 : offset;
		}
		searchRequest.setFrom(offset);
 		searchRequest.setSize(SystemContext.getPageSize());

		if (null != queryBuilder && null != filterBuilder) {
            searchRequest.setQuery(queryBuilder);
        } else if (null != queryBuilder) {
            searchRequest.setQuery(queryBuilder);
        } else if (null != filterBuilder) {
            searchRequest.setPostFilter(filterBuilder);
        }
		for (AbstractAggregationBuilder aggregation : aggregationList) {
			searchRequest.addAggregation(aggregation);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("\r\n检索语句:\r\n" + searchRequest + "\r\n-----------\r\n");
		}

		return searchRequest;
	}

	private static List<AbstractAggregationBuilder> buildFacetCondition(SearchCondition searchCondition, FacetBuilderStrategyContext facetBuilderStrategyContext, List<String> facetComponentNames) {
		List<AbstractAggregationBuilder> aggregationList = new ArrayList<AbstractAggregationBuilder>();
		for (String facetFlag : facetComponentNames) {
			FacetBuilderStrategyI facetStrategy = facetBuilderStrategyContext.getFacetBuilderContext().get(facetFlag);
			if (null == facetStrategy) {
				if (logger.isDebugEnabled()) {
					logger.debug("无法找到与[" + facetFlag + "]对应的分面配置!");
				}
				continue;
			}
			AbstractAggregationBuilder abstractAggregationBuilder = facetStrategy.execute(facetFlag);
			aggregationList.add(abstractAggregationBuilder);
		}
		return aggregationList;
	}

}
