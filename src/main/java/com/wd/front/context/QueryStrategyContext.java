package com.wd.front.context;

import com.wd.front.module.es.strategy.QueryBuilderStrategyI;
import com.wd.util.MapFascade;

public class QueryStrategyContext {

	private MapFascade<QueryBuilderStrategyI> strategyContext = new MapFascade<QueryBuilderStrategyI>();

	public QueryStrategyContext() {
	}

	public MapFascade<QueryBuilderStrategyI> getStrategyContext() {
		return strategyContext;
	}

	public void setStrategyContext(MapFascade<QueryBuilderStrategyI> strategyContext) {
		this.strategyContext = strategyContext;
	}
}
