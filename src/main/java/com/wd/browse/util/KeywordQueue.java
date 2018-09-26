package com.wd.browse.util;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component("keywordQueue")
public class KeywordQueue {
	
	List<Map<String,Object>> scholarKeyWordList;
	
	List<Map<String,Object>> journalKeyWordList;

	public Map<String, Object> getScholarKeyWord() {
		return scholarKeyWordList.get((int)Math.random()*scholarKeyWordList.size());
	}
	
	public Map<String, Object> getJournalKeyWord() {
		return journalKeyWordList.get((int)Math.random()*journalKeyWordList.size());
	}
	

	public void setScholarKeyWordList(List<Map<String, Object>> scholarKeyWordList) {
		this.scholarKeyWordList = scholarKeyWordList;
	}

	public void setJournalKeyWordList(List<Map<String, Object>> journalKeyWordList) {
		this.journalKeyWordList = journalKeyWordList;
	}
	
	

}
