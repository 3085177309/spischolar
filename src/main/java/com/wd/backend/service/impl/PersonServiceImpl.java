package com.wd.backend.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.bo.PersonBO;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.Person;
import com.wd.backend.service.PersonServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.util.MD5Util;
import com.wd.util.SimpleUtil;

@Service("personService")
public class PersonServiceImpl implements PersonServiceI {

	@Autowired
	private PersonDaoI personDao;

	@Override
	public Pager searchOrgPerson(Integer orgId) {

		Pager pager = new Pager();

		int count = personDao.getOrgPersonCount(orgId);
		pager.setTotal(count);
		if (count > 0) {
			Map<String, Object> params = new HashMap<String, Object>(3);
			params.put("orgId", orgId);
			params.put("size", SystemContext.getPageSize());
			params.put("offset", SystemContext.getOffset());
			List<Person> personList = personDao.findOrgPerson(params);
			pager.setRows(personList);
		}

		return pager;
	}

	@Override
	public PersonBO detail(Integer personId) {
		Person person = personDao.findById(personId);
		PersonBO bo = null;
		if (null != person) {
			bo = new PersonBO();
			BeanUtils.copyProperties(person, bo);
		}
		return bo;
	}

	@Override
	public void add(PersonBO person) throws SystemException {
		// 人员信息验证
		if (SimpleUtil.strIsNull(person.getName())) {
			throw new SystemException("姓名不能为空!");
		}
		if (SimpleUtil.strIsNull(person.getEmail()) || !SimpleUtil.isEmail(person.getEmail())) {
			throw new SystemException("邮箱格式错误!");
		}
		Integer emailExists = personDao.findEmailExists(person.getEmail());
		if (null != emailExists) {
			throw new SystemException("该邮箱已注册!");
		}
		// 设置默认密码
		person.setPassword(MD5Util.getMD5(person.getPassword().getBytes()));
		person.setRegisterDate(new Date());
		// 验证当前用户是否具有赋予对应权限的能力(系统超级管理员能赋予所有角色，机构超级管理员只能授予机构站点管理员角色，机构站点管理员不能授予任何角色)
		Person model = new Person();
		BeanUtils.copyProperties(person, model);
		try {
			personDao.insert(model);
			person.setId(model.getId());
		} catch (RuntimeException e) {
			throw new SystemException("人员新增失败!", e);
		}
	}

	@Override
	public void edit(PersonBO person) throws SystemException {
		// 人员信息验证
		if (SimpleUtil.strIsNull(person.getName())) {
			throw new SystemException("姓名不能为空!");
		}
		if (person.getStatus() != 1 && person.getStatus() != 2) {
			// 如果用户状态设置异常，那么就将用户设置为禁用状态
			person.setStatus(2);
		}
		// 检查角色设置，不能设置自己的角色，不能将自己设置为更高的角色
		Person model = new Person();
		BeanUtils.copyProperties(person, model);
		int updateCount = personDao.update(model);
		if (updateCount == 0) {
			throw new SystemException("人员信息更新失败!");
		}
	}

	@Override
	public void del(Integer personId) {
		personDao.del(personId);
	}

	@Override
	public void editStatus(Integer personId, Integer status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", personId);
		if (1 != status && 2 != status) {
			// 如果是错误的状态值，那么就将人员状态修改为禁用状态
			status = 2;
		}
		params.put("status", status);
		personDao.updateStatus(params);
	}

	@Override
	public void editPwd(PersonBO person) throws SystemException {
		Person model = personDao.findById(person.getId());
		if (null == model) {
			throw new SystemException("无法找到该人员数据，请确认人员信息是否存在!");
		}
		if (!model.getPassword().equals(MD5Util.getMD5(person.getOldPwd().getBytes()))) {
			throw new SystemException("原始密码错误!");
		}
		if (SimpleUtil.strIsNull(person.getPassword()) || !person.getPassword().equals(person.getNewPwd())) {
			throw new SystemException("两次新密码不一致!");
		}
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("id", person.getId());
		params.put("pwd", MD5Util.getMD5(person.getNewPwd().getBytes()));
		personDao.updatePwd(params);
	}

	@Override
	public void editPwdByReset(Integer personId) {
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("id", personId);
		params.put("pwd", MD5Util.getMD5("123654".getBytes()));
		personDao.updatePwd(params);
	}
}
