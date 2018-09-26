package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.AuthorityDatabase;

public interface AuthorityDatabaseDaoI {

	/**
	 * 按优先级从高到低，获取所有权威数据库
	 * 
	 * @return
	 */
	List<AuthorityDatabase> findAll();

	/**
	 * 插入权威数据库信息
	 * 
	 * @param model
	 */
	void insert(AuthorityDatabase model);

	/**
	 * 查找权威数据库标识是否存在
	 * 
	 * @param flag
	 * @return 返回null表示不存在
	 */
	Integer findFlagExists(String flag);

	/**
	 * 按id删除权威数据库
	 * 
	 * @param id
	 */
	void del(Integer id);

	/**
	 * 查找除这个id对应的记录之外的其他记录是否有叫flag的权威数据库
	 * 
	 * @param params
	 * @return
	 */
	Integer findFlagExistsByParam(Map<String, Object> params);

	/**
	 * 更新权威数据库信息
	 * 
	 * @param authorityDB
	 */
	void update(AuthorityDatabase authorityDB);

	/**
	 * 根据关键词查找权威数据库的总数量，如果关键词为空，则查找所有权威数据库的总数量
	 * 
	 * @param params
	 * @return
	 */
	Integer getCountByKey(Map<String, Object> params);

	/**
	 * 获取与查询条件匹配的权威数据库
	 * 
	 * @param params
	 * @return
	 */
	List<AuthorityDatabase> findByParams(Map<String, Object> params);

	/**
	 * 按id查找权威数据库详细信息
	 * 
	 * @param id
	 * @return
	 */
	AuthorityDatabase findById(Integer id);

}
