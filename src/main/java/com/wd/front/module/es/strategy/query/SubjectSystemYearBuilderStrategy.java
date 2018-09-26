package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

/**
 * 学科体系中的收录年查找
 * 
 * @author pan
 * 
 */
@Component("scYearQuery")
public class SubjectSystemYearBuilderStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.termQuery("year", Integer.parseInt(value));
	}

}
