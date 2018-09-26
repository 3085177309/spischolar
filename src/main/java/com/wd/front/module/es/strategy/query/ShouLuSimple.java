package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

public class ShouLuSimple implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.termQuery("shouLu.detailList.simple", value);
	}

}
