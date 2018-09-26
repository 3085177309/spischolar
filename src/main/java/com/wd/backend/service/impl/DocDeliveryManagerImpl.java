package com.wd.backend.service.impl;

import java.io.File;
import java.math.BigDecimal;
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
import com.wd.backend.dao.DocDeliveryDaoI;
import com.wd.backend.model.DeliveryValidity;
import com.wd.backend.model.DocDelivery;
import com.wd.backend.service.DocDeliveryManagerI;
import com.wd.comm.context.SystemContext;
import com.wd.util.CollectionsUtil;
import com.wd.util.DateUtil;
import com.wd.util.DoubleUtil;

@Service("docDeliveryManager")
public class DocDeliveryManagerImpl implements DocDeliveryManagerI{
	
	@Autowired
	private DocDeliveryDaoI deliveryDao;
	
	@Override
	public int findAllDeliveryCountBySchool(String school) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orgFlag", school);
		return deliveryDao.findCountByParams(params);
	}
	
	@Override
	public Pager findPager(Integer orgId,Integer userId,Short processType,String keyword,String school,String beginTime,String endTime){
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orgId", orgId);
		params.put("procesorId", userId);
		params.put("processType", processType);
		params.put("keyword", keyword);
		params.put("orgFlag", school);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime + " 23:59:59");
		int total = deliveryDao.findCountByParams(params);
		pager.setTotal(total);
		if (total > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<DocDelivery> docDeliveryList = deliveryDao.findListByParams(params);
			pager.setRows(docDeliveryList);
		}
		return pager;
	}
	
	@Override
	public Pager findPager(String email) {
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("email", email);
		int total = deliveryDao.findCountByParams(params);
		pager.setTotal(total);
		if (total > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<DocDelivery> docDeliveryList = deliveryDao.findListByParams(params);
			pager.setRows(docDeliveryList);
		}
		return pager;
	}

	@Override
	public void add(DocDelivery dilivery) {
		deliveryDao.insert(dilivery);
	}
	
	@Override
	public boolean exist(DocDelivery dilivery){
		if(deliveryDao.findExist(dilivery)>0){
			return true;
		}
		return false;
	}

	@Override
	public void edit(DocDelivery dilivery) {
		deliveryDao.update(dilivery);
	}

	@Override
	public DocDelivery get(Long id) {
		return deliveryDao.findById(id);
	}
	
	@Override
	public Pager findDeliveryValidity(String keyWord) {
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("keyWord", keyWord);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		int total = deliveryDao.findDeliveryValidityCount(params);
		List<DeliveryValidity> list = deliveryDao.findDeliveryValidity(params);
		pager.setRows(list);
		pager.setTotal(total);
		return pager;
	}
	
	@Override
	public int addDeliveryValidity(DeliveryValidity deliveryValidity) {
		return deliveryDao.addDeliveryValidity(deliveryValidity);
	}
	
	@Override
	public int updateDeliveryValidity(DeliveryValidity deliveryValidity) {
		return deliveryDao.updateDeliveryValidity(deliveryValidity);
	}
	
	@Override
	public void deleteDeliveryValidity(int id) {
		deliveryDao.deleteDeliveryValidity(id);
	}

	
	/**
	 * 文献传递统计
	 * @return
	 */
	@Override
	public Pager getDeliveryRecord(String beginTime, String endTime,String offset,String sort,String key,String type) {
		Pager pager = new Pager();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("key", key);
		params.put("type", Integer.parseInt(type));
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
	
		List<Map<String,Object>> list = deliveryDao.getDeliveryRecord(params);
		List<Map<String,Object>> dayNumList = deliveryDao.getDeliveryRecordDay(params);
		int count = list.size();
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			long num = (Long) map.get("num");
			String flag = (String) map.get("orgFlag");
			long dayNum=0;
			for(int j=0;j<dayNumList.size();j++) {
				if(dayNumList.get(j).get("orgFlag").equals(flag)) {
					dayNum = (Long) dayNumList.get(j).get("dayNum");
					break;
				}
			}
			double successTime = Double.parseDouble( map.get("successTime").toString());
			double avgUser = Double.parseDouble( map.get("avgUser").toString());
			double avgDay = (double)num/dayNum;
			map.put("successTime", DoubleUtil.format(successTime*100));
			map.put("avgUser", DoubleUtil.format(avgUser));
			map.put("avgDay", DoubleUtil.format(avgDay));
		}
		list = CollectionsUtil.sort(list, sort);
		//int count = deliveryDao.getDeliveryRecordCount(params);
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
	 * 文献传递统计(根据学校)
	 * @return
	 */
	@Override
	public Pager getDeliveryRecordByOrgFlag(String email,String orgFlag,String beginTime, String endTime,
			String offset,String sort,String type) {
		Pager pager = new Pager();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("email", email);
		params.put("type", Integer.parseInt(type));
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("orgFlag", orgFlag);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		List<Map<String,Object>> list = deliveryDao.getDeliveryRecordByOrgFlag(params);
		List<Map<String,Object>> dayNumList = deliveryDao.getDeliveryRecordByOrgFlagDay(params);
		
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			long num = (Long) map.get("num");
			String flag = (String) map.get("email");
			long dayNum=0;
			for(int j=0;j<dayNumList.size();j++) {
				if(dayNumList.get(j).get("email").toString().toLowerCase().equals(flag.toLowerCase())) {
					dayNum = (Long) dayNumList.get(j).get("dayNum");
					break;
				}
			}
			double successTime = Double.parseDouble( map.get("successTime").toString());
			double avgDay = (double)num/dayNum;
			map.put("successTime", DoubleUtil.format(successTime*100));
			map.put("avgDay", DoubleUtil.format(avgDay));

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
		int count = deliveryDao.getDeliveryRecordByOrgFlagCount(params);
		pager.setRows(list);
		pager.setTotal(count);
		return pager;
	}
	
	/**
	 * 查询文献传递总请求次数
	 * @return
	 */
	@Override
	public int getDeliveryRecordByOrgFlagAllCount(String email,String orgFlag,String beginTime, String endTime,
			String offset,String type) {
		Pager pager = new Pager();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("email", email);
		params.put("type", Integer.parseInt(type));
		params.put("beginTime", beginTime);
		params.put("endTime", endTime+" 23:59:59");
		params.put("orgFlag", orgFlag);
		String count = deliveryDao.getDeliveryRecordByOrgFlagAllCount(params);
		if(StringUtils.isNotEmpty(count)) {
			return Integer.parseInt(count);
		}
		return 0;
	}
	
	
	/**
	 * 创建excel表并保存(所有文献传递统计（根据学校）)
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void downloadRecord(List<Map<String,Object>> list, String path) throws Exception{
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);         
		
		Label label0 = new Label(0,0,"序号");
		Label label1 = new Label(1,0,"学校");
		Label label2 = new Label(2,0,"总请求量");
		Label label3 = new Label(3,0,"传递成功率");
		Label label4 = new Label(4,0,"请求用户数");
		Label label5 = new Label(5,0,"人均请求量");
		Label label6 = new Label(6,0,"日均请求量");
		sheet.addCell(label0);
		sheet.addCell(label1);
		sheet.addCell(label2);
		sheet.addCell(label3);
		sheet.addCell(label4);
		sheet.addCell(label5);
		sheet.addCell(label6);
		for(int i=0 ; i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			Label label10 = new Label(0,i+1, (i+1)+"");
			Label label11 = new Label(1,i+1,(String) map.get("orgName"));
			Label label12 = new Label(2,i+1, map.get("num")+"");
			Label label13 = new Label(3,i+1, map.get("successTime")+"%");
			Label label14 = new Label(4,i+1, map.get("userNum")+"");
			Label label15 = new Label(5,i+1, map.get("avgUser")+"");
			Label label16 = new Label(6,i+1, map.get("avgDay")+"");
			sheet.addCell(label10);
			sheet.addCell(label11);
			sheet.addCell(label12);
			sheet.addCell(label13);
			sheet.addCell(label14);
			sheet.addCell(label15);
			sheet.addCell(label16);
		}
		
		book.write();
		book.close();
	}

	/**
	 * <!-- 手动数据添加（数据展示） -->
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getDeliveryRecordTitle(String orgFlag,
			String beginTime, String endTime, String size) {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("orgFlag", orgFlag);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime);
		params.put("size", Integer.parseInt(size));
		List<Map<String,Object>> list = deliveryDao.getDeliveryRecordTitle(params);
		
		int otherNum = 0,otherAddNum = 0;
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			String email = map.get("email").toString();
			if(i >= Integer.parseInt(size)) {
				otherNum += Integer.parseInt(map.get("num").toString());
				otherAddNum +=  Integer.parseInt(map.get("addNum").toString());
			} else {
				params.put("email", email);
				List<Map<String,Object>> timeList = deliveryDao.getDeliveryRecordByTitle(params);
				map.put("timeList", timeList);
			}
		}
		if(list.size() > Integer.parseInt(size)) {
			Map<String,Object> otherMap = new HashMap<String, Object>();		//其它
			otherMap.put("email", "其他");
			otherMap.put("num", otherNum);
			otherMap.put("addNum", otherAddNum);
			result.add(otherMap);
		}
		return result;
	}
	
	@Override
    public void diliverHelp(long id, int helpId, int procesorId, String procesorName) {
		Map<String,Object> param=new HashMap<String,Object>();
		Date date = new Date();
		String time = DateUtil.format(date);
		param.put("id", id);
		param.put("helpId", helpId);
		param.put("id", id);
		param.put("procesorId", procesorId);
		param.put("procesorName", procesorName);
		param.put("time", time);
		if(helpId == 3) {
			param.put("processType", 1);
		}
		deliveryDao.updateHelp(param);
	}

}
