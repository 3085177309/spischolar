package com.wd.front.module.es.strategy;

import org.elasticsearch.search.aggregations.AbstractAggregationBuilder;

public interface FacetBuilderStrategyI {

	public AbstractAggregationBuilder execute(String field);
}
