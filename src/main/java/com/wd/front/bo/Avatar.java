package com.wd.front.bo;

import java.util.Date;

public class Avatar {
	
	private Integer id;
	
	private String path;
	
	private String pathSmall;
	
	private Integer memberId;
	
	private Date addTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getPathSmall() {
		return pathSmall;
	}

	public void setPathSmall(String pathSmall) {
		this.pathSmall = pathSmall;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

}
