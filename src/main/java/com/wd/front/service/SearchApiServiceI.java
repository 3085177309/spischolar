package com.wd.front.service;

import com.wd.front.bo.SearchCondition;

public interface SearchApiServiceI {
	
	public String getSubjectList(int subjectNameId, int id, String year, String subject);
	
	public String searchBywfw(String url,SearchCondition condition);

}
