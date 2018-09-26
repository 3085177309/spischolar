package com.wd.backend.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.PurchaseDB;

public interface PurchaseDBServiceI {
	
	public void add(PurchaseDB pd);
	
	public void delete(Integer id);
	
	public void edit(PurchaseDB pd);
	
	public PurchaseDB detail(Integer id);
	
	/**
	 * 按页查找机构购买的数据库
	 * @return
	 */
	public Pager findPager(String orgFlag,String dbType);
	
	/**
	 * 查找所有的购买的数据库
	 * @param orgFlag
	 * @return
	 */
	public List<PurchaseDB> findByOrg(String orgFlag);
	
	/**
	 * 根据资源名称或网址查询学校
	 * @param val
	 * @return
	 */
	public Pager findSchool(String val,String flag,String dbType);

}
