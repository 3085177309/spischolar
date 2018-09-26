package com.wd.front.context;

import com.wd.front.module.es.strategy.FacetBuilderStrategyI;
import com.wd.util.MapFascade;

public class FacetBuilderStrategyContext {

	private MapFascade<FacetBuilderStrategyI> facetBuilderContext = new MapFascade<FacetBuilderStrategyI>();

	public FacetBuilderStrategyContext() {
	}

	public MapFascade<FacetBuilderStrategyI> getFacetBuilderContext() {
		return facetBuilderContext;
	}

	public void setFacetBuilderContext(MapFascade<FacetBuilderStrategyI> facetBuilderContext) {
		this.facetBuilderContext = facetBuilderContext;
	}
}
