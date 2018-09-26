package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

/**
 * 用于对hot_journal类型中的orgFlag字段进行检索
 * 
 * @author pan
 * 
 */
@Component("orgFlagQuery")
public class OrgFlagQueryStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.termQuery("orgFlag", value.trim());
	}

}
