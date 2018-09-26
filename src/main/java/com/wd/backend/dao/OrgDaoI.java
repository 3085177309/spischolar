package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Department;
import com.wd.backend.model.Org;

public interface OrgDaoI {

	public List<Org> findAll();
	public List<Org> findProvince();
	
	public List<Department> findDepartments(Integer schoolId);

	/**
	 * 插入机构
	 * 
	 * @param model
	 */
	public void insert(Org model);

	/**
	 * 通过id查找机构
	 * 
	 * @param orgId
	 * @return
	 */
	public Org findById(Integer orgId);
	
	/**
	 * 通过Flag查找
	 * @param flag
	 * @return
	 */
	public Org findByFlag(String flag);

	/**
	 * 查找机构总数量
	 * 
	 * @return
	 */
	public int findCount(Map<String, Object> params);
	
	/**
	 * 根据条件查找机构总数量
	 * 
	 * @return
	 */
	public int findCountBy(Map<String, Object> params);

	/**
	 * 分页方式查找机构
	 * 
	 * @return
	 */
	public List<Org> findPager(Map<String, Object> parmas);
		
	/**
	 * 查询购买了产品的机构
	 * @return
	 */
	public int findCountByProduct(Map<String,Object> params);
	
	public List<Org> findPagerByProduct(Map<String, Object> parmas);

	/**
	 * 更新机构信息
	 * 
	 * @param model
	 */
	public int update(Org model);

	/**
	 * 查看机构标识是否存在
	 * 
	 * @param flag
	 * @return 返回null表示机构标识不存在
	 */
	public Integer findExistsFlag(String flag);
	
	public Integer findOrgNameExist(String orgName);

	/**
	 * 获取出本身之外的所有机构的ip范围
	 * 
	 * @param orgId
	 * @return
	 */
	public List<String> findAllIpRanges();
	
	public List<String> findAllIpRangesWithoutCur(Integer orgId);

	/**
	 * 更新机构ip范围
	 * 
	 * @param model
	 */
	public void updateIpRanges(Org model);

	/**
	 * 通过id删除机构
	 * 
	 * @param orgId
	 */
	public void delete(Integer orgId);
	
	/**
	 * 根据学校id查学院
	 * @param schoolId
	 * @return
	 */
	public List<Department> findDepBySchool(int schoolId);
	
	public void addDept(Department department);
	
	public void deleteDepartment(int id);
	
	public void updateDepartment(Department department);
	
	public Department findDepartmentById(int departmentId);
}
