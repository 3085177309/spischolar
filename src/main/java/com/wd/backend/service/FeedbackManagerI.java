package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;

public interface FeedbackManagerI {
	/**
	 * 后台列表
	 * @param params
	 * @return
	 */
	public Pager findPager(Map<String,Object> params);
	/**
	 * 后台详情
	 * @param id
	 * @return
	 */
	public Feedback getById(Integer id);
	
	
	public List<FeedbackInfo> findListInfo(Integer id);
	
	public int saveInfo(FeedbackInfo feedbackinfo);
	
	/**
	 *修改时间 
	 * @return
	 */
	public void updateTime(Feedback feedback);
	
	
	
	
	
	/**回复*/
	public void answer(Feedback feeback);

}
