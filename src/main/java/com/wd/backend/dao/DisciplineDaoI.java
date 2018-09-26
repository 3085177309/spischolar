package com.wd.backend.dao;

import java.util.List;

import com.wd.backend.model.Discipline;

public interface DisciplineDaoI {

	/**
	 * 获取所有学科
	 * 
	 * @return
	 */
	public List<Discipline> findAll();
}
