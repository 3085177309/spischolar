package com.wd.backend.model;

public class Quota {
	private int id;
	/**
	 * 指标名称
	 */
	private String quotaName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuotaName() {
		return quotaName;
	}
	public void setQuotaName(String quotaName) {
		this.quotaName = quotaName;
	}
	
}
