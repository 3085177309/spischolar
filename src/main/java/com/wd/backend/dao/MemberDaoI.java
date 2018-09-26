package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Member;
import com.wd.front.service.OperationException;

public interface MemberDaoI {
	/**
	 * 首页
	 * @param params
	 * @return
	 */
	public Map<String, Object> getCount(Map<String, Object> params);
	
	public Member getByAccessToken(String access_token);
	
	public Member getById(Integer id);
	
	public Member login(Map<String, Object> params);
		
	public void insert(Member member);
	
	public void update(Member member);
	
	public void updateLogin(Map<String, Object> params);
	
	public void updatePwd(Map<String, Object> params);
	
	public List<Map<String,Object>> getMemberSchool(Map<String, Object> params);
	
	public int getMemberSchoolCount(Map<String, Object> params);
	
	public Integer findCount(Map<String,Object> params);
	
	public List<Member> findList(Map<String,Object> params);
	
	public void resetProfile(Member member);
	
	public void applyLogin(Member member);
	
	public void forbidden(Member member);
	
	public void updateAvatar(Map<String,Object> params);
	
	public Member findByUsername(String username);
	
	public void updateSecret(Member member);
	
	public Integer isEmailExists(String email);
	
	public Integer isUsernameExists(String username);
	
	public void updateTourist(Map<String,Object> params);
	
	public void deleteUser(Integer id);
	
	public String schoolApiUrl(String schoolFlag);
	
	/**校外登陆申请 */
	public Integer findCountByApply(Map<String,Object> params);
	public List<Member> findListByApply(Map<String,Object> params);
	
	public void updatePermission(Integer id);
	
	/**
	 * 文献传递请求权限设置（通过邮箱找学校）
	 */
	public Member findByEmail(String email);
	
	/**
	 * 	<!-- 随机找出一个游客 -->
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findTourist(Map<String,Object> params);
	
	public int getIeMessage(int id);
	
	/**
	 * 查找游客数量
	 * @param orgFlag
	 * @return
	 */
	public List<Map<String,Object>> findTouristCount(Map<String,Object> params);
	
	public Map<String,Object> findUserLoginCount(Map<String,Object> params);
	
	public List<Map<String,Object>> findUserIds(Map<String,Object> params);

	void updateShowQunwpa(int id);

}
