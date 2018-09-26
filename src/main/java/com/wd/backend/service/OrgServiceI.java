package com.wd.backend.service;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.model.Department;
import com.wd.exeception.SystemException;

/**
 * 机构服务接口
 * 
 * @author pan
 * 
 */
public interface OrgServiceI {

	/**
	 * 新增机构
	 * 
	 * @param org
	 * @throws SystemException
	 *             当机构信息不符合系统约束时，抛出此异常
	 */
	void add(OrgBO org) throws SystemException;

	/**
	 * 获取机构详细信息
	 * 
	 * @param orgId
	 * @return
	 */
	OrgBO detail(Integer orgId);

	/**
	 * 删除机构(删除机构时，要同时删除站点和人员)
	 * 
	 * @param orgId
	 */
	void delete(Integer orgId);

	/**
	 * 已分页方式检索机构列表
	 * 
	 * @return
	 */
	Pager searchPager(String key,String ip);
	
	Pager searchPager(String key,Integer product);

	/**
	 * 编辑机构信息
	 * 
	 * @param org
	 * @throws SystemException
	 *             当机构信息不符合系统约束时，抛出此异常
	 */
	void edit(OrgBO org,String flag) throws SystemException;

	/**
	 * 编辑机构ip范围
	 * 
	 * @param org
	 * @throws SystemException
	 *             当ip格式错误或与其它ip范围有交集时，抛出此异常
	 */
	void editIpRange(OrgBO org) throws SystemException;
	
	/**
	 * 查找机构标识是否已经存在
	 * @param flag
	 * @return
	 */
	Boolean findExistsFlag(String flag);
	
	/**
	 * 检测机构名是否存在
	 * @param orgName
	 * @return
	 */
	Boolean findOrgNameExist(String orgName);
	
	/**
	 * 检测IP范围是否存在
	 * @param startIp
	 * @param endIp
	 * @return
	 */
	Boolean findIpRangesExist(Integer orgId,String startIp,String endIp);
	
	/**
	 * 通过Flag查找机构
	 * @param flag
	 * @return
	 */
	OrgBO findOrgByFlag(String flag);
	/**
	 * 根据学校id查学院
	 * @param schoolId
	 * @return
	 */
	List<Department> findDepBySchool(int schoolId);
	
	void addDep(InputStream input,int schoolId,String departmentName,String flag) throws SystemException;
	
	void deleteDepartment(int id);
	/**
	 * 根据学院ID修改学院名称
	 * @param departmentName
	 * @param id
	 */
	void updateDepartment(String departmentName,int id);
	
	/**
	 * 验证IP是否合法
	 * @param org
	 * @throws SystemException
	 */
	public void validateIpRange(OrgBO org) throws SystemException;
}
