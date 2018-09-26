package com.wd.front.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.model.DocDelivery;
import com.wd.backend.model.ExceptionInfo;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.History;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.model.URLRule;
import com.wd.backend.service.MailService;
import com.wd.backend.service.PurchaseDBServiceI;
import com.wd.backend.service.URLRuleServiceI;
import com.wd.comm.Comm;
import com.wd.comm.context.SystemContext;
import com.wd.front.bo.Condition;
import com.wd.front.bo.SearchDocument;
import com.wd.front.bo.WebServiceSearchResult;
import com.wd.front.service.DocDiliveryServiceI;
import com.wd.front.service.FavoriteServiceI;
import com.wd.front.service.SearchLogServiceI;
import com.wd.service.SearchForWebServiceI;
import com.wd.service.SearchForWebServiceOBI;
import com.wd.util.Acquisition;
import com.wd.util.AjaxResult;
import com.wd.util.ConditionBuilder;
import com.wd.util.JsonUtil;
import com.wd.util.MD5Util;
import com.wd.util.MemberIdFromSession;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;

/**
 * 学术发现
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/scholar")
public class DiscoveryController {
	
	private static final Logger log=Logger.getLogger(DiscoveryController.class);

	private static final Pattern pattern = Pattern.compile("[^0-9]");
	/**
	 * 已经购买的数据库
	 */
	@Autowired
	private PurchaseDBServiceI pdService;
	
	/**
	 * URL替换规则
	 */
	@Autowired
	private URLRuleServiceI urlRuleService;
	
	@Autowired
	private SearchLogServiceI logService;
	
	/**
	 * 学术发现首页
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = { "","/" }, method = { RequestMethod.GET })
	public String index(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		request.setAttribute("mindex", 1);
		return isMobile+"sites/docIndex";
		//return "/sites/weihu";
	}
	
	@RequestMapping(value = {"/redirect/{id}" }, method = { RequestMethod.GET })
	public void redirect(@PathVariable String id,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		List<SearchDocument> list=(List<SearchDocument>)session.getAttribute(Comm.DOC_SESSION_CACHE);
		if(list == null) {
			try {
				response.sendRedirect("/sites/404NotFind.jsp");
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		for(SearchDocument doc : list){
			if(doc.getId().equals(id)){
				String url=doc.getHref(),title=doc.getTitle();
				String batchId=request.getParameter("batchId");
				addHistory(title,url,batchId,2,session);
				try {
//					url = replaceUrl(url);
					response.sendRedirect(url);
					return;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		try {
			response.sendRedirect("/sites/err.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
//		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/";
	}
	/**
	 * 维普资源特殊处理
	 * @param url
	 * @return
	 */
	private String replaceUrl(String url) {
		if(url.contains("vip.hnadl.cn")) {
			String host = url.substring(0,url.indexOf("vip.hnadl.cn/")+13);
			String end = url.substring(url.lastIndexOf("/")+1);
			url = host+"article/detail.aspx?id="+end;
			url = url.replace(".html", "");
		}
		if(url.contains("qikan.cqvip.com")) {
			String host = url.substring(0,url.indexOf("qikan.cqvip.com/")+16);
			String end = url.substring(url.lastIndexOf("/")+1);
			url = host+"article/detail.aspx?id="+end;
			url = url.replace(".html", "");
		}
		if(url.contains("cnki.com.cn")) {
			String dbcode = url.substring(url.lastIndexOf("/")+1,url.lastIndexOf("/")+5);
			String filename = url.substring(url.lastIndexOf("-")+1,url.lastIndexOf("."));
			url = "http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode="+dbcode+"&filename=" + filename;
			if("CDMD".equals(dbcode)) {
				url = url + ".nh";
			}
		}
		return url;
	}
	
	/**
	 * 构建查询请求参数
	 * @param condition
	 * @return
	 */
	private String buildRequestXml(Condition condition){
		if ((condition.getGroups()!=null&&condition.getGroups().size()>0)||SimpleUtil.strNotNull(condition.getVal()) 
				|| SimpleUtil.strNotNull(condition.getJournal())|| SimpleUtil.strNotNull(condition.getOther())) {
			condition.swapYear();
			return condition.toXML();
		}
		return null;
	}
	
	private void addHistory(String keyword,String url,String batchId,Integer type,HttpSession session){
		History h=new History();
		h.setMethod("search");
		h.setKeyword(keyword);
		h.setUrl(url);
		h.setBatchId(batchId);
		h.setSystemType(type);
		h.setType(0);
		h.setTime(new Date());
		h.setSystemId(2);
		int memberId = MemberIdFromSession.getMemberId(session);
		h.setMemberId(memberId);
		
		OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
		if(org!=null){
			h.setOrgFlag(org.getFlag());
		}
		if(keyword != null && !"".equals(keyword)) {
		logService.addAsynHistory(h);
		}
	};
	@Autowired
	private MailService mailService;
	/**
	 * 从WebService 中查找
	 * @param condition
	 * @return
	 */
	int num = 2;
	private WebServiceSearchResult queryFromWebService(Condition condition,HttpServletRequest request){
		String offset = (String) request.getParameter("offset");
		if(offset != null) {
			SystemContext.setOffset(Integer.parseInt(offset));
		}
		String userAgent=request.getHeader("User-Agent");
		condition.setUserAgent(userAgent);
		condition.setSource((int) request.getSession().getAttribute("source"));
		String requestXml=buildRequestXml(condition);
		System.out.println("requestXml:"+requestXml);
		if(requestXml.contains("http://") || requestXml.contains("https://")) {
			String	rs = "{\"count\":\"0\",\"total\":\"0\",\"timeMap\":{},\"rows\":[]}";
			WebServiceSearchResult result = JsonUtil.json2Obj(rs, WebServiceSearchResult.class);
			return result;
		}
		if(requestXml!=null){
			SearchForWebServiceI searchForWebService = (SearchForWebServiceI) SpringContextUtil.getBean("searchConnect");
			//韩国云主机谷歌接口地址
			SearchForWebServiceOBI searchForWebServiceOB = (SearchForWebServiceOBI) SpringContextUtil.getBean("searchConnectOB");
			long start = System.currentTimeMillis();
			WebServiceSearchResult result=null;
			try{
				//如果为空，则去谷歌接口获取
				String	rs = searchForWebService.search(requestXml);
				result = JsonUtil.json2Obj(rs, WebServiceSearchResult.class);
				List<SearchDocument> list=(List<SearchDocument>)request.getSession().getAttribute(Comm.DOC_SESSION_CACHE);
				if(list == null) {
					list = new ArrayList<SearchDocument>();
				}
//				for (SearchDocument searchDocument : result.getRows()) {
//					String url = searchDocument.getHref();
//					url = replaceUrl(url);
//					searchDocument.setHref(url);
//				}
				list.addAll(result.getRows());
				request.getSession().setAttribute(Comm.DOC_SESSION_CACHE, list);//将数据保存到Session中
			}catch(Exception e){
				mailService.send("yangshuaifei@hnwdkj.com", "谷歌接口提醒", "谷歌接口无法返回数据"+e, null);
				throw new RuntimeException("查询出现异常,请稍后重试!",e);
			}
			long end = System.currentTimeMillis();
			if (null != result) {
				String count = result.getCount();
				int total = 0;
				if (null != count) {
					count = count.replaceAll(",", "").replaceAll("[ ]+", "");

				    Matcher matcher = pattern.matcher(count);
					count = matcher.replaceAll("");
					try {
						total = Integer.parseInt(count);
					} catch (NumberFormatException e) {
					}
				}
				//request.setAttribute("count", total);
				result.setTotal(total);
				OrgBO org = (OrgBO) request.getSession().getAttribute(Comm.ORG_SESSION_NAME);
				List<PurchaseDB> dbs=null;
				List<URLRule> rules=null;
				if(org!=null){
					//检测本地
					dbs=pdService.findByOrg(org.getFlag());
					//URL替换
					rules=this.urlRuleService.findAll(org.getFlag());
				}
				for(SearchDocument doc :result.getRows()){
					if(!StringUtils.isEmpty(doc.getDocType())&&doc.getDocType().contains("图书")){
						doc.setIsOpen(true);//图书
					}
					if(!StringUtils.isEmpty(doc.getSource())&&doc.getSource().contains("books.google.com")){
						doc.setIsOpen(true);
						String href=doc.getHref();
						href=href.replace("https://www.google.com/books", "https://books.glgoo.com/books");
						doc.setHref(href);
						doc.setGoogleBook(true);
					}
					if(dbs!=null&&dbs.size()>0){
						for(PurchaseDB db:dbs){
							String href=doc.getHref();
							if(href.contains(db.getUrl()) && db.getDbType()==1){
								doc.setHasLocal(true);
							}
						}
					}
					if(rules!=null&&rules.size()>0){
						for(URLRule rule:rules){
							String href=doc.getHref();
							if(href.contains(rule.getGsUrl())){
								href=href.replaceAll(rule.getGsUrl(), rule.getLocalUrl());
								doc.setHref(href);
								continue;
							}
						}
					}
					String url = doc.getHref();
					url = replaceUrl(url);
					doc.setHref(url);
				}
				result.setTime(((end - start) / (float) 1000));
				return result;
			}
		}
		return null;
	}
	
	private void setPageRange(int pageCount,int currentPage,int size,HttpServletRequest request){
		int half=size/2,min,max;
		min=(currentPage-half)<0?0:(currentPage-half);
		max=min+size-1;
		if(max>pageCount){
			max=pageCount;
			if((max-size+1)>0){
				min=max-size+1;
			}
		}
		request.setAttribute("start", min);
		request.setAttribute("end", max);
	}
	
	private void filter(Condition condition){
		if(condition.getSites()!=null&&condition.getSites().size()>0){
			List<String> list=new ArrayList<String>();
			for(String site:condition.getSites()){
				if(!StringUtils.isEmpty(site)){
					list.add(site);
				}
			}
			condition.setSites(list);
		}
	}
	
	@RequestMapping(value = { "/journalList" }, method = { RequestMethod.GET })
	public String jounalSearch(final Condition condition,final HttpServletRequest request, HttpServletResponse response, HttpSession session){
		request.setAttribute("condition", condition);
		condition.setSource((int) request.getSession().getAttribute("source"));
		if(condition.getSource() == 1) {
			WebServiceSearchResult result = queryFromWebService(condition,request);
			String journalUrl = result.getJournalUrl();
			condition.setOther(journalUrl);
			condition.setType("journalArticle");
		}
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		if(!StringUtils.isEmpty(condition.getJournal())){
			WebServiceSearchResult result=null;
			//设置请求超时
			final ExecutorService exec = Executors.newFixedThreadPool(1); 
	        Callable<WebServiceSearchResult> call = new Callable<WebServiceSearchResult>() {  
	            @Override
                public WebServiceSearchResult call() throws Exception {
	                //开始执行耗时操作  
	                return queryFromWebService(condition,request);  
	            }  
	        };  
	        String remark = null;
	        String nowUrl = request.getRequestURI(); 
            String queryString = request.getQueryString(); 
	        try {  
	            Future<WebServiceSearchResult> future = exec.submit(call);  
	            result = future.get(1000 * 6, TimeUnit.MILLISECONDS); //任务处理超时时间设为 1 秒  
	        } catch (Exception e) {  
	        	request.setAttribute("errorMsg", 1);	//1请求超时 2没有最新文章
	        	request.setAttribute("url", nowUrl.replace("/journal/", "/") + "?" + queryString);
	        	remark = e.getMessage();
	        }  finally {	// 关闭线程池  
	        	exec.shutdown();  
	        }
	        if(result==null || result.getRows()==null) { //请求失败
	        	request.setAttribute("errorMsg", 1); 	//1请求超时 2没有最新文章
	        	remark = "请求失败";
	        } else if(result.getRows().size()==0) {
	        	request.setAttribute("errorMsg", 2);	//1请求超时 2没有最新文章
	        	remark = "该期刊最近一年没有发布文章。";
	        } else {
				request.setAttribute("result", result);
				for(int i=0; i < result.getRows().size(); i++) {	//查看文章是否被收藏
					Favorite favorite = favoriteService.getByDocId(result.getRows().get(i).getId(), MemberIdFromSession.getMemberId(session));
					if(favorite != null) {
						result.getRows().get(i).setFavorite(true);
					}
				}
			}
			if(remark != null) {
				ExceptionInfo info = new ExceptionInfo();
				String url = request.getRequestURL().toString().replaceAll("scholar/journalList", "journal/detail/"+request.getParameter("_id"));
				info.setName(condition.getJournal());
				info.setUrl(url);
				info.setInfo("无结果");
				info.setSource("最新期刊文章");
				info.setCollectDate(new Date());
				info.setRemark(remark);
				logService.insertException(info);
			}
		}
		String offset = request.getParameter("offset");
		request.setAttribute("offset", offset);
		if(Comm.Mobile.equals(isMobile)) {
			return isMobile+"sites/docListPage";
		}
		if(condition.getSource() == 1) {
			return "sites/journalListBing";
		}
		return "sites/journalList";
	}
	
	/**
	 * 使用WebService从Google查询数据
	 * @param condition
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String webSearch( Condition condition, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		//return "/sites/weihu";
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		request.setAttribute("mindex", 1);
		if(!Acquisition.acquisition(request, "searchMap") || request.getSession().getAttribute("acquisition") != null) {
			//转到验证码
			request.getSession().setAttribute("acquisition", "acquisition");
			request.getSession().setAttribute("title", "Spis学术搜索结果列表");
			return isMobile+"sites/validate";
		}
		
		if(condition.getFileType() != null && "20".equals(condition.getFileType())) {
			condition.setFileType(null);
		}
		filter(condition);
		request.setAttribute("condition", condition);
		String all=condition.getVal()+condition.getJournal()+condition.getOther();
		if(StringUtils.contains(all, "徐才厚")){
			request.setAttribute("errorMsg", "根据相关法律法规和政策，对相关检索词进行屏蔽。");
			return isMobile+"sites/docError";
		}
		if(StringUtils.isEmpty(condition.getOther())){
			
			request.setAttribute("searchKey", ConditionBuilder.unBuiler(condition));
			request.setAttribute("cookieKey", ConditionBuilder.unBuilerHistory(condition));
		}else{
			request.setAttribute("searchKey",condition.getVal());
		}
		WebServiceSearchResult result=null;
		try{
			result=queryFromWebService(condition,request);
			int count=result.getTotal();
			String counts = request.getParameter("counts");
			if(counts != null) {
				result.setCount(counts);
				count = Integer.parseInt(counts);
			}
			int pageCount=count/SystemContext.getPageSize(),currentPage=SystemContext.getOffset()/SystemContext.getPageSize();
			if(condition.getSource() == 1) {
				pageCount=count/10;
				currentPage=SystemContext.getOffset()/10;
			}
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("pageCount", pageCount);
			setPageRange(pageCount,currentPage,10,request);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("errorMsg", e.getMessage());
			return isMobile+"sites/docError";
		}
		if (result!=null) {
			OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
			if(org!=null){
				List<PurchaseDB> dbs=pdService.findByOrg(org.getFlag());
				//已经购买的数据库
				request.setAttribute("dbs",dbs);
			}
			request.setAttribute("result", result);
			String key = ConditionBuilder.unBuilerHistory(condition);
			String batchId = MD5Util.getMD5(key.getBytes());
			condition.setBatchId(batchId);
			request.setAttribute("batchId",batchId);
			if(condition.getOther() == null) {
				addHistory(ConditionBuilder.unBuilerHistory(condition),request.getQueryString(),condition.getBatchId(),1, session);
			} else {
				addHistory(ConditionBuilder.unBuilerHistory(condition),request.getQueryString(),condition.getBatchId(),2, session);
			}
		}
		//记录热门检索词日志
		if(StringUtils.isNotBlank(condition.getVal())){
			logService.addAsynHotLog(getOrgFlag(session), condition.getVal());
		}
		//记录热门检索词日志
		if(StringUtils.isNotBlank(condition.getVal())){
			logService.addAsynHotLog(getOrgFlag(session), condition.getVal());
		}
		for(int i=0; i < result.getRows().size(); i++) {
			Favorite favorite = favoriteService.getByDocId(result.getRows().get(i).getId(), MemberIdFromSession.getMemberId(session));
			if(favorite != null) {
				result.getRows().get(i).setFavorite(true);
			}
		}
		String offset = request.getParameter("offset");
		request.setAttribute("offset", offset);
		if((offset != null && !"0".equals(offset)) && Comm.Mobile.equals(isMobile)) {
			if(condition.getSource() == 1) {
				return isMobile+"sites/docListPageBing";
			}
			return isMobile+"sites/docListPage";
		}
		if(condition.getSource() == 1) {
			return isMobile+"sites/docListBing";
		}
		return isMobile+"sites/docList";
	}
	
	/**
	 * 引用
	 * @return
	 */
	@RequestMapping(value = { "/quoteList" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult webSearchQuote(HttpServletRequest request, HttpServletResponse response) {
		Condition condition = new Condition();
		String url = request.getParameter("url");
		String type = request.getParameter("type");
//		condition.setVal("url="+url);
		condition.setOther(url);
		condition.setType(type);//导出题录
		condition.setSource((int) request.getSession().getAttribute("source"));
		String rs = null;
		String requestXml=buildRequestXml(condition);
		if(requestXml!=null){
			SearchForWebServiceI searchForWebService = (SearchForWebServiceI) SpringContextUtil.getBean("searchConnect");
			//韩国云主机谷歌接口地址
			SearchForWebServiceOBI searchForWebServiceOB = (SearchForWebServiceOBI) SpringContextUtil.getBean("searchConnectOB");
			try{
//				rs = googleQueryModule.search(condition);		//先从谷歌镜像获取数据
//				if(StringUtils.isEmpty(rs)) {							//如果为空，则去谷歌接口获取
//					rs = searchForWebService.search(requestXml);
//				}
				rs = searchForWebService.search(requestXml);
				if(StringUtils.isEmpty(rs)) {	
					rs = searchForWebServiceOB.search(requestXml);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new AjaxResult(rs);
	}
	
	/**
	 * 文献传递
	 */
	@Autowired
	private DocDiliveryServiceI docDiliveryService;
	/**
	 * 必应详细页面处理
	 * @param id
	 * @param request
	 * @param response
	 * @param session
	 */
	@RequestMapping(value = {"/bingRedirect/{id}" }, method = { RequestMethod.GET })
	public void bingRedirect(@PathVariable String id,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		List<SearchDocument> list=(List<SearchDocument>)session.getAttribute(Comm.DOC_SESSION_CACHE);
		Favorite favorite = favoriteService.getByDocId(id, MemberIdFromSession.getMemberId(session));
		DocDelivery docDelivery = null;
		try {
			long dilId = Long.parseLong(id);
			docDelivery = docDiliveryService.get(dilId);
		} catch(Exception e){}
		//List<Favorite> favorites = p.getRows();
		if(list == null && favorite == null && docDelivery == null) {
			try {
				response.sendRedirect("/sites/404NotFind.jsp");
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (docDelivery != null) {
			SearchDocument doc = new SearchDocument();
			doc.setHref(docDelivery.getUrl());
			doc.setId(docDelivery.getId()+"");
			doc.setTitle(docDelivery.getTitle());
			id=docDelivery.getDocId();
			if(list == null) {
                list = new ArrayList<SearchDocument>();
            }
			list.add(doc);
		}
		//必应的文章收藏处理
		if (favorite != null) {
			SearchDocument doc = new SearchDocument();
			String content = favorite.getContent();
			Map<String,Object> map = JsonUtil.json2Obj(content, Map.class);
			String href = map.get("href").toString();
			doc.setHref(href);
			doc.setId(favorite.getDocId());
			doc.setTitle(map.get("title").toString());
			if(list == null) {
                list = new ArrayList<SearchDocument>();
            }
			list.add(doc);
		}
		for(SearchDocument doc : list){
			if(doc.getId().equals(id)){
				String url=doc.getHref(),title=doc.getTitle();
				if(url.contains("/academic/")) {
					WebServiceSearchResult result=null;
					try{
						Condition condition = new Condition();
						condition.setOther(url);
						condition.setSource((int) request.getSession().getAttribute("source"));
						if(url.contains("profile?id=")) {
							condition.setType("articleTitle");
							result=queryFromWebService(condition,request);
						} else {
							condition.setType("redirectTitle");
							result=queryFromWebService(condition,request);
							if(result.getRows() != null && result.getRows().size() > 0) {
								url = result.getRows().get(0).getHref();
							}
							condition.setOther(url);
							condition.setType("articleTitle");
							result=queryFromWebService(condition,request);
						}
						if(result.getRows() != null && result.getRows().size() > 0) {
							url = result.getRows().get(0).getHref();
						}
					}catch (Exception e) {
						
					}
				}
				String batchId=request.getParameter("batchId");
				addHistory(title,url,batchId,2,session);
				try {
//					url = replaceUrl(url);
					response.sendRedirect(url);
					return;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		try {
			response.sendRedirect("/sites/err.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**收藏*/
	@Autowired
	private FavoriteServiceI favoriteService;
	
	private String getOrgFlag(HttpSession session){
		OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
		if(org != null){
			return org.getFlag();
		}
		return "ydd";
	}
}
