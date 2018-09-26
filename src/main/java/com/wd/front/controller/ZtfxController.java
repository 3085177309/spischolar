package com.wd.front.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wd.front.bo.DocForKeyword;
import org.apache.lucene.index.Term;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.aggregations.Aggregation;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.histogram.HistogramAggregationBuilder;
import org.elasticsearch.search.aggregations.bucket.nested.Nested;
import org.elasticsearch.search.aggregations.bucket.nested.NestedAggregationBuilder;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.aggregations.bucket.terms.Terms.Order;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wd.front.service.ZtfxServiceI;
import com.wd.util.Acquisition;
import com.wd.util.ClientUtil;
import com.wd.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ztfx")
public class ZtfxController {

	@Autowired
	private ZtfxServiceI ztfxService;
	
	@RequestMapping(value = { "/init" }, method = { RequestMethod.GET })
	public String init(HttpServletRequest req, HttpServletResponse rsp){
		return "sites/ztfx";
	}
	
	
	@RequestMapping("/getZtpc")
	public void getZtpc(HttpServletRequest req, HttpServletResponse rsp) {
		String id = req.getParameter("id");
		int startYear = Integer.parseInt(req.getParameter("startYear"));
		int endYear = Integer.parseInt(req.getParameter("endYear"));
		String pageResult = ztfxService.getZtpc(id, startYear, endYear);
		
		ResponseUtil.send(rsp, pageResult);
	}
	
	/**
	 * 发文趋势
	 * @param req
	 * @param rsp
	 */
	@RequestMapping("/getFwqs")
	public void getFwqs(HttpServletRequest req, HttpServletResponse rsp){
		String id = req.getParameter("id");
		int startYear = 2012;
		Calendar calendar = Calendar.getInstance();
		int endYear = calendar.get(Calendar.YEAR) - 1;
		String pageResult = ztfxService.getFwqs(id, startYear, endYear);
		
		ResponseUtil.send(rsp, pageResult);
		
	}
	
	@RequestMapping("/getTfzt")
	public void getTfzt(HttpServletRequest req, HttpServletResponse rsp){
		String id = req.getParameter("id");
		int startYear = 2012;
		Calendar calendar = Calendar.getInstance();
		int endYear = calendar.get(Calendar.YEAR) - 1;
		String pageResult = ztfxService.getTfzt(id, startYear, endYear);
		rsp.setHeader("Cache-Control", "public");
		ResponseUtil.send(rsp, pageResult);
	}
	
	
	@RequestMapping("/getMoreFwqsForKey")
	public void getMoreFwqsForKey(HttpServletRequest req, HttpServletResponse rsp){
		String keyword = req.getParameter("key");
		int startYear = 2012;
		Calendar calendar = Calendar.getInstance();
		int endYear = calendar.get(Calendar.YEAR) - 1;
		String pageResult = ztfxService.getMoreFwqsForKey(keyword,startYear,endYear);
		ResponseUtil.send(rsp, pageResult);
	}
	
	
	@RequestMapping("/getFwqk")
	public void getFwqk(HttpServletRequest req, HttpServletResponse rsp){
		String keyword = req.getParameter("key");
		String pageResult = ztfxService.getFwqk(keyword);
		ResponseUtil.send(rsp, pageResult);
	}

	@RequestMapping("/getDocForKey")
	@ResponseBody
	public List<DocForKeyword> getDocForKey(HttpServletRequest request, HttpServletResponse response){
		String jguid = request.getParameter("jguid");
		String keyword = request.getParameter("keyword");
		return ztfxService.getDocForKeyword(jguid,keyword);
	}
}
