package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.UserRequest;

public interface UserRequestDaoI {
	/**
	 * 添加
	 */
	public void insert(UserRequest userRequest);
	/**
	 * 查询所有
	 * @return
	 */
	public List<UserRequest> findAll(Map<String, Object> params);
	
	public int findAllCount(Map<String, Object> params);
	/**
	 * 修改状态
	 */
	public void updateById(Integer id);

}
