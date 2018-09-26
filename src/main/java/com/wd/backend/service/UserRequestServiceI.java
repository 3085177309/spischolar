package com.wd.backend.service;

import java.util.List;

import com.wd.backend.model.UserRequest;

public interface UserRequestServiceI {
	/**
	 * 添加
	 * @param userRequest
	 */
	public void insert(UserRequest userRequest);
	/**
	 * 查询所有
	 * @return
	 */
	public List<UserRequest> findAll(int type,String keyword);
	
	public int findAllCount(int type,String keyword);
	/**
	 * 修改状态
	 * @param id
	 */
	public void updateById(int id);
}
