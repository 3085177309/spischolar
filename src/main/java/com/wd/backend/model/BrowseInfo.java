package com.wd.backend.model;

public class BrowseInfo {
	
	private int id;
	
	private String date;
	
	private int pv;
	
	private int uv;
	
	private int ipCount;
	
	private String time;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getPv() {
		return pv;
	}

	public void setPv(int pv) {
		this.pv = pv;
	}

	public int getUv() {
		return uv;
	}

	public void setUv(int uv) {
		this.uv = uv;
	}

	public int getIpCount() {
		return ipCount;
	}

	public void setIpCount(int ipCount) {
		this.ipCount = ipCount;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "BrowseInfo{" +
				"id=" + id +
				", date='" + date + '\'' +
				", pv=" + pv +
				", uv=" + uv +
				", ipCount=" + ipCount +
				", time='" + time + '\'' +
				'}';
	}
}
