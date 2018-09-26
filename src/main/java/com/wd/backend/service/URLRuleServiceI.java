package com.wd.backend.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.URLRule;

/**
 * URL规则替换管理
 * @author Administrator
 *
 */
public interface URLRuleServiceI {
	
	/**
	 * 添加一条规则
	 * @param rule
	 */
	public void add(URLRule rule);
	
	/**
	 * 规则详情
	 * @param id
	 * @return
	 */
	public URLRule detail(Integer id);
	
	/**
	 * 查找机构定义的替换规则
	 * @param orgFlag
	 * @return
	 */
	public Pager searchPage(String orgFlag);
	
	/**
	 * 查询所有的替换规则
	 * @param orgFlag
	 * @return
	 */
	public List<URLRule> findAll(String orgFlag);
	
	/**
	 * 编辑
	 * @param rule
	 */
	public void edit(URLRule rule);
	
	/**
	 * 删除
	 * @param id
	 */
	public void delete(Integer id);

}
