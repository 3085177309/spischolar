package com.wd.backend.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.wd.backend.bo.MailSenderInfo;
import com.wd.backend.bo.ProductEnum;
import com.wd.backend.bo.SimpleMailSender;
import com.wd.backend.service.MailService;
import com.wd.thread.MailServiceThread;
import com.wd.thread.SearchLogThread;

public class MailServiceImpl implements MailService{
	
	private String host;
	
	private String user;
	
	private String pwd;
	
	private String host2;
	
	private String user2;
	
	private String pwd2;

	@Override
	public void send(Integer productId,String address, String subject, String content,
			File attach){

		System.out.println("开始向"+address+"发送邮件");
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerPort("25");
		mailInfo.setValidate(true);
		if(productId != null && productId == ProductEnum.CSR.value()){
			mailInfo.setMailServerHost(host2);
			mailInfo.setUserName(user2);
			mailInfo.setPassword(pwd2);// 您的邮箱密码
			mailInfo.setFromAddress(user2);
			content = content.replace("欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>",
					"欢迎您使用CRS核心论文库<br><a href='http://www.crscholar.com' target='blank'>http://www.crscholar.com</a>");
		}else{
			mailInfo.setMailServerHost(host);
			mailInfo.setUserName(user);
			mailInfo.setPassword(pwd);// 您的邮箱密码
			mailInfo.setFromAddress(user);
		}
		mailInfo.setToAddress(address);
		mailInfo.setSubject(subject);
		mailInfo.setContent(content);
		List<File> attachs=new ArrayList<File>();
		if(attach!=null){
			attachs.add(attach);
		}
		mailInfo.setAttcheFiles(attachs);
		// 这个类主要来发送邮件　　
		//SimpleMailSender sms = new SimpleMailSender();
		//sms.sendTextMail(mailInfo);// 发送文体格式
		if (SimpleMailSender.sendHtmlMail(mailInfo)){
			System.out.println("邮件发送至"+address+"成功");
		}else {
			System.out.println("邮件发送至"+address+"失败");
		}
	}
	
	
	private ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);
	
	
	@Override
	public void send(String address, String subject, String content, File attach) {
		fixedThreadPool.execute(new MailServiceThread(this, 2,address,subject,content,attach));
		//send(2,address,subject,content,attach);
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getHost2() {
		return host2;
	}

	public void setHost2(String host2) {
		this.host2 = host2;
	}

	public String getUser2() {
		return user2;
	}

	public void setUser2(String user2) {
		this.user2 = user2;
	}

	public String getPwd2() {
		return pwd2;
	}

	public void setPwd2(String pwd2) {
		this.pwd2 = pwd2;
	}

}
