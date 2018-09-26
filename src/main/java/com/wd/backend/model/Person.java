package com.wd.backend.model;

import java.util.Date;

/**
 * 人员模型
 * 
 * <pre>
 * 	约束：
 * 		1、name 姓名，非空
 * 		2、email 邮箱，非空、唯一、不可修改
 * 		3、password 密码，非空、长度不少于6位(默认密码为：123654)
 * 		4、role 角色，不能将用户的角色修改为系统超级管理员角色
 * 		5、status 用户状态，只有1、可用与2、禁用两种角色
 * </pre>
 * 
 * @author pan
 * 
 */
public class Person {

	private Integer id;
	private String name;
	private String email;
	private String password;
	private String remark;
	private Date registerDate;
	private Integer orgId;
	/**
	 * 状态: 1、可用 2、禁用
	 */
	private int status=1;
	/**
	 * 所属角色 1、系统超级管理员 2、机构超级管理员 3、机构站点管理员 4、普通用户(无法登录后台)
	 */
	private int role;
	
	private String schoolFlag;
	
	private int loginCount;
	
	private int isOnline;

	public int getIsOnline() {
		return isOnline;
	}

	public void setIsOnline(int isOnline) {
		this.isOnline = isOnline;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

	public String getSchoolFlag() {
		return schoolFlag;
	}

	public void setSchoolFlag(String schoolFlag) {
		this.schoolFlag = schoolFlag;
	}

	public Person() {
	}
	
	public Person(String name,String password){
		this.name=name;
		this.password=password;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (null != name) {
            name = name.trim();
        }
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		if (null != email) {
            email = email.trim();
        }
		this.email = email;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		if (null != remark) {
            remark = remark.trim();
        }
		this.remark = remark;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		if (null != password) {
            password = password.trim();
        }
		this.password = password;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "Person{" +
				"id=" + id +
				", name='" + name + '\'' +
				", email='" + email + '\'' +
				", password='" + password + '\'' +
				", remark='" + remark + '\'' +
				", registerDate=" + registerDate +
				", orgId=" + orgId +
				", status=" + status +
				", role=" + role +
				", schoolFlag='" + schoolFlag + '\'' +
				", loginCount=" + loginCount +
				", isOnline=" + isOnline +
				'}';
	}
}
