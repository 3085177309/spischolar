package com.wd.front.context;

import com.wd.front.module.es.strategy.FilterBuilderStrategyI;
import com.wd.util.MapFascade;

public class FilterStrategyContext {

	private MapFascade<FilterBuilderStrategyI> filterBuilderContext = new MapFascade<FilterBuilderStrategyI>();

	public FilterStrategyContext() {
	}

	public MapFascade<FilterBuilderStrategyI> getFilterBuilderContext() {
		return filterBuilderContext;
	}

	public void setFilterBuilderContext(MapFascade<FilterBuilderStrategyI> filterBuilderContext) {
		this.filterBuilderContext = filterBuilderContext;
	}
}
