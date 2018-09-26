package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.DisciplineSystem;
import com.wd.backend.model.JournalSystemSubject;

public interface DisciplineSystemDaoI {

	/**
	 * 查找权威数据库的最新学科体系
	 * 
	 * @return
	 */
	public List<DisciplineSystem> findLast();

	/**
	 * 获取权威数据库的所有收录年
	 * 
	 * @return
	 */
	public List<DisciplineSystem> findAllYear();
	
	/**
	 * 根据请求参数查找
	 * @param params
	 * @return
	 */
	public List<DisciplineSystem> findByYear(Map<String, Object> params);
	
	/**
	 * 查出所有的subjectName
	 * @return
	 */
	public List<JournalSystemSubject> findAllSubjectName();
}
