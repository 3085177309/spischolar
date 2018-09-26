package com.wd.backend.service;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Member;
import com.wd.exeception.SystemException;
import com.wd.front.service.OperationException;

/**
 * 后台用户管理
 * @author Administrator
 *
 */
public interface MemberManagerI {
	/**
	 * 首页
	 * @param school
	 * @return
	 */
	public Map<String,Object> getCount(String school, String type);
	
	public Pager getMemberSchool(String offset);
	/**
	 * 用户列表
	 * @param params
	 * @return
	 */
	public Pager findPager(String key,String schoolFlag,String department,String order);
	/**
	 * 用户注册
	 * @param member
	 * @throws OperationException
	 */
	public int register(Member member) throws OperationException;
	/**
	 * 修改用户信息
	 * @param member
	 */
	public void update(Member member);
	/**
	 * 注册多个用户
	 * @param file
	 */
	public void registerUsers(InputStream in,String ip) throws SystemException;
	/**
	 * 删除用户
	 * @param id
	 */
	public void deleteUser(int id);
	
	public Member getById(int id);
	
	/**
	 * 校外登录申请
	 * @param member
	 * @throws OperationException
	 */
	public void applyLogin(Member member) throws OperationException;
	/**
	 * 禁用用户
	 * @param member
	 * @throws OperationException
	 */
	public void forbidden(Member member) throws OperationException;
	/**
	 * 后台校外登陆申请
	 * @param params
	 * @return
	 */
	public Pager findPagerByApply(Map<String, Object> params);
	
	/**
	 * 文献传递请求权限设置（通过邮箱找学校）
	 * @return
	 */
	public Member findByEmail(String email);
	/**
	 * 学校用户管理数据添加
	 * @return
	 */
	public Map<String,Object> findTouristCount(String orgFlag,String beginTime,String endTime);
	/*日志*/
	public Pager getLogList(String orgFlag);
	/**
	 * 学校用户管理数据添加
	 */
	public void addUserRecord(Map<String,Object> param,String username);

}
