package com.wd.backend.model;

import java.io.Serializable;
import java.util.Date;

public class Member implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	
	private String email;
	
	private String nickname;
	
	private String username;
	
	private String pwd;
	
	private String school;
	
	private String schoolFlag;
	
	/**院系*/
	private String department;
	
	private String departmentId;
	
	/**身份*/
	private Integer identity;
	
	/**教育程度*/
	private Integer education;
	
	private Short sex;
	
	private String qq;
	
	private String phone;
	
	private String intro;
	
	private String avatar;

	private byte[] avatarBlob;

	private String avatarSmall;
	
	private String fristAvatar;
	private String twoAvatar;
	private String threeAvatar;
	
	/**注册时间*/
	private Date registerTime;
	
	/**最后登录时间*/
	private Date loginTime;
	
	/**最后登录IP*/
	private String loginIP;
	
	/**验证码(用于找回密码)*/
	private String secretKey;
	
	/**找回秘密过期时间*/
	private Date outDate;
	
	private String loginType;
	
	private String accessToken;

	private String registerIp;
	
	private int loginCount;
	/**是否禁用*/
	private int forbidden;
	/**用户类型*/
	private int userType;
	/**证件照片地址*/
	private String identification;
	
	private Integer isOnline;//是否在线
	
	private Integer permission = 0;//登录权限
	
	private String studentId;//学号
	
	private String entranceTime; //入学年份
	
	private String info;//登陆提示
	
	private int stat = 0;//登陆状态码

	public byte[] getAvatarBlob() {
		return avatarBlob;
	}

	public void setAvatarBlob(byte[] avatarBlob) {
		this.avatarBlob = avatarBlob;
	}

	/**使用期限*/
	private Date lifespan;
	/**校外登陆申请时间*/
	private Date applyTime;
	/**后台处理时间*/
	private Date handleTime;
	/**处理人*/
	private String handlePeople;
	/**0真实数据1添加*/
	private int type = 0;
	
	private int checkEmail;//邮箱是否以验证0为没有1为验证成功

    /**
     * 是否自动展开加群提示
     */
	private boolean showQunwpa;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getSchoolFlag() {
		return schoolFlag;
	}

	public void setSchoolFlag(String schoolFlag) {
		this.schoolFlag = schoolFlag;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Integer getIdentity() {
		return identity;
	}

	public void setIdentity(Integer identity) {
		this.identity = identity;
	}

	public Integer getEducation() {
		return education;
	}

	public void setEducation(Integer education) {
		this.education = education;
	}

	public Short getSex() {
		return sex;
	}

	public void setSex(Short sex) {
		this.sex = sex;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getAvatarSmall() {
		return avatarSmall;
	}

	public void setAvatarSmall(String avatarSmall) {
		this.avatarSmall = avatarSmall;
		if(avatarSmall != null && avatarSmall.contains(",")) {
			String[] ava = avatarSmall.split(",");
			if(ava.length == 3) {
				this.fristAvatar = ava[0];
				this.twoAvatar = ava[1];
				this.threeAvatar = ava[2];
			} else {
				this.fristAvatar = ava[0];
				this.twoAvatar = ava[1];
			}
		} else {
			this.fristAvatar = avatarSmall;
		}
		
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public Date getOutDate() {
		return outDate;
	}

	public void setOutDate(Date outDate) {
		this.outDate = outDate;
	}

	public String getLoginType() {
		return loginType;
	}

	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public Integer getIsOnline() {
		return isOnline;
	}

	public void setIsOnline(Integer isOnline) {
		this.isOnline = isOnline;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getEntranceTime() {
		return entranceTime;
	}

	public void setEntranceTime(String entranceTime) {
		this.entranceTime = entranceTime;
	}

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}
	
	public String getRegisterIp() {
		return registerIp;
	}

	public void setRegisterIp(String registerIp) {
		this.registerIp = registerIp;
	}

	public Integer getPermission() {
		return permission;
	}

	public void setPermission(Integer permission) {
		this.permission = permission;
	}
	
	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Date getLifespan() {
		return lifespan;
	}

	public void setLifespan(Date lifespan) {
		this.lifespan = lifespan;
	}

	public String getIdentification() {
		return identification;
	}

	public void setIdentification(String identification) {
		this.identification = identification;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public int getForbidden() {
		return forbidden;
	}

	public void setForbidden(int forbidden) {
		this.forbidden = forbidden;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

	public String getFristAvatar() {
		return fristAvatar;
	}

	public void setFristAvatar(String fristAvatar) {
		this.fristAvatar = fristAvatar;
	}

	public String getTwoAvatar() {
		return twoAvatar;
	}

	public void setTwoAvatar(String twoAvatar) {
		this.twoAvatar = twoAvatar;
	}

	public String getThreeAvatar() {
		return threeAvatar;
	}

	public void setThreeAvatar(String threeAvatar) {
		this.threeAvatar = threeAvatar;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public int getStat() {
		return stat;
	}

	public void setStat(int stat) {
		this.stat = stat;
	}

	public Date getHandleTime() {
		return handleTime;
	}

	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}

	public String getHandlePeople() {
		return handlePeople;
	}

	public void setHandlePeople(String handlePeople) {
		this.handlePeople = handlePeople;
	}
	
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getCheckEmail() {
		return checkEmail;
	}

	public void setCheckEmail(int checkEmail) {
		this.checkEmail = checkEmail;
	}

	public boolean isShowQunwpa() {
		return showQunwpa;
	}

	public void setShowQunwpa(boolean showQunwpa) {
		this.showQunwpa = showQunwpa;
	}
}
