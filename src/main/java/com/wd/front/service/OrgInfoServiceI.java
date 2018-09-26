package com.wd.front.service;

import java.util.List;

import com.wd.backend.model.Department;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.model.URLRule;

/**
 * 机构信息查询
 * @author Administrator
 *
 */
public interface OrgInfoServiceI {
	
	/**
	 * 查询机构可用的产品
	 * @param orgFlag
	 * @return
	 */
	public  List<Product> findProductListByOrg(String orgFlag);
	
	/**
	 * 查询机构配置的资源
	 * @param orgFlag
	 * @return
	 */
	public List<PurchaseDB> findPurchaseDBByOrg(String orgFlag);
	
	/**
	 * 查询机构配置的URL替换规则
	 * @param orgFlag
	 * @return
	 */
	public List<URLRule> findURLRuleByOrg(String orgFlag);
	
	/**
	 * 查找所有的机构
	 * @return
	 */
	public List<Org> findAll();
	public List<Org> findProvince();
	
	public Org getOrgByFlag(String flag);
	
	public List<Department> findDepartment(int schoolId);
	
}
