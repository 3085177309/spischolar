package com.wd.front.module.es.strategy.filter;

import java.util.Set;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.TermsQueryBuilder;
import org.springframework.stereotype.Component;

import com.wd.front.module.es.strategy.FilterBuilderStrategyI;

/**
 * 在线/纸本期刊过滤
 * 
 * @author Administrator
 * 
 */
@Component("oaFilter")
public class OaFilterStrategy implements FilterBuilderStrategyI {

	@Override
	public BoolQueryBuilder execute(BoolQueryBuilder boolFilterBuilder,Set<String> valueSet) {
		
		return boolFilterBuilder.filter(new TermsQueryBuilder("isOpen", valueSet));
	}

}
