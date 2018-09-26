package com.wd.backend.service.impl;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.DownloadRecordDaoI;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.model.DownloadInfo;
import com.wd.backend.model.History;
import com.wd.backend.service.DownloadRecordManagerI;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.comm.context.SystemContext;
import com.wd.util.CollectionsUtil;
import com.wd.util.DateUtil;
import com.wd.util.DoubleUtil;
import com.wd.util.JsonUtil;

@Service("downloadRecordManagerService")
public class DownloadRecordManagerImpl implements DownloadRecordManagerI{
	
	@Autowired
	DownloadRecordDaoI downloadRecordDao;
	
	@Autowired
	private  AdditionDaoI additionDao;
	
	@Autowired
	MemberDaoI memberDao;
	
	@Override
    public Pager getAllDownloadList(String beginTime, String endTime, String offset, String schoolName, String type, String sort) {
		Pager pager = new Pager();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("schoolName", schoolName);
		params.put("type", type);
		/*if(offset != null) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
		}*/
		List<Map<String,Object>> list = downloadRecordDao.getAllDownloadList(params);
		int count = downloadRecordDao.getAllDownloadListCount(params);
		
		List<Map<String,Object>> dayNumList = downloadRecordDao.getDownLoadRecordDay(params);
		
		for(int i=0;i<list.size();i++) {
			Map<String,Object> journalMap = list.get(i);
			String num = (String) journalMap.get("count").toString();
			String flag = (String) journalMap.get("schoolFlag");
			long dayNum=0;
			for(int j=0;j<dayNumList.size();j++) {
				if(dayNumList.get(j).get("orgFlag").equals(flag)) {
					dayNum = (Long) dayNumList.get(j).get("dayNum");
					break;
				}
			}
			float avg = (float) Float.parseFloat(num)/(float)dayNum;
			avg = (float)(Math.round(avg*100))/100;
			journalMap.put("avgPageByDay", avg);
		}
		list = CollectionsUtil.sort(list, sort);
		//分页
		int offsets = 0;
		if(StringUtils.isNotEmpty(offset)) {
            offsets = Integer.parseInt(offset);
        }
		int size = SystemContext.getPageSize();
		if(offsets != -1) {
			if(list.size() < offsets) {
				list = new ArrayList<Map<String,Object>>();
			} else if(list.size() > (offsets+size)) {
				list = list.subList(offsets, (offsets+size));
			} else {
				list = list.subList(offsets, list.size());
			}
		}
		pager.setRows(list);
		pager.setTotal(count);
		return pager;
		
	}
	/**
	 * 获取文章下载列表信息
	 */
	@Override
	public List<DownloadInfo> getList(String school,String beginTime,String endTime,String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("type", type);
		params.put("school", school);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		return downloadRecordDao.getList(params);
	}
	/**
	 * 获取文章下载列表信息数量
	 */
	@Override
	public int getListCount(String school,String beginTime,String endTime,String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("type", type);
		params.put("school", school);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		return downloadRecordDao.getListCount(params);
	}
	/**
	 * 获取文章下载所有数量
	 */
	@Override
	public int getAllCount(String school,String beginTime,String endTime,String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("type", type);
		params.put("school", school);
		params.put("beginTime", beginTime);
		if(endTime != null) {
			params.put("endTime", endTime+" 23:59:59");
		}
		return downloadRecordDao.getAllCount(params);
	}
	/**
	 * 获取摸文章的详细下载信息
	 */
	@Override
	public List<DownloadInfo> getInfoList(String school,String beginTime,String endTime,String title,String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("school", school);
		params.put("type", type);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("title", title);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		return downloadRecordDao.getInfoList(params);
	}
	/**
	 * 获取摸文章的详细下载信息count
	 */
	@Override
	public int getInfoListCount(String school,String beginTime,String endTime,String title,String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("school", school);
		params.put("type", type);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("title", title);
		return downloadRecordDao.getInfoListCount(params);
	}
	
	
	/**
	 * 创建excel表并保存(所有下载统计（根据学校）)
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void creatAlldownloadRecord(List<Map<String,Object>> list, String path) throws Exception{
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);         
		
		Label label0 = new Label(0,0,"序号");
		Label label1 = new Label(1,0,"学校");
		Label label2 = new Label(2,0,"总下载次数");
		Label label3 = new Label(3,0,"下载文章数");
		Label label4 = new Label(4,0,"下载次数/篇");
		Label label5 = new Label(5,0,"下载次数/日");
		sheet.addCell(label0);
		sheet.addCell(label1);
		sheet.addCell(label2);
		sheet.addCell(label3);
		sheet.addCell(label4);
		sheet.addCell(label5);
		for(int i=0 ; i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			Label label10 = new Label(0,i+1, (i+1)+"");
			Label label11 = new Label(1,i+1,(String) map.get("school"));
			Label label12 = new Label(2,i+1, map.get("count")+"");
			Label label13 = new Label(3,i+1, map.get("titleCount")+"");
			Label label14 = new Label(4,i+1, map.get("avg")+"");
			Label label15 = new Label(5,i+1, map.get("avgPageByDay")+"");
			sheet.addCell(label10);
			sheet.addCell(label11);
			sheet.addCell(label12);
			sheet.addCell(label13);
			sheet.addCell(label14);
			sheet.addCell(label15);
		}
		
		book.write();
		book.close();
	}
	
	/**
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getDownLoadRecordTitle(String orgFlag,
			String beginTime, String endTime, String size) {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", orgFlag);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime);
		params.put("size", Integer.parseInt(size));
		List<Map<String,Object>> list = downloadRecordDao.getDownLoadRecordTitle(params);
		
		int otherNum = 0,otherAddNum = 0;
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			String title = map.get("title").toString();
			if(i >= Integer.parseInt(size)) {
				otherNum += Integer.parseInt(map.get("num").toString());
				otherAddNum +=  Integer.parseInt(map.get("addNum").toString());
			} else {
				params.put("title", title);
				List<Map<String,Object>> timeList = downloadRecordDao.getDownLoadRecordByTitle(params);
				map.put("timeList", timeList);
				result.add(map);
			}
		}
		if(list.size() > Integer.parseInt(size)) {
			Map<String,Object> otherMap = new HashMap<String, Object>();		//其它
			otherMap.put("title", "其他");
			otherMap.put("num", otherNum);
			otherMap.put("addNum", otherAddNum);
			result.add(otherMap);
		}
		return result;
	}
	
	/**
	 * 数据添加功能（增加数据）
	 */
	@Override
	public void addDownloadInfo(Map<String,Object> param,String username) {
		String[] addNum = (String[]) param.get("addNum");
		List<DownloadInfo> list = downloadInfoList(param);
		for(int i=0;i<list.size();i++) {
			DownloadInfo downloadInfo = list.get(i);
			downloadRecordDao.insertDownloadRecordInfo(downloadInfo);
		}
		String beginTime =param.get("beginTime").toString();
		String endTime = param.get("endTime").toString();
		String orgFlag = param.get("orgFlag").toString();
		String orgName = param.get("orgName").toString();
		String[] titles = (String[]) param.get("titles");
		for (int i = 0; i < titles.length; i++) {
			Map<String,Object> params = new HashMap<String, Object>();
			String num = addNum[i];
			params.put("title", titles[i]);
			params.put("num", num);
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
			if(StringUtils.isNotBlank(num)) {
				logBrowseAutomatic("添加", params, "文章下载统计",username,orgFlag,orgName);
			}
		}
	}
	private List<DownloadInfo> downloadInfoList(Map<String,Object> params) {
		String beginTime =params.get("beginTime").toString();
		String endTime = params.get("endTime").toString();
		String[] titles = (String[]) params.get("titles");
		String[] addNum = (String[]) params.get("addNum");
		String orgFlag =params.get("orgFlag").toString();
		String orgName =params.get("orgName").toString();
		List<DownloadInfo> list = new ArrayList<DownloadInfo>();
		List<Map<String,Object>> touristList = memberDao.findTourist(params);
		for(int i=0;i<addNum.length;i++) {
			String num = addNum[i];
			if(!StringUtils.isEmpty(num)) {
				String title = titles[i];
				for(int j=0;j<Integer.parseInt(num);j++) {
					Map<String,Object> map = touristList.get((int) (Math.random()*touristList.size()));
					DownloadInfo downloadInfo = new DownloadInfo();
					String time = DateUtil.randomDate(beginTime+" 00:00:00", endTime+" 23:59:59");
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					downloadInfo.setTitle(title);
					downloadInfo.setSchoolFlag(orgFlag);
					downloadInfo.setSchool(orgName);
					downloadInfo.setType(1);
					downloadInfo.setIp(map.get("ip").toString());
					try {
						downloadInfo.setTime(format.parse(time));
					} catch (ParseException e) {
						e.printStackTrace();
					}
					list.add(downloadInfo);
				}
			}
		}
		return list;
	}
	/**
	 * 添加日志
	 * @param state
	 * @param params
	 */
	private void logBrowseAutomatic(String state,Map<String,Object> params,String type,String username,String orgFlag,String orgName) {
		Map<String,Object> param = new HashMap<String, Object>();
		String content = JsonUtil.obj2Json(params);
		param.put("time", new Date());
		param.put("content", content);
		param.put("state", state);
		param.put("type", type);
		param.put("orgFlag", orgFlag);
		param.put("orgName", orgName);
		param.put("username", username);
		additionDao.contentAnalysisLog(param);
	}
	@Override
	public Map<String,Object> getLog(String orgFlag,String title) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("type", "文章下载统计");
		param.put("orgFlag", orgFlag);
		param.put("keyword", "%"+title+"%");
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(param);
		if(list != null && list.size()>0) {
			return list.get(0);
		}
		return null;
	}
	@Override
	public Pager getLogList(String orgFlag) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("type", "文章下载统计");
		param.put("orgFlag", orgFlag);
		param.put("offset", SystemContext.getOffset());
		param.put("size", SystemContext.getPageSize());
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(param);
		int total = additionDao.getContentAnalysisLogCount(param);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < list.size(); i++) {
			Map<String,Object> json = list.get(i);
			String content = (String) json.get("content");
			Map<String,Object> resultMap = JsonUtil.json2Obj(content, Map.class);
			resultMap.put("time", json.get("time"));
			resultMap.put("username", json.get("username"));
			resultMap.put("orgName", json.get("orgName"));
			result.add(resultMap);
		}
		Pager pager = new Pager();
		pager.setRows(result);
		pager.setTotal(total);
		return pager;
	}
}
