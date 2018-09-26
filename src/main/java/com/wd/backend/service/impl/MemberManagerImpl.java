package com.wd.backend.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.model.Department;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.service.MemberManagerI;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.front.service.OperationException;
import com.wd.util.JsonUtil;
import com.wd.util.MD5Util;
import com.wd.util.SimpleUtil;

@Service("memberManager")
public class MemberManagerImpl implements MemberManagerI{
	
	@Autowired
	private MemberDaoI memberDao;
	
	@Autowired
	private  AdditionDaoI additionDao;
	
	@Autowired
	private OrgDaoI orgDao;
	
	@Override
	public Map<String, Object> getCount(String school, String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("schoolFlag", school);
		params.put("type", type);
		return memberDao.getCount(params);
	}
	
	@Override
	public Pager getMemberSchool(String offset) {
		Pager pager = new Pager();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		List<Map<String,Object>> list = memberDao.getMemberSchool(params);
		int count =  memberDao.getMemberSchoolCount(params);
		pager.setRows(list);
		pager.setTotal(count);
		return pager;
	}

	@Override
	public Pager findPager(String key,String schoolFlag,String department,String order) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("schoolFlag", schoolFlag);
		params.put("department", department);
		if(key == null) {
			
		} else {
			if("管理员".contains(key)) {
                key = "userType1";
            }
			if("终端用户".contains(key)) {
                key = "userType0";
            }
			params.put("key", "%"+key+"%");
		}
		if(StringUtils.isNotEmpty(order)) {
			params.put("order", Integer.parseInt(order));
		}
		
		Pager p=new Pager();
		int count=memberDao.findCount(params);
		p.setTotal(count);
		if(count>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(memberDao.findList(params));
		}
		return p;
	}
	@Override
	public int register(Member member) throws OperationException {
		String encodePwd=MD5Util.getMD5(member.getPwd().getBytes());
		member.setPwd(encodePwd);
		member.setRegisterTime(new Date());
		member.setLoginTime(new Date());
		memberDao.insert(member);
		return member.getId();
	}
	@Override
	public void update(Member member) {
		memberDao.resetProfile(member);
	}
	@Override
	public void registerUsers(InputStream in,String ip) throws SystemException {
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(in);
			if(book!=null) {
				// 获得第一个工作表对象
				Sheet sheet = book.getSheet(0);
				for (int i = 1; i < sheet.getRows(); i++) {
					Member member = new Member();
					String email = sheet.getCell(1,i).getContents();
					String userName = sheet.getCell(2,i).getContents();
					int existEmail = memberDao.isEmailExists(email);
					int existUserName = memberDao.isUsernameExists(userName);
					if(existEmail > 0 || existUserName >0) {
						continue;
					}
					member.setEmail(email);
					member.setUsername(userName);
					member.setPwd(MD5Util.getMD5(sheet.getCell(3,i).getContents().getBytes()));
					member.setSchool(sheet.getCell(4,i).getContents());
					member.setSchoolFlag(sheet.getCell(5,i).getContents());
					member.setDepartment(sheet.getCell(6,i).getContents());
					member.setUserType(Integer.parseInt(sheet.getCell(7,i).getContents()));
					member.setRegisterIp(ip);
					/**
					member.setSchool(sheet.getCell(4,i).getContents());
					member.setSchoolFlag(sheet.getCell(5,i).getContents());
					member.setDepartment(sheet.getCell(6,i).getContents());
					member.setDepartmentFlag(sheet.getCell(7,i).getContents());
					member.setIdentity(Integer.parseInt(sheet.getCell(8,i).getContents()));
					member.setEducation(sheet.getCell(9,i).getContents());
					member.setSex(Short.parseShort(sheet.getCell(10,i).getContents()));
					*/
					member.setRegisterTime(new Date());
					member.setLoginTime(new Date());
					int isEmail = memberDao.isEmailExists(email);
					int isUserName = memberDao.isUsernameExists(userName);
					if(isEmail==0 && isUserName==0) {
						memberDao.insert(member);
					}
				}
				book.close();
			} 
		} catch (Exception e) {
			throw new SystemException("文本格式内容不正确！");
		}
	}
	@Override
	public void deleteUser(int id) {
		memberDao.deleteUser(id);
	}
	
	@Override
    public Member getById(int id){
		return memberDao.getById(id);
	}
	@Override
	public void applyLogin(Member member) throws OperationException {
		memberDao.applyLogin(member);
	}
	@Override
	public void forbidden(Member member) throws OperationException {
		memberDao.forbidden(member);
	}
	/**
	 * 后台校外登陆申请
	 */
	@Override
	public Pager findPagerByApply(Map<String, Object> params) {
		Pager p=new Pager();
		int count=memberDao.findCountByApply(params);
		p.setTotal(count);
		if(count>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(memberDao.findListByApply(params));
		}
		return p;
	}
	
	/**
	 * 文献传递请求权限设置（通过邮箱找学校）
	 * @return
	 */
	@Override
	public Member findByEmail(String email) {
		return memberDao.findByEmail(email);
	}
	
	@Override
	public Map<String,Object> findTouristCount(String orgFlag,String beginTime,String endTime) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("orgFlag", orgFlag);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime);
		Map<String,Object> loginCount = memberDao.findUserLoginCount(params);
		List<Map<String,Object>> list = memberDao.findTouristCount(params);
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("count", 0);
		result.put("addCount", 0);
		result.put("name", "游客数");
		for (Map<String, Object> map : list) {
			if((int) map.get("type") == 1) {
				result.put("addCount", map.get("count"));
			} else {
				result.put("count", map.get("count"));
			}
		}
		result.put("loginCount", loginCount);
