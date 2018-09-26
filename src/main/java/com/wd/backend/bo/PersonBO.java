package com.wd.backend.bo;

import com.wd.backend.model.Person;

public class PersonBO extends Person {

	/**
	 * 旧密码
	 */
	private String oldPwd;
	/**
	 * 确认新密码
	 */
	private String newPwd;

	/**
	 * 角色名
	 */
	private String roleName;

	public PersonBO() {
	}

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String getRoleName() {
		if (super.getRole() == 1) {
			roleName = "系统超级管理员";
		} else if (super.getRole() == 2) {
			roleName = "机构超级管理员";
		} else if(super.getRole()==3){
			roleName = "机构站点管理员";
		}else{
			roleName="普通用户";
		}
		return roleName;
	}

	@Override
	public String toString() {
		return super.toString() + "PersonBO{" +
				"oldPwd='" + oldPwd + '\'' +
				", newPwd='" + newPwd + '\'' +
				", roleName='" + roleName + '\'' +
				'}';
	}
}
