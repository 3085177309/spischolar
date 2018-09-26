package com.wd.backend.model;

import java.util.Date;
import java.util.List;


/**
 * 访客浏览量
 * @author 杨帅菲
 *
 */
public class BrowseCount {
	/*private int id;
	
	private int pageNum; //浏览量
	
	private int memberId; //访客ID
	
	private Date lastTime;//访问结束时间
	
	private Date beginTime;//访问开始时间
	
	private String ip;    //访客ip地址
	
	private String school;//访客学校
	
	private int type; //数据类型，0位原始数据，1位添加数据
	
	private String refererUrl;//来源网站
	
	private String userBrowser;//用户使用浏览器
	
	private String win; //用户电脑系统
	
	private String time;
	
	private String refOrg;
	
	private List<ChickPage> chickPageList;
	
	private String pageName;//访问页面
	 
	private Member member;
		
	private int hight;	

	public String getRefOrg() {
		return refOrg;
	}

	public void setRefOrg(String refOrg) {
		this.refOrg = refOrg;
	}

	public int getHight() {
		return hight;
	}

	public void setHight(int hight) {
		this.hight = hight;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public Date getLastTime() {
		return lastTime;
	}

	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getRefererUrl() {
		return refererUrl;
	}

	public void setRefererUrl(String refererUrl) {
		this.refererUrl = refererUrl;
	}

	public String getUserBrowser() {
		return userBrowser;
	}

	public void setUserBrowser(String userBrowser) {
		this.userBrowser = userBrowser;
	}

	public String getWin() {
		return win;
	}

	public void setWin(String win) {
		this.win = win;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public List<ChickPage> getChickPageList() {
		return chickPageList;
	}

	public void setChickPageList(List<ChickPage> chickPageList) {
		this.chickPageList = chickPageList;
	}*/
	
private int id;
	
	private int pageNum; //浏览量
	
	private String lastTime;//访问结束时间
	
	private String beginTime;//访问开始时间
	
	private String ip;    //访客ip地址
	
	private int type; //数据类型，0位原始数据，1位添加数据
	
	private String refererUrl;//来源网站
	
	private String userBrowser;//用户使用浏览器
	
	private String win; //用户电脑系统
	
	private int time;
	
	private String refererOrg;
	
	private List<ChickPage> chickPageList;
	 
	private int memberId;
	
	private boolean isRegister;//是否注册
	
	private int memberType;//0新用户1老用户
	
	private String schoolName;
	
	private String schoolFlag;
	
	private String schoolProvince;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getRefererUrl() {
		return refererUrl;
	}

	public void setRefererUrl(String refererUrl) {
		this.refererUrl = refererUrl;
	}

	public String getUserBrowser() {
		return userBrowser;
	}

	public void setUserBrowser(String userBrowser) {
		this.userBrowser = userBrowser;
	}

	public String getWin() {
		return win;
	}

	public void setWin(String win) {
		this.win = win;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public String getRefererOrg() {
		return refererOrg;
	}

	public void setRefererOrg(String refererOrg) {
		this.refererOrg = refererOrg;
	}

	public List<ChickPage> getChickPageList() {
		return chickPageList;
	}

	public void setChickPageList(List<ChickPage> chickPageList) {
		this.chickPageList = chickPageList;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public boolean isRegister() {
		return isRegister;
	}

	public void setRegister(boolean isRegister) {
		this.isRegister = isRegister;
	}

	public int getMemberType() {
		return memberType;
	}

	public void setMemberType(int memberType) {
		this.memberType = memberType;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getSchoolFlag() {
		return schoolFlag;
	}

	public void setSchoolFlag(String schoolFlag) {
		this.schoolFlag = schoolFlag;
	}

	public String getSchoolProvince() {
		return schoolProvince;
	}

	public void setSchoolProvince(String schoolProvince) {
		this.schoolProvince = schoolProvince;
	}
}
