package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Hot;

public interface HotDaoI {
	
	/**
	 * 通过标题查找
	 * @return
	 */
	public Hot getByTitle(Map<String, Object> params);
	
	/**
	 * 插入
	 * @param hot
	 */
	public void insert(Hot hot);
	
	/**
	 * 修改
	 * @param hot
	 */
	public void update(Hot hot);


}
