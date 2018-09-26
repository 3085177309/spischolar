package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

@Component("docTypeQuery")
public class DocTypeQueryBuilderStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		if ("0".equals(value)) {
			return QueryBuilders.termQuery("docType", 9);
		} else {
			return QueryBuilders.termQuery("docType", Integer.parseInt(value));
		}
	}

}
