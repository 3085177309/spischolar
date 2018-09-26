package com.wd.front.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.FeedbackDaoI;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.FeedbackServiceI;

@Service("feedbackService")
public class FeedbackServiceImpl implements FeedbackServiceI{
	
	@Autowired
	private FeedbackDaoI feedbackDao;
	
	/**
	 * 反馈列表表
	 */
	@Override
	public int save(Feedback feedback) {
		return feedbackDao.insert(feedback);
	}
	/**
	 * 反馈详情表
	 */
	@Override
	public int saveInfo(FeedbackInfo feedbackinfo) {
		return feedbackDao.insertInfo(feedbackinfo);
	}
	/**
	 * 修改最新时间
	 */
	@Override
	public void updateTime(Feedback feedback) {
		feedbackDao.updateTime(feedback);
	}
	/**
	 * 查询反馈列表
	 */
	@Override
	public Pager findPager(Integer memberId) {
		Pager p=new Pager(); 
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		int total=feedbackDao.findCount(params);
		p.setTotal(total);
		if(total>0){

			List<Feedback> list = feedbackDao.findList(params);
			for(int i=0;i<list.size();i++) {
				List<FeedbackInfo> listInfo =feedbackDao.findListInfo(list.get(i).getId());
				list.get(i).setInterval((System.currentTimeMillis() - listInfo.get(listInfo.size()-1).getTime().getTime())/1000);
				list.get(i).setFeedbackInfo(listInfo);
			}
			p.setRows(list);
		}
		return p;
	}
	/**
	 * 根据id查询反馈详情
	 */
	@Override
	public List<FeedbackInfo> findListInfo(Integer id) {
		List<FeedbackInfo> list = feedbackDao.findListInfo(id);
		for(int i =0;i<list.size();i++) {
			FeedbackInfo feedbackInfo = list.get(i);
			feedbackInfo.setInterval((System.currentTimeMillis() - feedbackInfo.getTime().getTime())/1000);
		}
		return list;
	}
	/**
	 * 填写邮箱
	 */
	@Override
    public void updateFeedbackEmail(Feedback feedback) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", feedback.getMemberId());
		params.put("contact", feedback.getContact());
		feedbackDao.updateFeedbackEmail(params);
	}

	
	

	
	
	@Override
	public Feedback get(Integer id) {
		return feedbackDao.getById(id);
	}
}
