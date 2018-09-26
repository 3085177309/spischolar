package com.wd.backend.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.PurchaseDBDaoI;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.service.PurchaseDBServiceI;
import com.wd.comm.context.SystemContext;

@Service("purchaseDBService")
public class PurchaseDBServiceImpl implements PurchaseDBServiceI{
	
	@Autowired
	private PurchaseDBDaoI purchaseDBDao;

	@Override
	public void add(PurchaseDB pd) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("orgFlag",pd.getOrgFlag());
		List<PurchaseDB> list = purchaseDBDao.findPager(params);
		PurchaseDB newPd = pd;
		int order = pd.getOrderNum();
		if(order == -1 &&  list != null && list.size()>0) {
			order = list.get(list.size()-1).getOrderNum()+1;
			newPd.setOrderNum(order);
		} else {
			for(int i=0; i<list.size(); i++) {
				if(order <= list.get(i).getOrderNum()) {
					pd = (PurchaseDB) list.get(i);
					pd.setOrderNum(pd.getOrderNum()+1);
					purchaseDBDao.update(pd);
				}
			}
		}
		if(newPd.getOrderNum()==-1) {
            newPd.setOrderNum(0);
        }
		purchaseDBDao.insert(newPd);
	}

	@Override
	public void delete(Integer id) {
		purchaseDBDao.delete(id);
	}

	@Override
	public void edit(PurchaseDB pd) {
		purchaseDBDao.update(pd);
	}

	@Override
	public PurchaseDB detail(Integer id) {
		return purchaseDBDao.findById(id);
	}

	@Override
	public Pager findPager(String orgFlag,String dbType) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("orgFlag",orgFlag);
		params.put("dbType",dbType);
		params.put("offset", SystemContext.getOffset());
		params.put("size", 10);
		Pager pager=new Pager();
		pager.setTotal(purchaseDBDao.findCount(params));
		pager.setRows(purchaseDBDao.findPager(params));
		return pager;
	}

	@Override
	public List<PurchaseDB> findByOrg(String orgFlag) {
		return purchaseDBDao.findByOrg(orgFlag);
	}
	
	/**
	 * 根据资源名称或网址查询学校
	 * @param val
	 * @return
	 */
	@Override
	public Pager findSchool(String val,String flag,String dbType) {
		Map<String,Object> params=new HashMap<String,Object>();
		if("wdkj".equals(flag)){
			flag=null;
		}
		params.put("flag", flag);
		val = "%" + val +"%";
		params.put("val",val);
		params.put("dbType",dbType);
		params.put("offset", SystemContext.getOffset());
		params.put("size", 10);
		Pager pager=new Pager();
		pager.setTotal(purchaseDBDao.findSchoolCount(params));
		pager.setRows(purchaseDBDao.findSchool(params));
		return pager;
	}

}
