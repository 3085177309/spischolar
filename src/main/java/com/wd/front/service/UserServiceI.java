package com.wd.front.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wd.backend.model.Member;

/**
 * 用户服务
 * @author Administrator
 *
 */
public interface UserServiceI {
	/**
	 * 登陆后信息修改
	 * @param member
	 */
	public void updateLogin(Member member);
	/**
	 * 用户注册
	 * @param member
	 * @throws OperationException
	 */
	public int register(Member member) throws OperationException;
	
	/**
	 * 通过用户名查找用户
	 * @param username
	 */
	public Member findByUsername(String username);
	
	/**
	 * 用户登录
	 * @param username
	 * @param pwd
	 * @return
	 * @throws OperationException
	 */
	public Member login(String username,String pwd,HttpServletRequest request, HttpServletResponse response) throws OperationException;
	
	/**
	 * 后台用户登陆
	 * @param username
	 * @param pwd
	 * @param request
	 * @return
	 * @throws OperationException
	 */
	public Member backLogin(String username, String pwd,HttpServletRequest request,HttpServletResponse response) throws OperationException;
	
	
	public Member detail(Integer id);
	
	/**
	 * 重置详细信息
	 * @param member
	 * @throws OperationException
	 */
	public void resetProfile(Member member) throws OperationException;
	/**
	 * 校外登录申请
	 * @param member
	 * @throws OperationException
	 */
	public void applyLogin(Member member) throws OperationException;
	/**
	 * 获取学校验证接口
	 * @param member
	 */
	public String schoolApiUrl(Member member);
	
	/**
	 * 重置密码
	 * @param member
	 * @param oldPwd
	 * @param newPwd
	 */
	public void resetPwd(Member member,String oldPwd,String newPwd) throws OperationException;
	
	/**
	 * 设置密码
	 * @param id
	 * @param newPwd
	 */
	public void setPwd(Integer id,String newPwd);
	
	/**
	 * 更新头像
	 * @param memberId
	 * @param path
	 */
	public void updateAvatar(Integer memberId,String path,Member user);
	
	/**
	 * 发送重置密码验证邮件
	 * @param member
	 */
	public void sendResetMail(Member member,String resetHref) throws OperationException;
	
	/**
	 * 检测重置密码连接
	 * @param sid
	 * @param username
	 * @return
	 * @throws OperationException
	 */
	public Member checkResetInfo(String sid,String username) throws OperationException;
	
	/**
	 * 检测邮箱是否已经注册
	 * @param email
	 * @return
	 */
	public boolean checkEmail(String email);
	
	/**
	 * 检测用户名是否已经注册
	 * @param username
	 * @return
	 */
	public boolean checkUsername(String username);
	
	/**
	 * 查询QQ登录信息
	 * @param email
	 * @return
	 */
	public Member getqqlogin(String access_token);
	
	/**
	 * 插入QQ登录的用户
	 * @param member
	 * @throws OperationException
	 */
	public int insertQQLogin(Member member) throws OperationException;
	
	/**
	 * 更改QQ登录的用户信息
	 * @param memberId
	 * @param email
	 * @param nickname
	 * @param username
	 * @param registerTime
	 */
	public void updateQQLogin(Member member) throws OperationException; 
	
	public void updateTourist(int id,String ip);
	/**
	 * 获取是否需要ie弹出提示
	 * @param id
	 * @return
	 */
	public int getIeMessage(int id);
	
	/**
	 * 更改Permission，更改前有提示"您提交的校外访问申请已经审核通过！",更改后不提示
	 * @param id
	 */
	public void updatePermission(int id);

	public void updateShowQunwp(int id);
	
}
