package com.wd.front.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.DocDeliveryDaoI;
import com.wd.backend.model.DocDelivery;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.DocDiliveryServiceI;
import com.wd.util.DateUtil;

@Service("docDiliveryService")
public class DocDiliveryServiceImpl implements DocDiliveryServiceI{
	
	@Autowired
	private DocDeliveryDaoI deliveryDao;

	
	@Override
	public void update(String oldId,String memberId) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("oldId", oldId);
		params.put("memberId",memberId);
		deliveryDao.updates(params);
	}
	
	@Override
	public Pager findPage(Integer memberId,Integer processType,String email,String title) {
		Map<String,Object> params=new HashMap<String,Object>();
		//if(email == null) {
			params.put("memberId", memberId);
		//}
		if(title != null) {
			params.put("title", "%"+title+"%");
		}
		params.put("processType", processType);
		params.put("email", email);
		int total=deliveryDao.findCountByParamsIndex(params);
		Pager p=new Pager();
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(deliveryDao.findListByParamsIndex(params));
		}
		return p;
	}
	
	

	@Override
	public void addDilivery(DocDelivery dilivery) {
		deliveryDao.insert(dilivery);
	}
	
	@Override
	public List<DocDelivery> findTopN(Integer memberId,int size){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		params.put("top", size);
		return deliveryDao.findTop(params);
	}

	@Override
	public DocDelivery get(Long id) {
		return deliveryDao.findById(id);
	}
	
	@Override
	public DocDelivery findUrl(DocDelivery dilivery) {
		return deliveryDao.findByUrl(dilivery);
	}
	
	@Override
	public DocDelivery findByReuse(DocDelivery dilivery) {
		return deliveryDao.findByReuse(dilivery);
	}
	
	@Override
	public int findcountByEmail(String email) {
		Date date = new Date();
		SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd");
		String time = sp.format(date);
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("time", time);
		params.put("email", email);
		return deliveryDao.findcountByEmail(params);
	}
	
	@Override
	public int findcountByEmailFromValidity(String email) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("email", email);
		String count = deliveryDao.findcountByEmailFromValidity(params);
		if(count != null && !"".equals(count)) {
			return Integer.parseInt(count);
		} else {
			return 0;
		}
		 
	}

//	@Override
//	public Pager findPage(Integer memberId, Integer productId,String title, Integer size, Integer offset) {
//		Map<String,Object> params=new HashMap<String,Object>();
//		params.put("memberId", memberId);
//		if(title != null) {
//			params.put("title", "%"+title+"%");
//		}
//		params.put("productId", productId);
//		int total=deliveryDao.findCountByParamsIndex(params);
//		Pager p=new Pager();
//		p.setTotal(total);
//		if(total>0){
//			params.put("offset", offset);
//			params.put("size", size);
//			p.setRows(deliveryDao.findListByParamsIndex(params));
//		}
//		return p;
//	}
	
	
	@Override
    public Pager findPageHelp(Integer processType, String val) {
		Map<String,Object> params=new HashMap<String,Object>();
		if(val != null) {
			params.put("email", val.trim());			//邮箱精确检索
			params.put("val", "%"+val.trim()+"%");
		}
		params.put("processType", processType);
		int total=deliveryDao.findDiliveryHelpCount(params);
		Pager p=new Pager();
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(deliveryDao.findDiliveryHelpList(params));
		}
		return p;
	}
	
	@Override
    public String check(int id, int memberId) {
		Map<String,Object> result = deliveryDao.checkHelp(id);
		List<Map<String,Object>> checkHelpList = deliveryDao.checkHelpCount(memberId);
		if(checkHelpList.size() >= 1) {
			return checkHelpList.get(0).get("title").toString();
		}
		if(result != null && result.containsKey("helpId") && (int)result.get("helpId") == 1) {//已被应助
			Long time = (Long) result.get("time");
			return (15*60-time) + "";
		} else {
			if(memberId == -1) {
				return "900";
			}
			Date date = new Date();
			String time = DateUtil.format(date);
			Map<String,Object> param =new HashMap<String, Object>();
			param.put("id", id);
			param.put("time", time);
			param.put("helpId", 1);
			param.put("helpMemberId", memberId);
			deliveryDao.updateHelp(param);
			return "900";
		}
	}
	
	@Override
    public long removeHelp(int id, int memberId) {
		Map<String,Object> param =new HashMap<String, Object>();
		param.put("id", id);
		String nowTime = DateUtil.format(new Date());
		param.put("time", DateUtil.getEndTime(nowTime, -20*60));
		param.put("helpId", 0);
		param.put("helpMemberId", null);
		deliveryDao.updateHelp(param);
		return 1;
	}
	
	@Override
    public void updatePath(String path, long id) {
		Map<String,Object> param =new HashMap<String, Object>(); 
		Date date = new Date();
		String time = DateUtil.format(date);
		param.put("path", path);
		param.put("id", id);
		param.put("helpId", 2);
		param.put("time", time);
		deliveryDao.updateHelp(param);
	}

}
