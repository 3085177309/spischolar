package com.wd.backend.dao;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.ChickPage;
import com.wd.backend.model.VisitLog;
import com.wd.backend.model.VisiteInformation;

/**
 * 访客浏览数据
 * @author 杨帅菲
 *
 */
public interface BrowseDaoI {
	/**
	 * 用户一次完整访问的信息
	 * @param browseCount
	 * @return
	 */
	public void insertPageNum(BrowseCount browseCount);
	/**
	 * 用户一次完整访问的访问行为信息
	 * @param chickPage
	 * @return
	 */
	public void insertChickPage(ChickPage chickPage);
	/**
	 * 根据时间查询访问概况（后台首页信息）
	 * @param params
	 * @return
	 */
	public VisiteInformation findVisit(Map<String,Object> params);
	/**
	 * 总天数
	 * @return
	 */
	public int findDay();
	
	/**
	 * 浏量查询:获取用户浏览信息
	 * @return
	 * @throws ParseException
	 */
	public List<BrowseCount> findBrowseList(Map<String,Object> params);
	/**
	 * 根据时间查询ip数量
	 * @param timeIP
	 * @return
	 */
	public List<Map<String,Object>> findIpCount(Map<String,Object> params);
	
	
	/**
	 * 按条件分页查询浏览信息t_browse
	 * @param params
	 * @return
	 */
	public List<BrowseCount> findBrowseListByPage(Map<String,Object> params);
	/**
	 * 根据browseId来查询ChickPage
	 * @param id
	 * @return
	 */
	public List<ChickPage> findChickPageById(Integer id);
	/**
	 *  按条件查询浏览信息t_browse数量
	 * @param params
	 * @return
	 */
	public int findBrowseCountByPage(Map<String,Object> params);
	
	/**
	 * 查询所有来源网站
	 * @return
	 */
	public List<BrowseCount> findRefOrg();
	/**
	 * 查询访问报告。访问异常
	 * @return
	 */
	public List<VisitLog> findVisitLog(Map<String,Object> params);
	/**
	 * 查询访问报告总数
	 * @return
	 */
	public int findVisitLogCount(Map<String,Object> params);
	
	
	
	
	/**
	 * 用户行为分析图标数据获取
	 * @return
	 */
	public List<ChickPage> findChickPage(int id);
	/**
	 * 自动增加数据使用功能
	 * @param orgFlag
	 * @return
	 */
	public Map<String, Object> findBrowse(Map<String,Object> params);

}
