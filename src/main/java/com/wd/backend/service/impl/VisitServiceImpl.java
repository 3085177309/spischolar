package com.wd.backend.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.module.es.BrowseSearchI;
import com.wd.backend.service.VisitServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.util.CollectionsUtil;
import com.wd.util.DateUtil;
import com.wd.util.DoubleUtil;

@Service("visitService")
public class VisitServiceImpl implements VisitServiceI {

	@Autowired
	private BrowseSearchI browseSearch;

	/**
	 * 访客来源
	 */
	@Override
	public List<Map<String, Object>> findVisiteCome(String school,String beginTime,String endTime,String type,String sort) {
		String[] types = {"浏览量（PV）","访客数（UV）","IP数","平均访问时长","平均访问页数","跳出率"};
		String filed = null;
		int offset = SystemContext.getOffset();
		int size = 10;
		List<Map<String, Object>> list = null;
		if(school != null) {
			filed = "refererUrl";
			list = browseSearch.visitLan(types, school, beginTime, endTime, filed, offset,size,-1,sort,type);
			list = CollectionsUtil.sort(list, sort);
			list.addAll(browseSearch.visitLan(types, school, beginTime, endTime, "schoolFlag", offset,size,-1,sort,type));
		} else {
			filed = "schoolFlag";
			list = browseSearch.visitLan(types, school, beginTime, endTime, filed, offset,size,-1,sort,type);
			list = CollectionsUtil.sort(list, sort);
		}
		//分页
		if(list.size() < offset) {
			list = new ArrayList<Map<String,Object>>();
		} else if(list.size() > (offset+size)) {
			list = list.subList(offset, (offset+size));
		} else {
			list = list.subList(offset, list.size());
		}
		return list;
		
	}

	/**
	 * 地域分布table表格
	 * @param province
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	@Override
    public List<Map<String, Object>> findRegionTableList(String[] types, String province, String beginTime, String endTime, String type, String offset, String sort){
		int offsets = 0;
		if(StringUtils.isNotEmpty(offset)) {
            offsets = Integer.parseInt(offset);
        }
		List<Map<String, Object>> list = null;
		if(StringUtils.isEmpty(province) || "all".equals(province)) {
			list = browseSearch.visitLan(types, province, beginTime, endTime, "schoolProvince",offsets,20,-1,sort,type);
		} else {
			list = browseSearch.visitLan(types, province, beginTime, endTime, "schoolFlagRegion",offsets,20,-1,sort,type);
		}
		list = CollectionsUtil.sort(list, sort);
		//分页
		int size = SystemContext.getPageSize();
		if(list.size() < offsets) {
			list = new ArrayList<Map<String,Object>>();
		} else if(list.size() > (offsets+size)) {
			list = list.subList(offsets, (offsets+size));
		} else {
			list = list.subList(offsets, list.size());
		}
		return list;
	}
	
	/**
	 * 地域分布（图表）
	 * @return
	 */
	@Override
    public Map<String, Object> findRegion(String[] types, String beginTime, String endTime, String type) {
		List<Map<String, Object>> list = browseSearch.visitLan(types, null, beginTime, endTime, "schoolProvince",-1,-1,-1,null,type);
		Map<String, Object> map = new LinkedMap();
		map.put("types", types);
		for(int i=0;i<list.size();i++) {
			Map<String, Object> dataMap = list.get(i);
			for (String key : dataMap.keySet()) {
				if(!"schoolProvince".equals(key)) {
					map.put((String)dataMap.get("schoolProvince"),  dataMap.get(key));
				}
			}
		}
		return map;
	}


	@Override
	public List<Map<String, Object>> getNewOld(String type,String school, String beginTime, String endTime) {
		String[] types = {"浏览量（PV）","访客数（UV）","IP数","平均访问时长","平均访问页数","跳出率"};
		List<Map<String, Object>> list = browseSearch.visitLan(types, school, beginTime, endTime, "memberType",-1,-1,-1,null,type);
		double allUv = 0;
		for (Map<String, Object> map : list) {
			allUv += (double)map.get("uv");
		}
		for (Map<String, Object> map : list) {
			if(allUv == 0) {
				map.put("proportion", 0);
			} else {
				double proportion = (double)map.get("uv") / allUv;
				map.put("proportion", DoubleUtil.format(proportion*100));
			}
		}
		return list;
	}
	
	@Override
    public int getNewOldBroListTotal(String type, String school, String beginTime, String endTime, int isnew){
		String[] types = {"浏览量（PV）","访客数（UV）","IP数","平均访问时长","平均访问页数","跳出率"};
		List<Map<String, Object>> list = browseSearch.visitLan(types, school, beginTime, endTime, "refererUrl",0,6,isnew,null,type);
		if(list.size()>0) {
			return (int) list.get(0).get("count");
		}
		return 0;
	}
	
	@Override
    public List<Map<String, Object>> getNewOldBroList(String type, String school, String beginTime, String endTime, int isnew, String offset){
		String[] types = {"浏览量（PV）","访客数（UV）","IP数","平均访问时长","平均访问页数","跳出率"};
		int size = 20;
		int offsets = 0;
		if(StringUtils.isNotEmpty(offset)) {
            offsets = Integer.parseInt(offset);
        }
		List<Map<String, Object>> list = browseSearch.visitLan(types, school, beginTime, endTime, "refererUrl",offsets,size,isnew,"pv_down",type);
		//分页
		if(list.size() < offsets) {
			list = new ArrayList<Map<String,Object>>();
		} else if(list.size() > (offsets+size)) {
			list = list.subList(offsets, (offsets+size));
		} else {
			list = list.subList(offsets, list.size());
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getKeepUser(String type, String beginTime,
			String endTime, String day,String school) {
		Map<String, Map<String, Long>> newMap = browseSearch.keep(beginTime, endTime, school, Integer.parseInt(day), 0,type);
		Map<String, Map<String, Long>> oldMap = browseSearch.keep(beginTime, endTime, school, Integer.parseInt(day), 1,type);
		
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(String newTimeKey : newMap.keySet()) {
			Map<String, Long> newTimeMap = newMap.get(newTimeKey);
			double newCount = newTimeMap.remove("count");
			List<Double> keepList = new ArrayList<Double>();
			for(String oldTimeKey : oldMap.keySet()) {
				int days = DateUtil.getDayNum(oldTimeKey, newTimeKey);
				int maxSize=7;
				if(Integer.parseInt(day) == 2) {
                    maxSize = 49;
                }
				if(Integer.parseInt(day) == 3) {
                    maxSize = 210;
                }
				if(days>0 && days<maxSize) {
					double oldCount = 0;
					Map<String, Long> oldTimeMap = oldMap.get(oldTimeKey);
					for(String oldMemberId : oldTimeMap.keySet()) {
						if(newTimeMap.containsKey(oldMemberId)) {
							oldCount++;
						}
					}
					double value = (oldCount/newCount)*100;
					if(Double.isNaN(value)) {
                        value = 0;
                    }
					BigDecimal   b   =   new   BigDecimal(value);  
					value  =   b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();  
					keepList.add(value);
				}
			}
			Map<String, Object> map = new LinkedMap();
			map.put("time", newTimeKey);
			map.put("addUsers", newCount);
			map.put("keeps", keepList);
			list.add(map);
		}
		String js = com.wd.util.JsonUtil.obj2Json(list);
		System.out.println(js);
		return list;
	}


	
	
}
