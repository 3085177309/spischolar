package com.wd.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.Product;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.service.OrgApiService;

@Service("orgApiService")
public class OrgApiServiceImpl implements OrgApiService{
	
	private static final Logger LOG = Logger.getLogger(OrgApiServiceImpl.class);
	
	@Autowired
	private CacheModuleI cacheModule;
	
	@Autowired
	private OrgInfoServiceI orgInfoService;

	@Override
	public OrgBO getOrgByIp(String ip) {
		try {
			OrgBO org = cacheModule.findOrgByIpFromCache(ip);
			if(org != null){
				List<Product> products=cacheModule.getOrgProductList(org.getFlag());
				if(products==null){
					products=orgInfoService.findProductListByOrg(org.getFlag());
					cacheModule.putOrgProductList(org.getFlag(), products);
				}
				org.setProductList(products);
				return org;
			}
		} catch (SystemException e) {
			LOG.error(e.getMessage(),e);
		}
		return null;
	}
	
	@Override
    public OrgBO getOrgByFlag(String flag){
		OrgBO org = new OrgBO(orgInfoService.getOrgByFlag(flag));
		List<Product> products=cacheModule.getOrgProductList(org.getFlag());
		if(products==null){
			products=orgInfoService.findProductListByOrg(org.getFlag());
			cacheModule.putOrgProductList(org.getFlag(), products);
		}
		org.setProductList(products);
		return org;
	}
	

}
