package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.NewOld;
import com.wd.backend.model.VisiteInformation;

public interface VisitServiceI {
	/**
	 * 访客来源
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public List<Map<String, Object>> findVisiteCome(String school,String beginTime,String endTime,String type,String sort);


	/**
	 * 新老访客
	 * @param type
	 * @param beginTime
	 * @return
	 */
	public List<Map<String, Object>> getNewOld(String type,String school, String beginTime, String endTime);
	/**
	 * 新老访客
	 * @param type
	 * @param beginTime
	 * @return
	 */
	public List<Map<String, Object>> getNewOldBroList(String type,String school,String beginTime, String endTime, int isnew,String offset);
	public int getNewOldBroListTotal(String type,String school,String beginTime, String endTime, int isnew);
	
	/**
	 * 地域分布table表格
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public List<Map<String, Object>> findRegionTableList(String[] types,String school,String beginTime,String endTime,String type,String offset,String sort);
	/**
	 * 地域分布（图表）
	 * @return
	 */
	public Map<String, Object> findRegion(String[] types,String beginTime,String endTime,String type);
	
	/**
	 * 存留用户
	 * @param type
	 * @param beginTime
	 * @param endTime
	 * @param day
	 * @return
	 */
	public List<Map<String,Object>> getKeepUser(String type,String beginTime, String endTime,String day,String school);

}
