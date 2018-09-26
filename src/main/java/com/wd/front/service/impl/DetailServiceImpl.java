package com.wd.front.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.index.query.QueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.wd.backend.model.CoreExpansion;
import com.wd.comm.Comm;
import com.wd.front.service.DetailServiceI;
import com.wd.util.ClientUtil;

import net.sf.json.JSONObject;

@Service("detailService")
public class DetailServiceImpl implements DetailServiceI{


	@Override
	public Map<String, Object> getDoc(String id){
		Client client = ClientUtil.getClient();
		GetResponse  resp=client.prepareGet().setIndex(Comm.DEFAULT_INDEX).setId(id).execute().actionGet();
		Map<String, Object> doc=resp.getSource();
		doc.put("_id", id);
		return doc;
	}
	@Override
	public SearchResponse getDoc(QueryBuilder queryBuilder) {
		Client client = ClientUtil.getClient();
		SearchRequestBuilder sbuilder = client.prepareSearch(Comm.DEFAULT_INDEX).setTypes("titles");
		sbuilder.setQuery(queryBuilder);
		SearchResponse response = sbuilder.execute().actionGet();
		
		return response;
	}
	


}
