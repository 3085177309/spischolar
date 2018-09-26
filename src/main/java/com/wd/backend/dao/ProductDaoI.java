package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Product;

public interface ProductDaoI {
	
	public List<Product> findByOrg(String orgFlag);
	
	public void insert(Product product);
	
	public void insertBatch(List<Product> list);
	
	public void delete(Integer id);
	
	public void edit(Product product);
	
	public void deleteByOrg(Integer orgId);
	
	public int findCount(Map<String,Object> params);
	
	public List<Product> findPager(Map<String,Object> params);
	
	/**
	 * 查找能够使用的产品
	 * @param orgFlag
	 * @return
	 */
	public List<Product> findCurrentByOrg(String orgFlag);

}
