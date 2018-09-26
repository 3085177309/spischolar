package com.wd.backend.model;

import com.wd.util.PinYinUtil;

/**
 * 学院信息
 * @author Administrator
 *
 */
public class Department implements Comparable<Department>{
	private int departmentId;
	
	private String departmentName;
	
	private String departmentFlag;
	
	private int schoolId;
	
	private String schoolName;
	
	private int number;
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public int getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDepartmentFlag() {
		return departmentFlag;
	}

	public void setDepartmentFlag(String departmentFlag) {
		this.departmentFlag = departmentFlag;
	}

	@Override
	public int compareTo(Department o) {
		String oName1=this.getDepartmentName(),oName2=o.getDepartmentName();
		oName1=oName1.replaceAll("重", "虫");
		oName2=oName2.replaceAll("重", "虫");
		oName1=oName1.replaceAll("长", "常");
		oName2=oName2.replaceAll("长", "常");
		String py=PinYinUtil.getPingYin(oName1),
				py2=PinYinUtil.getPingYin(oName2);
		return py.compareTo(py2);
	}

	
	

}
