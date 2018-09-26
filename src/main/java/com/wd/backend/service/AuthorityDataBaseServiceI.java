package com.wd.backend.service;

import javax.transaction.SystemException;

import com.wd.backend.bo.AuthorityDatabaseBO;
import com.wd.backend.bo.Pager;

public interface AuthorityDataBaseServiceI {

	/**
	 * 增加权威数据库信息
	 * 
	 * @param authorityDB
	 * @throws SystemException
	 */
	public void add(AuthorityDatabaseBO authorityDB) throws SystemException;

	/**
	 * 删除权威数据库
	 * 
	 * @param id
	 */
	public void del(Integer id);

	/**
	 * 修改权威数据库信息
	 * 
	 * @param authorityDB
	 * @throws SystemException
	 */
	public void edit(AuthorityDatabaseBO authorityDB) throws SystemException;

	/**
	 * 查找权威数据库
	 * 
	 * @param keyword
	 * @return
	 */
	public Pager search(String keyword);

	/**
	 * 查找权威数据库详细信息
	 * 
	 * @param id
	 * @return
	 */
	public AuthorityDatabaseBO detail(Integer id);
}
