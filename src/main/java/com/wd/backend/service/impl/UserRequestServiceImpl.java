package com.wd.backend.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.ProductDaoI;
import com.wd.backend.dao.UserRequestDaoI;
import com.wd.backend.model.Department;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.backend.model.UserRequest;
import com.wd.backend.service.UserRequestServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.util.JsonUtil;

@Service("userRequestService")
public class UserRequestServiceImpl implements UserRequestServiceI {

	@Autowired
	private UserRequestDaoI userRequestDao;
	
	@Autowired
	private MemberDaoI memberDao;
	
	@Autowired
	private OrgDaoI orgDao;
	
	@Autowired
	private ProductDaoI productDao;
	
	@Override
	public void insert(UserRequest userRequest) {
		userRequestDao.insert(userRequest);
		
	}

	@Override
	public List<UserRequest> findAll(int type,String keyword) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("keyword", keyword);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		List<UserRequest> list =userRequestDao.findAll(params);
		List<UserRequest> listAfter = new ArrayList<UserRequest>();
		for(int i=0; i< list.size();i++) {
			UserRequest userRequest = new UserRequest();
			userRequest = list.get(i);
		/**	if(userRequest.getFunction().contains("org/list")) {
				OrgBO org = JsonUtil.json2Obj(userRequest.getParam(), OrgBO.class);
				userRequest.setOrg(org);
			}**/
			String function = userRequest.getFunction();
			if(function.contains("用户信息")) {
				if(function.contains("删除")) {
					Member member = JsonUtil.json2Obj(userRequest.getParam(), Member.class);
					userRequest.setMember(member);
				} else if(function.contains("添加")){
					Member memberAfter = JsonUtil.json2Obj(userRequest.getParam(), Member.class);
					userRequest.setMemberAfter(memberAfter);
				} else {//修改
					Member memberAfter = JsonUtil.json2Obj(userRequest.getParam(), Member.class);
					userRequest.setMemberAfter(memberAfter);
					Member member = memberDao.getById(memberAfter.getId());
					userRequest.setMember(member);
				}
			} else if(function.contains("学院信息")) {
				if(function.contains("删除")) {
					Department department = JsonUtil.json2Obj(userRequest.getParam(), Department.class);
					userRequest.setDepartment(department);
				} else if(function.contains("添加")){
					Department departmentAfter = JsonUtil.json2Obj(userRequest.getParam(), Department.class);
					userRequest.setDepartmentAfter(departmentAfter);
				} else {//修改
					Department departmentAfter = JsonUtil.json2Obj(userRequest.getParam(), Department.class);
					userRequest.setDepartmentAfter(departmentAfter);
					Department department = orgDao.findDepartmentById(departmentAfter.getDepartmentId());
					userRequest.setDepartment(department);
				}
			} else if(function.contains("学校信息")) {
				Org orgAfter = JsonUtil.json2Obj(userRequest.getParam(), Org.class);
				userRequest.setOrgAfter(orgAfter);
				
				Org model = orgDao.findById(orgAfter.getId());
				userRequest.setOrg(model);
			} 
			listAfter.add(userRequest);
		}
		return listAfter;
	}
	
	@Override
	public int findAllCount(int type,String keyword) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("keyword", keyword);
		int count = userRequestDao.findAllCount(params);
		return count;
	}
	
	@Override
	public void updateById(int id) {
		userRequestDao.updateById(id);
	}

}
