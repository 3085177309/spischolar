package com.wd.backend.model;

import java.util.Date;

import com.wd.backend.bo.OrgBO;

/**
 * 用户请求
 * @author 
 *
 */
public class UserRequest {
	private int id;

	private String url;
	
	private String param;
	
	private String school;
	
	private Date time;
	
	private String person;
	
	private int memberId;
	
	private String function;
	
	private int type;
	
	private Member member;
	
	private Department department;
	
	private Org org;
	
	private Member memberAfter;
	
	private Department departmentAfter;
	
	private Org orgAfter;

	public Member getMemberAfter() {
		return memberAfter;
	}

	public void setMemberAfter(Member memberAfter) {
		this.memberAfter = memberAfter;
	}

	public Department getDepartmentAfter() {
		return departmentAfter;
	}

	public void setDepartmentAfter(Department departmentAfter) {
		this.departmentAfter = departmentAfter;
	}

	

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public Org getOrgAfter() {
		return orgAfter;
	}

	public void setOrgAfter(Org orgAfter) {
		this.orgAfter = orgAfter;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
}
