package com.wd.front.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.ProductDaoI;
import com.wd.backend.dao.PurchaseDBDaoI;
import com.wd.backend.dao.URLRuleDaoI;
import com.wd.backend.model.Department;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.model.URLRule;
import com.wd.front.service.OrgInfoServiceI;

@Service("orgInfoService")
public class OrgInfoServiceImpl implements OrgInfoServiceI{
	
	@Autowired
	private ProductDaoI productDao;
	
	@Autowired
	private URLRuleDaoI ruleDao;
	
	@Autowired
	private PurchaseDBDaoI pdDao;
	
	@Autowired
	private OrgDaoI orgDao;

	@Override
	public List<Product> findProductListByOrg(String orgFlag) {
		return productDao.findCurrentByOrg(orgFlag);
	}

	@Override
	public List<PurchaseDB> findPurchaseDBByOrg(String orgFlag) {
		return pdDao.findByOrg(orgFlag);
	}

	@Override
	public List<URLRule> findURLRuleByOrg(String orgFlag) {
		return ruleDao.findByOrg(orgFlag);
	}

	@Override
	public List<Org> findAll() {
		return orgDao.findAll();
	}
	@Override
	public List<Org> findProvince() {
		return orgDao.findProvince();
	}
	
	@Override
	public List<Department> findDepartment(int schoolId) {
		return orgDao.findDepartments(schoolId);
	}

	@Override
	public Org getOrgByFlag(String flag) {
		return orgDao.findByFlag(flag);
	}

}
