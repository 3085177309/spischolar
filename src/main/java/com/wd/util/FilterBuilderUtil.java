package com.wd.util;

import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;

import com.wd.front.context.FilterStrategyContext;
import com.wd.front.module.es.strategy.FilterBuilderStrategyI;

/**
 * 将map转换为FilterBuilder
 * 
 * @author pan
 * 
 */
public class FilterBuilderUtil {

	private static Logger logger = Logger.getLogger(FilterBuilderUtil.class);

	/**
	 * 将map转换为FilterBuilder
	 * 
	 * @param map
	 * @param filterStrategyContext
	 * @return
	 */
	public static BoolQueryBuilder convert(Map<String, Set<String>> map, FilterStrategyContext filterStrategyContext) {
		MapFascade<FilterBuilderStrategyI> filterBuilderContext = filterStrategyContext.getFilterBuilderContext();
		
		BoolQueryBuilder boolFilterBuilder = QueryBuilders.boolQuery();
		
		Set<String> keySet = map.keySet();
		boolean hasFilterConditoin = false;
		for (String key : keySet) {
			FilterBuilderStrategyI filterBuilderStrategy = filterBuilderContext.get(key);
			System.out.println(filterBuilderContext.get(key).getClass().getName()+"=====================");
			if (null == filterBuilderStrategy) {
				if (logger.isDebugEnabled()) {
					logger.debug("无法找到与[" + key + "]对应的FilterConvertI实现!");
				}
				continue;
			}
			Set<String> valueSet = map.get(key);
			boolFilterBuilder =  filterBuilderStrategy.execute(boolFilterBuilder,valueSet);
			hasFilterConditoin = true;
		}

		return hasFilterConditoin ? boolFilterBuilder : null;
	}
}
