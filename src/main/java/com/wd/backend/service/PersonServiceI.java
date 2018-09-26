package com.wd.backend.service;

import com.wd.backend.bo.Pager;
import com.wd.backend.bo.PersonBO;
import com.wd.exeception.SystemException;

public interface PersonServiceI {

	/**
	 * 分页查找机构下的人员列表
	 * 
	 * @param orgId
	 * @return
	 */
	Pager searchOrgPerson(Integer orgId);

	/**
	 * 获取人员详细信息
	 * 
	 * @param personId
	 * @return
	 */
	PersonBO detail(Integer personId);

	/**
	 * 人员添加
	 * 
	 * @param person
	 * @throws SystemException
	 *             当人员信息不符合系统约束时，抛出此异常
	 */
	void add(PersonBO person) throws SystemException;

	/**
	 * 编辑人员信息
	 * 
	 * @param person
	 * @throws SystemException
	 *             当人员信息不符合系统约束时，抛出此异常
	 */
	void edit(PersonBO person) throws SystemException;

	/**
	 * 删除人员信息
	 * 
	 * @param personId
	 */
	void del(Integer personId);

	/**
	 * 修改人员的状态
	 * 
	 * @param personId
	 *            人员id
	 * @param status
	 *            状态
	 */
	void editStatus(Integer personId, Integer status);

	/**
	 * 密码修改
	 * 
	 * @param person
	 * @throws SystemException
	 *             当原始密码错误或新密码不符合系统约束时抛出此异常
	 */
	void editPwd(PersonBO person) throws SystemException;

	/**
	 * 密码重置(重置为"123654")
	 * 
	 * @param personId
	 */
	void editPwdByReset(Integer personId);

}
