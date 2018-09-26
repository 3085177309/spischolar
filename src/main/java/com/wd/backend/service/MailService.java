package com.wd.backend.service;

import java.io.File;

public interface MailService {
	
	/**
	 * 发送邮件
	 * @param productId 产品ID,不同的产品使用不同的ID
	 * @param address 发送的邮件地址
	 * @param subject 主题
	 * @param content 邮件内容
	 * @param attach 附件
	 */
	public void send(Integer productId,String address,String subject,String content,File attach);
	
	
	/**
	 * 发送邮件
	 * @param address 发送的邮件地址
	 * @param subject 主题
	 * @param content 邮件内容
	 * @param attach 附件
	 */
	public void send(String address,String subject,String content,File attach);

}
