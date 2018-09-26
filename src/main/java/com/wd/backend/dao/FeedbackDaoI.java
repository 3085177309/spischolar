package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;

public interface FeedbackDaoI {
	
	/**
	 * 反馈列表表
	 */
	public int insert(Feedback feedback);
	/**
	 * 反馈详情表
	 */
	public int insertInfo(FeedbackInfo feedbackInfo);
	/**
	 * 修改最新时间
	 */
	public void updateTime(Feedback feedback);
	
	public List<Feedback> findList(Map<String,Object> params);
	
	public List<FeedbackInfo> findListInfo(Integer id);
	
	public void updateFeedbackEmail(Map<String,Object> params);
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Feedback getById(Integer id);
	
	/**
	 * 回复
	 * @param feedback
	 */
	public void answer(Feedback feedback);
	
	public Integer findCount(Map<String,Object> params);
	
	
	
	
	
	public void delete(Integer id);
	
	public void update(Feedback feedback);
	
	

}
