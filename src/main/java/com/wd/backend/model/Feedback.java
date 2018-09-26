package com.wd.backend.model;

import java.util.Date;
import java.util.List;

/**
 * 用户反馈
 * @author Administrator
 *
 */
public class Feedback {
	
	private Integer id;
	
	/**系统*/
	private String systemName;
	
	/**联系方式*/
	private String contact;
	
	/**用户*/
	private Integer memberId;
	
	/**提问时间*/
	private Date time;
	
	private String memberName;
	
	private long interval;//间隔时间
	
	public long getInterval() {
		return interval;
	}

	public void setInterval(long interval) {
		this.interval = interval;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}



	private List<FeedbackInfo> feedbackInfo;
	
	public List<FeedbackInfo> getFeedbackInfo() {
		return feedbackInfo;
	}

	public void setFeedbackInfo(List<FeedbackInfo> feedbackInfo) {
		this.feedbackInfo = feedbackInfo;
	}

	
	
	/**是否已经处理*/
	private Short isProcess=0;
	
	
	
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSystemName() {
		return systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}


	
	
	public Short getIsProcess() {
		return isProcess;
	}

	public void setIsProcess(Short isProcess) {
		this.isProcess = isProcess;
	}
}