//		result.put("loginAddTime", loginAddTime);
//		result.put("loginAddUsername", loginAddUsername);
//		result.put("touristTime", touristTime);
//		result.put("touristUsername", touristUsername);
		return result;
	}
	
	@Override
	public Pager getLogList(String orgFlag) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("type", "学校用户管理");
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
	
	/**
	 * 数据添加功能（增加数据）
	 * @param list
	 */
	@Override
	public void addUserRecord(Map<String,Object> param,String username) {
		Map<String,Object> params = new HashMap<String, Object>();
		String loginCount = param.get("loginCount").toString();
		String touristCount = param.get("touristCount").toString();
		String orgFlag = param.get("orgFlag").toString();
		String orgName = param.get("orgName").toString();
		//String time = param.get("time").toString();
		Org org = orgDao.findByFlag(orgFlag);
		if(StringUtils.isNotEmpty(loginCount)) {//增加登陆次数
			List<Map<String,Object>> ids = memberDao.findUserIds(param);
			if(ids.size() != 0) {
				int num = Integer.parseInt(loginCount)/ids.size()+1;
				params.put("name", "增加登陆次数");
				params.put("num", loginCount);
				params.put("beginTime", param.get("beginTime"));
				params.put("endTime", param.get("endTime"));
				for (Map<String, Object> map : ids) {
					if(Integer.parseInt(loginCount) <= 0) {
						break;
					}
					if(Integer.parseInt(loginCount) >= num) {
						loginCount = Integer.parseInt(loginCount) - num + "";
					} else {
						num = Integer.parseInt(loginCount);
					}
					int count = 0;
					if(map.containsKey("loginCountAdd") && map.get("loginCountAdd") != null) {
						count = (int) map.get("loginCountAdd");
					}
					map.put("loginCountAdd", count + num);
					System.out.println("loginCount:"+loginCount+"--num:"+num);
					memberDao.updateLogin(map);
				}
				logBrowseAutomatic("添加", params, "学校用户管理", username, orgFlag,orgName);
			}
		}
		if(StringUtils.isNotEmpty(touristCount)) {//增加游客
			params = new HashMap<String, Object>();
			params.put("name", "增加游客数");
			params.put("num", touristCount);
			params.put("beginTime", param.get("beginTime"));
			params.put("endTime", param.get("endTime"));
			int touristCounts = Integer.parseInt(touristCount);
			for(int i=0;i<touristCounts;i++) {
				memberDao.insert(touristMember(org));
			}
			logBrowseAutomatic("添加", params, "学校用户管理", username, orgFlag,orgName);
		}
	}
	
	private Member touristMember(Org org) {
		Member member = new Member();
		member.setUsername("Tourist");
		member.setEmail("Tourist");
		member.setSchool(org.getName());
		member.setSchoolFlag(org.getFlag());
		//member.setRegisterIp("");
		member.setRegisterTime(new Date());
		member.setLoginTime(new Date());
		member.setPwd("d2b1be1068c645f392f21e0df52c57cc");
		member.setType(1);
		return member;
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

}
