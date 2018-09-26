package com.wd.service;

import com.wd.backend.model.Member;

/**
 * 用户服务
 * @author Administrator
 *
 */
public interface UserService {
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
	public int register(Member member);
	
	public void update(Member member);
	
	/**
	 * 通过用户名查找用户
	 * @param username
	 */
	public Member findByUsername(String username);
	
	public Member detail(Integer id);
	
	/**
	 * 重置详细信息
	 * @param member
	 * @throws OperationException
	 */
	public void resetProfile(Member member);
	/**
	 * 校外登录申请
	 * @param member
	 * @throws OperationException
	 */
	public void applyLogin(Member member);
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
	public void resetPwd(Member member,String oldPwd,String newPwd);
	
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
	public void sendResetMail(Member member,String resetHref);
	
	/**
	 * 检测重置密码连接
	 * @param sid
	 * @param username
	 * @return
	 * @throws OperationException
	 */
	public Member checkResetInfo(String sid,String username);
	
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
	
	public Member login(String username, String pwd);
	
	public void updateSecret(Member member);
	
}
