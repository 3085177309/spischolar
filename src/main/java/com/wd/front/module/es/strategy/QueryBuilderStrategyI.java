package com.wd.front.module.es.strategy;

import org.elasticsearch.index.query.QueryBuilder;

public interface QueryBuilderStrategyI {

	public QueryBuilder execute(String value, Object otherConstraint);
}
