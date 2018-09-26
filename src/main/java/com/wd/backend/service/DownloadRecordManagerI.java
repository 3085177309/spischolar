package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.DownloadInfo;

public interface DownloadRecordManagerI {
	
	public Pager getAllDownloadList(String beginTime,String endTime,String offset,String schoolName,String type,String sort);
	
	public List<DownloadInfo> getList(String school,String beginTime,String endTime,String type);
	
	public int getListCount(String school,String beginTime,String endTime,String type);
	
	public int getAllCount(String school,String beginTime,String endTime,String type);
	
	public List<DownloadInfo> getInfoList(String school,String beginTime,String endTime,String title,String type);
	
	public int getInfoListCount(String school,String beginTime,String endTime,String title,String type);
	
	/**
	 * 创建excel表并保存(所有下载统计（根据学校）)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void creatAlldownloadRecord(List<Map<String,Object>> list, String path) throws Exception;
	
	/**
	 * <!-- 手动数据添加（数据展示） -->
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getDownLoadRecordTitle(String orgFlag,String beginTime,String endTime,String size);
	
	public void addDownloadInfo(Map<String,Object> params,String username);
	/**
	 * 数据添加日志
	 * @return
	 */
	public Map<String,Object> getLog(String orgFlag,String title);
	public Pager getLogList(String orgFlag);
}
