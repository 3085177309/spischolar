package com.wd.backend.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class ChickPage {
	/*private int id;
	
	private String url;
	
	private String pageName;
	
	private int browseId;
	
	private String beginTime;
	
	private String lastTime;
	
	private String time;
	
	private String previousPage;//上一页
	
	private List<ChickPage> children = new ArrayList<ChickPage>();
	
	private String name;
	
	private int value =1;
	
	private String keyword;//检索词

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<ChickPage> getChildren() {
		return children;
	}

	public void setChildren(List<ChickPage> children) {
		this.children = children;
	}

	public String getPreviousPage() {
		return previousPage;
	}

	public void setPreviousPage(String previousPage) {
		this.previousPage = previousPage;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	

	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		long ms = Long.parseLong(time);
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		time = formatter.format(ms*1000-8*3600*1000);
		this.time = time;
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
		if(url.contains("value=")) {
			url = url.substring(url.indexOf("value=")+6);
			if(url.contains("&")) {
				this.keyword = url.substring(0,url.indexOf("&"));
			} else {
				this.keyword = url;
			}
		}
		if(url.contains("val=")) {
			url = url.substring(url.indexOf("val=")+4);
			if(url.contains("&")) {
				this.keyword = url.substring(0,url.indexOf("&"));
			} else {
				this.keyword = url;
			}
		}
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public int getBrowseId() {
		return browseId;
	}

	public void setBrowseId(int browseId) {
		this.browseId = browseId;
	}*/
	private int id;
	
	private String url;
	
	private String pageName;
	
	private String beginTime;
	
	private String lastTime;
	
	private int time;
	
	private String keyWord;//检索词
	
	private String previousPage;//上一页

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

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public String getPreviousPage() {
		return previousPage;
	}

	public void setPreviousPage(String previousPage) {
		this.previousPage = previousPage;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	
	

}
