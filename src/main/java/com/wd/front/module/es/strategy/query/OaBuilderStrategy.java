package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

/**
 * 开源刊查找
 * 
 * @author pan
 * 
 */
@Component("oaQuery")
public class OaBuilderStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.termQuery("isOpen", Integer.parseInt(value));
	}

}
