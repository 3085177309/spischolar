package com.wd.backend.model;

import java.util.Date;

public class FeedbackInfo {
	
	private Integer id;
	
	private Integer feedbackId;
	
	private String content;//内容
	
	private String options;//附件地址
	
	private int type;//1用户2管理员
	
	private Date time;
	
	private long interval;//间隔时间
	
	public long getInterval() {
		return interval;
	}

	public void setInterval(long interval) {
		this.interval = interval;
	}	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(Integer feedbackId) {
		this.feedbackId = feedbackId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOptions() {
		return options;
	}

	public void setOptions(String options) {
		this.options = options;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
	

}
