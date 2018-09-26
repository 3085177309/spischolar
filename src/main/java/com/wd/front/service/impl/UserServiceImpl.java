package com.wd.front.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.model.Member;
import com.wd.backend.service.MailService;
import com.wd.exeception.SystemException;
import com.wd.front.service.OperationException;
import com.wd.front.service.UserServiceI;
import com.wd.service.UserService;
import com.wd.util.LoginUtil;
import com.wd.util.MD5Util;

@Service("userService")
public class UserServiceImpl implements UserServiceI,UserService{
	
	private static final Logger log=Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	private MemberDaoI memberDao;
	
	@Autowired
	private MailService mailService;

	@Override
	public int register(Member member) throws OperationException {
		String encodePwd=MD5Util.getMD5(member.getPwd().getBytes());
		member.setPwd(encodePwd);
		member.setRegisterTime(new Date());
		member.setLoginTime(new Date());
		memberDao.insert(member);
		return member.getId();
	}
	
	@Override
    public Member login(String username, String pwd){
		String encodePwd=MD5Util.getMD5(pwd.getBytes());
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("username", username);
		params.put("pwd", encodePwd);
		Member member=memberDao.login(params);
		return member;
	}

	@Override
	public Member login(String username, String pwd,HttpServletRequest request, HttpServletResponse response) throws OperationException {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("username", username);
		params.put("pwd", pwd);
		Member member=memberDao.login(params);
		if(member != null){
			try {
				member = LoginUtil.loginHandle(request,response,member);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			if(member.getStat() == 1) {
				updateLogin(member);
			}
			//member.setLoginTime(new Date());
			//memberDao.update(member);
		}
		return member;
	}
	
	@Override
	public Member backLogin(String username, String pwd,HttpServletRequest request,HttpServletResponse response) throws OperationException {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("username", username);
		params.put("pwd", pwd);
		Member member=memberDao.login(params);
		if(member != null){
			try {
				member = LoginUtil.backLoginHandle(request,response,member);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			if(member.getStat() == 1) {
				updateLogin(member);
			}
			//member.setLoginTime(new Date());
			//memberDao.update(member);
		}
		return member;
	}
	
	@Override
	public void updateLogin(Member member) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("isOnline", member.getIsOnline());
		params.put("id", member.getId());
		params.put("loginIP", member.getLoginIP());
		params.put("loginCount", member.getLoginCount());
		params.put("loginTime", member.getLoginTime());
		memberDao.updateLogin(params);
	}

	@Override
	public Member detail(Integer id) {
		return memberDao.getById(id);
	}

	@Override
	public void resetProfile(Member member) throws OperationException {
		memberDao.resetProfile(member);
	}
	
	@Override
	public void applyLogin(Member member) throws OperationException {
		memberDao.applyLogin(member);
	}
	/**
	 * 获取学校验证接口
	 */
	@Override
	public String schoolApiUrl(Member member) {
		return memberDao.schoolApiUrl(member.getSchoolFlag());
	}

	@Override
	public void resetPwd(Member member, String oldPwd, String newPwd) throws OperationException {
		if(StringUtils.isEmpty(oldPwd)||StringUtils.isEmpty(newPwd)) {
            throw new OperationException("密码不能为空!");
        }
		String oldPwdEc=MD5Util.getMD5(oldPwd.getBytes());
		if(!oldPwdEc.equals(member.getPwd())){
			throw new OperationException("原始密码错误!");
		}else{
			String newPwdEc=MD5Util.getMD5(newPwd.getBytes());
			Map<String,Object> params=new HashMap<String,Object>();
			params.put("id", member.getId());
			params.put("pwd", newPwdEc);
			memberDao.updatePwd(params);
		}
	}

	@Override
	public void updateAvatar(Integer memberId, String path,Member user) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("id", memberId);
		params.put("avatar", path);
		String fristAvatar = user.getAvatar();
		if(fristAvatar == null || "".equals(fristAvatar)) {
			fristAvatar = null;
		}
		String smallPsth = fristAvatar+"," + user.getFristAvatar() + "," + user.getTwoAvatar();
		params.put("avatarSmall", smallPsth);
		memberDao.updateAvatar(params);
	}

