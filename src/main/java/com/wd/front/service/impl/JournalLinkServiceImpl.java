package com.wd.front.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.JournalUrlDaoI;
import com.wd.backend.model.JournalUrl;
import com.wd.front.service.JournalLinkServiceI;

@Service("journalLinkService")
public class JournalLinkServiceImpl implements JournalLinkServiceI {

	@Autowired
	private JournalUrlDaoI journalUrlDao;

	@Override
	public List<JournalUrl> searchDbLinks(String journalFlag) {
		return journalUrlDao.findDbLink(journalFlag);
	}

	@Override
	public JournalUrl searchMainLink(String journalFlag) {
		return journalUrlDao.findMainLink(journalFlag);
	}

}
