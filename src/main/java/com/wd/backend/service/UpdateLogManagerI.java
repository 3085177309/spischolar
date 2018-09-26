package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.UpdateLog;

public interface UpdateLogManagerI {
	
	public void add(UpdateLog log);
	
	public UpdateLog detail(Integer id);
	
	public void delete(Integer id);
	
	public void edit(UpdateLog log);
	
	public void updateView(UpdateLog log);
	
	public Pager search(String key,int type);
	/**
	 * 查询后台lable标签
	 * @return
	 */
	public List<Map<Object, Object>> getLable();

	public void insertLable(String[] lables);
}
