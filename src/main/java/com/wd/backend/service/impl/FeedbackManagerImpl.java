package com.wd.backend.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.FeedbackDaoI;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;
import com.wd.backend.service.FeedbackManagerI;
import com.wd.comm.context.SystemContext;

@Service("feedbackManager")
public class FeedbackManagerImpl implements FeedbackManagerI{
	
	@Autowired
	private FeedbackDaoI feedbackDao;
	/**
	 * 后台反馈列表
	 */
	@Override
	public Pager findPager(Map<String, Object> params) {
		Pager p=new Pager();
		int total=feedbackDao.findCount(params);
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<Feedback> list = feedbackDao.findList(params);
			for(int i=0;i<list.size();i++) {
				//List<FeedbackInfo> newListInfo = new ArrayList<FeedbackInfo>();
				List<FeedbackInfo> listInfo =feedbackDao.findListInfo(list.get(i).getId());
				/*if(list.get(i).getIsProcess() == 0) {
					newListInfo.add(listInfo.get(listInfo.size()-1));
				} else {
					newListInfo.add(listInfo.get(listInfo.size()-1));
					for(int j=listInfo.size()-1;j>0;j--) {
						if(listInfo.get(j).getType()==1) {
							newListInfo.add(listInfo.get(j));
							break;
						}
					}
				}*/
				list.get(i).setFeedbackInfo(listInfo);
			}
			p.setRows(list);
		}
		return p;
	}
	/**
	 * 后台反馈详细
	 */
	@Override
    public Feedback getById(Integer id){
		Feedback feedback = feedbackDao.getById(id);
		List<FeedbackInfo> list = feedbackDao.findListInfo(id);
		feedback.setFeedbackInfo(list);
		return feedback;
	}
	
	
	
	
	/**
	 * 根据id查询反馈详情
	 */
	@Override
	public List<FeedbackInfo> findListInfo(Integer id) {
		return feedbackDao.findListInfo(id);
	}
	
	
	/**
	 * 修改最新时间
	 */
	@Override
	public void updateTime(Feedback feedback) {
		feedbackDao.updateTime(feedback);
	}
	
	/**
	 * 反馈详情表
	 */
	@Override
	public int saveInfo(FeedbackInfo feedbackinfo) {
		return feedbackDao.insertInfo(feedbackinfo);
	}
	

	
	
	
	@Override
	public void answer(Feedback feedback) {
//		feedback.setAnswerTime(new Date());
		feedback.setIsProcess((short)1);
		feedbackDao.answer(feedback);
	}

}
