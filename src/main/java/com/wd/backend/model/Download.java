package com.wd.backend.model;

import java.util.List;


public class Download {
	
	private int id;
	
	private String title;
	
	private int num;
	
	private String url;
	
	private List<DownloadInfo> list;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<DownloadInfo> getList() {
		return list;
	}

	public void setList(List<DownloadInfo> list) {
		this.list = list;
	}

}
