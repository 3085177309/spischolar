package com.wd.thread;

import java.io.File;

import com.wd.backend.model.SystemLog;
import com.wd.backend.service.MailService;
import com.wd.front.service.SearchLogServiceI;

public class MailServiceThread implements Runnable {

	private MailService mailService;
	private Integer productId;
	private String address;
	private String subject;
	private String content;
	private File attach;

	public MailServiceThread(MailService mailService,Integer productId, String address, String subject,
			String content, File attach) {
		this.mailService = mailService;
		this.productId = productId;
		this.address = address;
		this.subject = subject;
		this.content = content;
		this.attach = attach;
		
	}

	@Override
	public void run() {
		mailService.send(productId, address,  subject,  content,  attach);
	}

}
