package com.wd.front.service.impl;

import org.elasticsearch.index.query.QueryBuilders;

import com.wd.front.service.SubjectListServiceI;

public class SubjectListServiceImpl implements SubjectListServiceI{

	@Override
	public void search(String db, Integer year) {
		QueryBuilders.termQuery("authorityDatabase", db);
		QueryBuilders.termQuery("year", year);
	}

}
