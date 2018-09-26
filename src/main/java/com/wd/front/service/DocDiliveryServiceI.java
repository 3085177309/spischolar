package com.wd.front.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.DocDelivery;

public interface DocDiliveryServiceI {
	/**
	 * 未登录时的文献传递收藏到已登录用户
	 * @param oldId
	 * @param memberId
	 */
	public void update(String oldId,String memberId);
	
	public Pager findPage(Integer memberId,Integer processType,String email,String title);
	
	public void addDilivery(DocDelivery dilivery);
	
	public List<DocDelivery> findTopN(Integer memberId,int size);
	
	public DocDelivery get(Long id);
	
	public DocDelivery findUrl(DocDelivery dilivery);
	
	public DocDelivery findByReuse(DocDelivery dilivery);
	
	/**
	 * 文献传递数量
	 * @param email
	 * @return
	 */
	public int findcountByEmail(String email);
	
	public int findcountByEmailFromValidity(String email);
	
//	public Pager findPage(Integer memberId,Integer productId,String title,Integer size,Integer offset); 
	

	public Pager findPageHelp(Integer processType,String val);
	
	public String check(int id,int memberId);
	
	public long removeHelp(int id,int memberId);
	
	public void updatePath(String path,long id);

}
