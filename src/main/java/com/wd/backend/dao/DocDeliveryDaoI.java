package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.DeliveryValidity;
import com.wd.backend.model.DocDelivery;

/**
 * 文献传递Dao
 * @author shenfu
 *
 */
public interface DocDeliveryDaoI {
	
	/**
	 * 登录后将登录前的收藏收藏到登录后的用户中
	 * @param params
	 */
	public void updates(Map<String,Object> params);
	
	/**
	 * 根据条件查询总量（前台）
	 * @param params
	 * @return
	 */
	public Integer findCountByParamsIndex(Map<String,Object> params);
	/**
	 * 根据条件查询总量（后台）
	 * @param params
	 * @return
	 */
	public Integer findCountByParams(Map<String,Object> params);
	/**
	 * 根据条件查找列表（前台）
	 * @param params
	 * @return
	 */
	public List<DocDelivery> findListByParamsIndex(Map<String,Object> params);
	/**
	 * 根据条件查找列表（后台）
	 * @param params
	 * @return
	 */
	public List<DocDelivery> findListByParams(Map<String,Object> params);
	
	
	public void insert(DocDelivery delivery);
	
	public void update(DocDelivery delivery);
	
	public int findExist(DocDelivery delivery);
	
	public void deleteById(Long id);
	
	public DocDelivery findById(Long id);
	
	public List<DocDelivery> findTop(Map<String,Object> params);
	
	public DocDelivery findByUrl(DocDelivery delivery);
	
	public DocDelivery findByReuse(DocDelivery delivery);
	
	int findcountByEmail(Map<String,Object> params);
	
	public List<DeliveryValidity> findDeliveryValidity(Map<String,Object> params);
	
	public int findDeliveryValidityCount(Map<String,Object> params);
	
	public int addDeliveryValidity(DeliveryValidity deliveryValidity);
	
	public int updateDeliveryValidity(DeliveryValidity deliveryValidity);
	
	public void deleteDeliveryValidity(Integer id);
	
	String findcountByEmailFromValidity(Map<String,Object> params);
	
	/**
	 * 文献传递统计
	 * @param request
	 * @return
	 */
	public List<Map<String,Object>>  getDeliveryRecord(Map<String,Object> params);
	
	/**
	 * 文献传递统计(有记录天数)
	 * @param request
	 * @return
	 */
	public List<Map<String,Object>>  getDeliveryRecordDay(Map<String,Object> params);
	
	public int  getDeliveryRecordCount(Map<String,Object> params);
	
	/**
	 * 文献传递统计(根据学校)
	 * @param request
	 * @return
	 */
	public List<Map<String,Object>>  getDeliveryRecordByOrgFlag(Map<String,Object> params);
	
	/**
	 * 文献传递统计(根据学校)(有记录天数)
	 * @param request
	 * @return
	 */
	public List<Map<String,Object>>  getDeliveryRecordByOrgFlagDay(Map<String,Object> params);
	
	public int  getDeliveryRecordByOrgFlagCount(Map<String,Object> params);
	
	/**
	 * 查询文献传递总请求次数
	 * @param params
	 * @return
	 */
	public String  getDeliveryRecordByOrgFlagAllCount(Map<String,Object> params);
	
	
	/**
	 * 手动数据添加 （数据展示）
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>>  getDeliveryRecordTitle(Map<String,Object> params);
	
	public List<Map<String,Object>>  getDeliveryRecordByTitle(Map<String,Object> params);
	
	
	public int findDiliveryHelpCount(Map<String,Object> params);
	
	public List<Map<String,Object>> findDiliveryHelpList(Map<String,Object> params);
	
	public Map<String,Object> checkHelp(Integer id);
	
	public List<Map<String,Object>> checkHelpCount(Integer memberId);
	
	public void updateHelp(Map<String,Object> param);
	

}
