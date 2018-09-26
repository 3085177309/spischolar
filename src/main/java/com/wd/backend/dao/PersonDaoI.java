package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Department;
import com.wd.backend.model.Person;

public interface PersonDaoI {
	/**
	 * 通过邮箱和密码查找用户
	 * 
	 * @return
	 */
	Person findByEmailPwd(Person person);
	/**
	 * 通过用户名和面查找
	 * @param person
	 * @return
	 */
	Person findByNamePwd(Person person);
	/**
	 * 通过机构id删除人员
	 * 
	 * @param id
	 */
	void deleteByOrg(Integer id);
	/**
	 * 获取机构下的人员总数
	 * 
	 * @param orgId
	 * @return
	 */
	int getOrgPersonCount(Integer orgId);
	
	public List<Map<String,Object>> findCount(Map<String,Object> params);
	
	void updateUserDepartment(Department department);
	
	/**
	 * 更新个人人员状态
	 * 
	 * @param params
	 */
	void updateStatus(Map<String, Object> params);

	/**
	 * 更改所有人员的登陆状态
	 */
	void updateAllStatus();
	
	/**
	 * 用户校外登陆权限时限认证
	 */
	void updatePermission();
	

	

	/**
	 * 获取机构下的人员列表
	 * 
	 * @param params
	 * @return
	 */
	List<Person> findOrgPerson(Map<String, Object> params);

	/**
	 * 通过id查找人员信息
	 * 
	 * @param personId
	 * @return
	 */
	Person findById(Integer personId);

	/**
	 * 查找指定邮箱是否存在
	 * 
	 * @param email
	 * @return 返回null表示不存在
	 */
	Integer findEmailExists(String email);

	/**
	 * 新增人员
	 * 
	 * @param model
	 */
	void insert(Person model);

	/**
	 * 更新人员信息
	 * 
	 * @param model
	 */
	int update(Person model);

	/**
	 * 根据id删除人员
	 * 
	 * @param personId
	 */
	void del(Integer personId);

	
	

	/**
	 * 修改密码
	 * 
	 * @param params
	 */
	void updatePwd(Map<String, Object> params);

	
	
	
	
	
	
	

}
