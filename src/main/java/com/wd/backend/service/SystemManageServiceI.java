package com.wd.backend.service;


import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Quota;

public interface SystemManageServiceI {
	public Powers getPowersList();
	/**
	 * 添加权限
	 * @param id
	 * @param pid
	 * @param flags
	 */
	public void insertPermission(String id,String pid,String flags);
	/**
	 * 删除权限
	 * @param id
	 * @param pid
	 * @param flags
	 */
	public void deletePermission(String id,String pid,String flag);
	/**
	 * 
	 * @return
	 */
	public Map<String,Object> getPowersListByOrg(int id,String name);
	/**
	 * 新建学校添加权限
	 * @param id
	 * @param flags
	 */
	public void insertNewPermission(String ids,String flag);
	
	public void mappedPermission(String cids,String flags);
	/**
	 * 流量指标
	 * @return
	 */
	public List<Quota> getAllQuota();
	
	public Pager getOrgQuotas();
	/**
	 * 添加指标权限
	 * @param qids
	 * @param flag
	 */
	public void addQuota(String qids,String flag,String type);
	public void delQuota(String id);
	
	public Map<String,Object> getschoolQuotaByName(String name);
}
