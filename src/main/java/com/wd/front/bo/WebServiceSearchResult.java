package com.wd.front.bo;

import java.util.List;
import java.util.Map;

public class WebServiceSearchResult {

	private String count;
	private List<SearchDocument> rows;
	private Map<String, String> timeMap;
	private Integer total;
	private float time;
	private String journalUrl;

	public WebServiceSearchResult() {
	}

	public List<SearchDocument> getRows() {
		return rows;
	}

	public void setRows(List<SearchDocument> rows) {
		this.rows = rows;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public float getTime() {
		return time;
	}

	public void setTime(float time) {
		this.time = time;
	}

	public Map<String, String> getTimeMap() {
		return timeMap;
	}

	public void setTimeMap(Map<String, String> timeMap) {
		this.timeMap = timeMap;
	}

	public String getJournalUrl() {
		return journalUrl;
	}

	public void setJournalUrl(String journalUrl) {
		this.journalUrl = journalUrl;
	}
}
