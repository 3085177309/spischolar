package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.SensitiveWord;

public interface SensitiveWordDaoI {
	
	/**
	 * 插入一个敏感词
	 * @param word
	 */
	public void insert(SensitiveWord word);
	
	/**
	 * 通过ID删除一个敏感词
	 * @param id
	 */
	public void deleteById(Integer id);
	
	public int findCount(String orgFlag);
	
	/**
	 * 查找机构自己定义的所有敏感词
	 * @return
	 */
	public List<SensitiveWord> findByOrg(Map<String,Object> params);
	
	/**
	 * 查找机构所有的敏感词，包括系统定义的敏感词
	 * @param orgFlag
	 * @return
	 */
	public List<SensitiveWord> findAllByOrg(String orgFlag);

}
