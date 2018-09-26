package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.DeliveryValidity;
import com.wd.backend.model.DocDelivery;

public interface DocDeliveryManagerI {
	
	/**
	 * 首页
	 * @param school
	 * @return
	 */
	public int findAllDeliveryCountBySchool(String school);
	/**
	 * 查找
	 * @param orgId
	 * @param userId
	 * @param processType
	 * @param keyword
	 * @return
	 */
	public Pager findPager(Integer orgId,Integer userId,Short processType,String keyword,String school,String beginTime,String endTime);
	
	/**
	 * 查找
	 * @param email
	 * @return
	 */
	public Pager findPager(String email);
	
	/**
	 * 添加
	 * @param dilivery
	 */
	public void add(DocDelivery dilivery);
	
	/**
	 * 编辑
	 * @param dilivery
	 */
	public void edit(DocDelivery dilivery);
	
	/**
	 * 通过ID查找
	 * @param id
	 * @return
	 */
	public DocDelivery get(Long id);
	
	/**
	 * 查找是有已经提交
	 * @param dilivery
	 * @return
	 */
	public boolean exist(DocDelivery dilivery);
	
	public Pager findDeliveryValidity(String keyWord);
	
	public int addDeliveryValidity(DeliveryValidity deliveryValidity);
	
	public int updateDeliveryValidity(DeliveryValidity deliveryValidity);
	
	public void deleteDeliveryValidity(int id);
	
	/**
	 * 文献传递统计
	 * @param request
	 * @return
	 */
	public Pager getDeliveryRecord(String beginTime,String endTime,String offset,String sort,String key,String type);
	/**
	 * 文献传递统计(根据学校)
	 * @param request
	 * @return
	 */
	public Pager getDeliveryRecordByOrgFlag(String email,String orgFlag,String beginTime,String endTime,String offset,String sort,String type);
	
	/**
	 * 查询文献传递总请求次数
	 * @param params
	 * @return
	 */
	public int getDeliveryRecordByOrgFlagAllCount(String email,String orgFlag,String beginTime, String endTime,
			String offset,String type);

	/**
	 * 创建excel表并保存(所有文献传递统计（根据学校）)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void downloadRecord(List<Map<String,Object>> list, String path) throws Exception;
	
	List<Map<String,Object>> getDeliveryRecordTitle(String orgFlag,String beginTime,String endTime, String size);
	/**
	 * 应助审核
	 * @param id
	 * @param helpId
	 */
	public void diliverHelp(long id,int helpId,int procesorId,String procesorName);
}
