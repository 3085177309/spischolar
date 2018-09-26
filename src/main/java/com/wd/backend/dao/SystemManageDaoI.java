package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Org;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Quota;

public interface SystemManageDaoI {
	public Powers getTreeNodeById(int id);
	public List<Powers> getTreeNodeByPid(int id);
	/**
	 * 获取有某栏目权限的所有机构
	 * @param id
	 * @return
	 */
	public List<Org> getOrgBycid(int id);
	/**
	 * 添加权限
	 * @param params
	 */
	public void insert(Map<String, Object> params);
	/**
	 * 根据学校获得权限数量
	 * @param flag
	 * @return
	 */
	public int getTotal(String flag);
	/**
	 * 是否已经插入过该权限
	 * @param params
	 * @return
	 */
	public int getCount(Map<String, Object> params);
	/**
	 * 根据父id获取子栏目的个数
	 * @param id
	 * @return
	 */
	public int getChildCount(int id);
	/**
	 * 根据父id获取已插入权限的子项目个数
	 * @param id
	 * @return
	 */
	public int getInsertCount(Map<String, Object> params);
	/**
	 * 删除权限
	 * @param params
	 */
	public void delete(Map<String, Object> params);
	
	public Powers getTreeNode(Map<String, Object> params);
	
	public List<Powers> getTreeNodeByOrg(Map<String, Object> params);
	/**
	 * 权限设置详细页面
	 * @param name
	 * @return
	 */
	public List<Map<String,Object>> getDetailByName(String name);
	/**
	 * 根据学校和pid获得权限数量 用于判断是否删除上级权限
	 * @param params
	 * @return
	 */
	public int getTotalByPid(Map<String, Object> params);
	/**
	 * 查询设置过权限的学校机构
	 * @return
	 */
	public List<Org> getPermissionOrg();
	/**
	 * 根据学校查询学校权限id
	 * @param flag
	 * @return
	 */
	public List<Integer> getPowersIds(String flag);
	
	public List<Org> getOrgByName(String name);
	/**
	 * 根据orgid查询学校权限
	 * @param orgid
	 * @return
	 */
	public List<Powers> getPermissionByOrgId(int orgid);
	
	/**
	 * 流量指标
	 * @return
	 */
	public List<Quota> getAll();
	public int getQuotaTotal();
	public List<Map<String,Object>> getOrgQuota(Map<String, Object> params);
	public List<Quota> getQuotaByOrg(String flag);
	/**
	 * 添加指标权限
	 * @param params
	 */
	public void insertQuota(Map<String, Object> params);
	public void deleteQuota(Integer id);
	public void deleteQuotaBySchool(String flag);
	
	public List<Map<String,Object>> getSchoolQuoByName(String name);
	
	public List<Quota> getQuotaByOrgId(int orgid);
}
