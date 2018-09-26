package com.wd.front.bo;

import java.util.HashMap;
import java.util.Map;

/**
 * 站点信息
 * 
 * @author pan
 * 
 */
public class SiteInfo {

	private String flag;
	private String deployRoot;
	private Map<Integer, DocTypeInfo> configedDocType = new HashMap<Integer, DocTypeInfo>();
	private Map<Integer, FacetInfo> configedFacet = new HashMap<Integer, FacetInfo>();

	public String getDeployRoot() {
		return deployRoot;
	}

	public void setDeployRoot(String deployRoot) {
		this.deployRoot = deployRoot;
	}

	public Map<Integer, DocTypeInfo> getConfigedDocType() {
		return configedDocType;
	}

	public void setConfigedDocType(Map<Integer, DocTypeInfo> configedDocType) {
		this.configedDocType = configedDocType;
	}

	public Map<Integer, FacetInfo> getConfigedFacet() {
		return configedFacet;
	}

	public void setConfigedFacet(Map<Integer, FacetInfo> configedFacet) {
		this.configedFacet = configedFacet;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
}
