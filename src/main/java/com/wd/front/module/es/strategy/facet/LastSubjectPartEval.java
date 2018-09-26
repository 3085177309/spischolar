package com.wd.front.module.es.strategy.facet;

import static org.elasticsearch.search.aggregations.AggregationBuilders.terms;

import org.elasticsearch.search.aggregations.AbstractAggregationBuilder;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.FacetBuilderStrategyI;

@Component("lastSubjectPartEval")
public class LastSubjectPartEval implements FacetBuilderStrategyI {

	@Override
	public AbstractAggregationBuilder execute(String field) {
		return terms("lastSubjectPartEval").field("shouLu.last").size(10).shardSize(20);
	}

}
