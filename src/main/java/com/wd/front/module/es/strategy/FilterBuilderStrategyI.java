package com.wd.front.module.es.strategy;

import java.util.Set;

import org.elasticsearch.index.query.BoolQueryBuilder;



public interface FilterBuilderStrategyI {
	
	public BoolQueryBuilder execute(BoolQueryBuilder boolFilterBuilder,Set<String> valueSet);
}
