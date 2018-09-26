package com.wd.front.module.cache;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.AuthorityDatabase;
import com.wd.backend.model.DisciplineSystem;
import com.wd.backend.model.JournalSystemSubject;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Product;
import com.wd.backend.model.Quota;
import com.wd.exeception.SystemException;

public interface CacheModuleI {

	/**
	 * 重加载指定机构缓存(缓存管理需要)
	 * 
	 * @param orgId
	 */
	void reloadOrgCache(Integer orgId);

	/**
	 * 重加载所有机构缓存
	 */
	void reloadAllOrgCache();
	
	/**
	 * 添加机构可以使用的产品列表
	 * @param orgFlag
	 * @param products
	 */
	void putOrgProductList(String orgFlag,List<Product> products);
	
	/**
	 * 获取机构可用产品列表
	 * @param orgFlag
	 * @return
	 */
	List<Product> getOrgProductList(String orgFlag);
	
	/**
	 * 从新加载机构购买的产品列表到缓存
	 * @param orgFlag
	 */
	void reloadOrgProductCache(String orgFlag);
	
	/**
	 * 重加载全局缓存
	 * 
	 * @throws SystemException
	 */
	void reloadOverallSituationCache() throws SystemException;

	/**
	 * 通过ip到缓存中查找机构(前台检索需要)
	 * 
	 * @param ip
	 * @return
	 * @throws SystemException
	 */
	OrgBO findOrgByIpFromCache(String ip) throws SystemException;

	/**
	 * 从缓存中获取权威数据库的最新学科体系(期刊导航首页需要)<br/>
	 * key为权威数据库，value为学科体系列表
	 * 
	 * @return
	 * @throws SystemException
	 *             当缓存加载异常时抛出此异常
	 */
	Map<String, Set<DisciplineSystem>> loadDisciplineSystemFromCache() throws SystemException;

	/**
	 * 获取权威数据库的所有收录年(期刊导航浏览页需要)<br/>
	 * key为权威数据库，value为收录年
	 * 
	 * @return
	 * @throws SystemException
	 */
	Map<String, Set<DisciplineSystem>> findDbAllYearFromCache() throws SystemException;

	/**
	 * 获取权威数据库的分区(期刊导航浏览页需要)
	 * 
	 * @return
	 * @throws SystemException
	 */
	List<AuthorityDatabase> findDbPartitionFromCache() throws SystemException;
	
	/**
	 * 获取学科(期刊导航浏览页需要)
	 * 
	 * @return
	 * @throws SystemException
	 */
	public List<JournalSystemSubject> findSubjectPartitionFromCache() throws SystemException;

	/**
	 * 从缓存中获取所有学科数据(浏览页的排序条件需要)<br/>
	 * key为学科名，value为学科id
	 * 
	 * @return
	 * @throws SystemException
	 */
	Map<String, Integer> findAllDisciplineFromCache() throws SystemException;

	/**
	 * 从缓存中获取所有权威数据库(浏览页的排序条件需要)<br/>
	 * key为权威数据库名,value为权威数据库id(结果已按照显示优先级排序)
	 * 
	 * @return
	 * @throws SystemException
	 */
	Map<String, Integer> findAllAuthorityDbFromCache() throws SystemException;

	/**
	 * 分类型获取所有的排序字段
	 * 
	 * @param type
	 *            只有两种类型subject_sort_no，eval_sort_no
	 * @return
	 * @throws SystemException
	 */
	Set<String> findAllSortFieldByTypeFromCache(String type) throws SystemException;
	
	List<Powers> findPowersByOrgIdFromCache(int orgId) throws SystemException;
	
	List<Quota> findQuotaByOrgIdFromCache(int orgId) throws SystemException;
	
	/**
	 * 从数据库加载数据添加信息
	 */
/*	void addBrowseInfoCache();
	Map<String,Object> getBrowseInfoCache(String orgFlag);*/
}
