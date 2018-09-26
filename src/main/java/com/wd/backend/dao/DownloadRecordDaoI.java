package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Download;
import com.wd.backend.model.DownloadInfo;

public interface DownloadRecordDaoI {
	
	/**
	 * 根据字段查找是否存在记录
	 * @param params
	 * @return
	 */
	public Download findDownloadRecord(Map<String, Object> params);
	/**
	 * 修改记录
	 * @param params
	 */
	public void updateDownloadRecord(Map<String, Object> params);
	/**
	 * 新增记录
	 * @param download
	 * @return
	 */
	public int insertDownloadRecord(Download download);
	/**
	 * 新增详细记录
	 * @param downloadInfo
	 */
	public void insertDownloadRecordInfo(DownloadInfo downloadInfo);
	
	
	public List<Map<String,Object>> getAllDownloadList(Map<String, Object> params);
	
	public int getAllDownloadListCount(Map<String, Object> params);
	
	/**查询文章下载统计(有记录天数) */
	public List<Map<String,Object>> getDownLoadRecordDay(Map<String, Object> params);
	/**
	 * 后台获取列表
	 * @param downloadInfo
	 */
	public List<DownloadInfo> getList(Map<String, Object> params);
	
	/**
	 * 后台获取列表count
	 * @param downloadInfo
	 */
	public int getListCount(Map<String, Object> params);
	
	/**
	 * 后台获取所有数量
	 * @param downloadInfo
	 */
	public int getAllCount(Map<String, Object> params);
	
	/**
	 * 后台获取详细列表
	 * @param downloadInfo
	 */
	public List<DownloadInfo> getInfoList(Map<String, Object> params);
	
	/**
	 * 后台获取详细列表count
	 * @param downloadInfo
	 */
	public int getInfoListCount(Map<String, Object> params);
	
	/**
	 * <!-- 手动数据添加（数据展示） -->
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getDownLoadRecordTitle(Map<String, Object> params);
	
	public List<Map<String,Object>> getDownLoadRecordByTitle(Map<String, Object> params);

}
