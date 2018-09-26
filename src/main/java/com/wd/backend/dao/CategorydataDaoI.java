package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Categorydata;

public interface CategorydataDaoI {
	/**
	 * 通过title货issn查询这条数据
	 * @param value
	 * @return
	 */
	public List<Categorydata> find(String value);
	/**
	 * 查询所有
	 * @return
	 */
	public int findAllCount(Map<String,Object> params);
	/**
	 * 查询它的排序序号
	 * @param params
	 * @return
	 */
	public int findCount(Map<String,Object> params);
	
	/**
	 * 查询体系最新年份
	 * @param categorySystem
	 * @return
	 */
	public int findNewYear(String categorySystem);
	
	/**
	 * 更具issn查询最新的issn
	 * @param value
	 * @return
	 */
	public String findNewISSN(String value);

}
