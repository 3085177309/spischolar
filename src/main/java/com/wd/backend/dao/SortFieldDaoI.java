package com.wd.backend.dao;

import java.util.List;

import com.wd.backend.model.SortField;

public interface SortFieldDaoI {

	/**
	 * 获取所有的排序字段
	 * 
	 * @return
	 */
	public List<SortField> findAll();
}
