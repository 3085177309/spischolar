package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.UpdateLog;

public interface UpdateLogDaoI {
	
	public void insert(UpdateLog log);
	
	public void delete(Integer id);
	
	public void update(UpdateLog log);
	
	public void increTimes(Integer id);
	
	public void increPraise(Integer id);
	
	public Integer findCount(Map<String,Object> params);
	
	public List<UpdateLog> findPager(Map<String,Object> params);
	
	public UpdateLog get(Integer id);
	
	public void updateView(UpdateLog log);
	
	public UpdateLog next(Integer id);
	
	public UpdateLog prev(Integer id);
	
	public List<Map<Object, Object>> getLable();
	
	public void insertLable(List<Map<String,Object>> list);

}