	@Override
	public Member findByUsername(String username) {
		return memberDao.findByUsername(username);
	}

	@Override
	public void sendResetMail(Member member,String resetHref) throws OperationException{
		String email=member.getEmail();
		if(StringUtils.isBlank(email)){
			throw new OperationException("没有设置邮箱!");
		}
		String secretKey = UUID.randomUUID().toString(),key,digitalSignature;
		Date outDate = new Date(System.currentTimeMillis() + 30 * 60 * 1000);// 30分钟后过期
		member.setSecretKey(secretKey);
		member.setOutDate(outDate);
		key=member.getUsername()+"&&"+outDate.getTime()/1000*1000+secretKey;
		digitalSignature=DigestUtils.md5DigestAsHex(key.getBytes());
		String resetPassHref=resetHref+"?sid="+digitalSignature+"&username="+member.getUsername();
		String content = "请勿回复本邮件.点击下面的链接,重设密码<br/><a href="
                + resetPassHref + " target='_BLANK'>" + resetPassHref
                + "</a>  或者    <a href=" + resetPassHref
                + " target='_BLANK'>点击我重新设置密码</a>"
                + "<br/>tips:本邮件超过30分钟,链接将会失效，需要重新申请'找回密码'";
		try{
			memberDao.updateSecret(member);
			mailService.send(email, "SpiScholar密码找回", content, null);
		}catch(Exception e){
			log.error("邮件发送失败!",e);
		}
	}
	
	@Override
	public Member checkResetInfo(String sid,String username) throws OperationException{
		Member member=memberDao.findByUsername(username);
		if(member==null){
			throw new OperationException("链接错误,无法找到匹配用户,请重新申请找回密码!");
		}
		if(member.getOutDate()==null || member.getOutDate().getTime() < System.currentTimeMillis()){
			throw new OperationException("链接已经过期,请重新申请找回密码.");
		}
		String key=member.getUsername()+"&&"+member.getOutDate().getTime()/1000*1000+member.getSecretKey();
		String digitalSignature=DigestUtils.md5DigestAsHex(key.getBytes());
		if(digitalSignature.equals(sid)){
			return member;
		}else{
			throw new OperationException("链接不正确,是否已经过期了?重新申请吧.");
		}
	}

	@Override
	public void setPwd(Integer id, String newPwd) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("id", id);
		params.put("pwd", MD5Util.getMD5(newPwd.getBytes()));
		memberDao.updatePwd(params);
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean checkEmail(String email) {
		return memberDao.isEmailExists(email)>0?true:false;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean checkUsername(String username) {
		return memberDao.isUsernameExists(username)>0?true:false;
	}

	@Override
	public Member getqqlogin(String access_token) {
		return memberDao.getByAccessToken(access_token);
	}

	@Override
	public void updateQQLogin(Member member) throws OperationException {
		memberDao.update(member);
	}

	@Override
	public int insertQQLogin(Member member) throws OperationException {
		memberDao.insert(member);
		return member.getId();
	}
	
	@Override
	public void updateTourist(int id,String ip) {
		Member member = memberDao.getById(id);
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("id", id);
		params.put("loginTime", new Date());
		params.put("loginIP", ip);
		if(member != null) {
			params.put("loginCount", member.getLoginCount()+1);
		}
		memberDao.updateTourist(params);
	}
	
	@Override
    public void updatePermission(int id) {
		memberDao.updatePermission(id);
	}

	@Override
	public void updateShowQunwp(int id) {
		memberDao.updateShowQunwpa(id);
	}

	@Override
	public void updateSecret(Member member) {
		memberDao.updateSecret(member);
	}
	
	@Override
    public void update(Member member) throws OperationException {
		memberDao.update(member);
	}

	@Override
	public int getIeMessage(int id) {
		try{
			return memberDao.getIeMessage( id);
		}catch(Exception e) {
			
		}
		return 0;
	}
}
