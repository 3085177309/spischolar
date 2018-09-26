package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Site;

public interface SiteDaoI {

	/**
	 * 通过机构id删除站点
	 * 
	 * @param id
	 */
	void deleteByOrg(Integer id);

	/**
	 * 获取机构下的站点列表
	 * 
	 * @param orgId
	 * @return
	 */
	List<Site> findOrgSites(Integer orgId);

	/**
	 * 查看机构下的站点标识是否存在
	 * 
	 * @param params
	 * @return 返回null表示不存在
	 */
	Integer findOrgFlagExists(Map<String, Object> params);

	/**
	 * 站点信息持久化
	 * 
	 * @param model
	 */
	void insert(Site model);

	/**
	 * 删除指定站点
	 * 
	 * @param siteId
	 */
	void del(Integer siteId);

	/**
	 * 查找站点详细
	 * 
	 * @param siteId
	 * @return
	 */
	Site findById(Integer siteId);

	/**
	 * 更新站点模版根目录
	 * 
	 * @param params
	 */
	void updateSiteTemplate(Map<String, Object> params);

}
