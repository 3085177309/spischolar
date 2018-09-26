package com.wd.front.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.JournalImageDaoI;
import com.wd.backend.model.JournalImage;
import com.wd.front.service.JournalImageServiceI;

@Service("journalImageService")
public class JournalImageServiceImpI implements JournalImageServiceI {
	
	@Autowired
	private JournalImageDaoI journalImageDao;
	
	@Override
	public JournalImage findImage(String jguid) {
		return journalImageDao.findImage(jguid);
	}

}
