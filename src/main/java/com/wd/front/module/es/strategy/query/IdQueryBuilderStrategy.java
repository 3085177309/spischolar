package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

@Component("idQuery")
public class IdQueryBuilderStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.idsQuery().addIds(value);
	}

}
