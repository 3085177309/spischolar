package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Database;

public interface DatabaseDaoI {

	/**
	 * 模糊查询数据库总数量
	 * 
	 * @param key
	 * @return
	 */
	int getCount(Map<String, Object> params);

	/**
	 * 分页模糊查询数据库列表
	 * 
	 * @param params
	 * @return
	 */
	List<Database> findList(Map<String, Object> params);

	/**
	 * 根据id查找数据库信息
	 * 
	 * @param dbId
	 * @return
	 */
	Database findById(Integer dbId);

}
