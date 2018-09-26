package com.wd.front.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.History;

public interface HistoryServiceI {
	
	public Pager findPage(Integer systemId,Integer memberId,Integer type);
	
	public List<History> findTopN(Integer top,Integer systemId,Integer memberId ,Integer type);
	
	public void insert(History history);
	
	public void deleteHistory(Integer id,Integer type);
	
	public List<History> findListForSearch(Integer memberId, String keyword,String type);
}
