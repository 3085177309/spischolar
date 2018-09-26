package com.wd.front.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;

public interface FeedbackServiceI {
	
	public int save(Feedback feedback);
	/**
	 *修改时间 
	 * @return
	 */
	public void updateTime(Feedback feedback);
	/**
	 * 反馈详细
	 * @param feedbackinfo
	 * @return
	 */
	public int saveInfo(FeedbackInfo feedbackinfo);
	
	public Pager findPager(Integer memberId);
	
	public List<FeedbackInfo> findListInfo(Integer id);
	
	public void updateFeedbackEmail(Feedback feedback);
	
	
	
	
	
	public Feedback get(Integer id);

}
