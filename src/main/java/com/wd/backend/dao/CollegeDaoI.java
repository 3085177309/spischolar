package com.wd.backend.dao;

import java.util.List;

import com.wd.backend.model.College;

public interface CollegeDaoI {
	
	public void insert(College college);
	
	public void update(College college);
	
	public void remove(Integer id);
	
	/**
	 * 通过学校查找
	 * @param orgFlag 机构标识
	 * @return
	 */
	public List<College> findBySchool(String orgFlag);

}
