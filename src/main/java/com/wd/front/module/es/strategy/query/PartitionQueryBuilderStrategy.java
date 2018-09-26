package com.wd.front.module.es.strategy.query;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;

/**
 * 期刊所处分区查询
 * 
 * @author pan
 * 
 */
@Component("partitionQuery")
public class PartitionQueryBuilderStrategy implements QueryBuilderStrategyI {

	@Override
	public QueryBuilder execute(String value, Object otherConstraint) {
		return QueryBuilders.termQuery("shouLu.detailList.partition", value);
	}

}
