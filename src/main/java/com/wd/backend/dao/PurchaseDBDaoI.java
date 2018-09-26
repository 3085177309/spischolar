package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.PurchaseDB;

/**
 * 已购买数据库Dao
 * @author Administrator
 *
 */
public interface PurchaseDBDaoI {
	
	/**
	 * 查找总的条数
	 * @return
	 */
	public int findCount(Map<String,Object> params);
	
	/**
	 * 更具条件查找
	 * @param params
	 * @return
	 */
	public List<PurchaseDB> findPager(Map<String,Object> params);
	
	/**
	 * 查找学校购买的所有资源
	 * @param orgFlag
	 * @return
	 */
	public List<PurchaseDB> findByOrg(String orgFlag);
	
	/**
	 * 更具ID查找记录
	 * @param pdId
	 * @return
	 */
	public PurchaseDB findById(Integer pdId);
	
	/**
	 * 插入记录
	 * @param pd
	 */
	public void insert(PurchaseDB pd);
	
	/**
	 * 更新记录
	 * @param pd
	 */
	public void update(PurchaseDB pd);
	
	/**
	 * 删除记录
	 * @param pdId
	 */
	public void delete(Integer pdId);
	
	/**
	 * 删除机构对应的数据库
	 * @param orgFlag
	 */
	public void deleteByOrg(String orgFlag);
	/**
	 * 根据资源名称或网址查询学校
	 * @param val
	 * @return
	 */
	public List<PurchaseDB> findSchool(Map<String,Object> params);
	public int findSchoolCount(Map<String,Object> params);

}
