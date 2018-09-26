package com.wd.front.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.AuthorityDatabase;
import com.wd.backend.model.DisciplineSystem;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.History;
import com.wd.backend.model.JournalImage;
import com.wd.backend.model.JournalSystemSubject;
import com.wd.backend.model.JournalUrl;
import com.wd.backend.model.Video;
import com.wd.comm.Comm;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.front.bo.Author;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.bo.ShouluMap;
import com.wd.front.context.SearchServiceContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.DetailServiceI;
import com.wd.front.service.FavoriteServiceI;
import com.wd.front.service.JournalImageServiceI;
import com.wd.front.service.JournalLinkServiceI;
import com.wd.front.service.SearchApiServiceI;
import com.wd.front.service.SearchLogServiceI;
import com.wd.front.service.SearchServiceI;
import com.wd.front.service.SuggestServiceI;
import com.wd.front.service.ZtfxServiceI;
import com.wd.front.service.impl.SearchApiServiceImpl;
import com.wd.util.Acquisition;
import com.wd.util.ClientUtil;
import com.wd.util.DetailParserUtil;
import com.wd.util.HttpUtil;
import com.wd.util.JsonUtil;
import com.wd.util.MD5Util;
import com.wd.util.MemberIdFromSession;
import com.wd.util.PinYinUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/journal")
public class SearchController {

    private static Logger logger = Logger.getLogger(SearchController.class);

    @Autowired
    private CacheModuleI cacheModule;

    @Autowired
    private SearchServiceContext searchServiceContext;
    @Autowired
    private JournalLinkServiceI journalLinkService;

    @Autowired
    private DetailServiceI detailService;

    @Autowired
    private ZtfxServiceI ztfxService;

    @Autowired
    private SearchLogServiceI logService;

    @Autowired
    private JournalImageServiceI journalImageService;

    /**
     * 收藏
     */
    @Autowired
    private FavoriteServiceI favoriteService;

    @Autowired
    private SuggestServiceI suggestService;
    /**
     * 最新学科体系变量名
     */
    private static final String new_discipline_system_param_name = "disciplineSystemMap";

    /**
     * 学科列表，期刊导航首页
     *
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = {"", "/"}, method = {RequestMethod.GET})
    public String overview(HttpServletRequest request, HttpSession session) {
        try {
            List<AuthorityDatabase> dbs = cacheModule.findDbPartitionFromCache();
            request.setAttribute("authDbs", dbs);
            List<JournalSystemSubject> subjectList = cacheModule.findSubjectPartitionFromCache();
            request.setAttribute("subjectList", subjectList);
            request.setAttribute("subjectListJson", JsonUtil.obj2Json(subjectList));
        } catch (SystemException e) {
            logger.error("缓存数据加载失败!", e);
            request.setAttribute("error", e.getMessage());
            return "error/error";
        }
        String isMobile = (String) request.getSession().getAttribute("isMobile");
        request.setAttribute("mindex", 2);
        return isMobile + "sites/overview";
    }

    /**
     * 跳转到指定的地址
     *
     * @param url
     * @param response
     */
    @RequestMapping(value = {"/redirect/{url}"}, method = {RequestMethod.GET})
    public void redirect(@PathVariable String url, HttpServletResponse response) {
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            logger.error("URL跳转失败!", e);
        }
    }

    @RequestMapping(value = {"/image/{id}"}, method = {RequestMethod.GET})
    public void showImage(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
        JournalImage jImage = journalImageService.findImage(id);
        OutputStream out = null;
        try {
            out = response.getOutputStream();
            if (jImage != null) {
                byte[] image = jImage.getLogo();
                if (image.length > 0) {
                    out.write(image);
                    out.flush();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map<String, Object> listToMap(List list) {
        Map<String, Object> map = new HashMap<String, Object>();
        for (int i = 0; i < list.size(); i++) {
            map.put(list.get(i).toString(), list.get(i));
        }
        return map;
    }

    /**
     * 期刊详情
     *
     * @param id
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = {"/detail/{id}"}, method = {RequestMethod.GET})
    public String detail(@PathVariable String id, HttpServletRequest request, HttpSession session) {
        String isMobile = (String) request.getSession().getAttribute("isMobile");
        request.setAttribute("id", id);
        //验证码
        if (!Acquisition.acquisition(request, "journalMap") || request.getSession().getAttribute("acquisition") != null) {
            //转到验证码
            request.getSession().setAttribute("acquisition", "acquisition");
            request.getSession().setAttribute("title", "期刊详情页面");
            return isMobile + "sites/validate";
        }
        String docId = id;
        Favorite favorite = favoriteService.getByDocId(docId, MemberIdFromSession.getMemberId(session));
        if (favorite != null) {
            request.setAttribute("isFavorie", true);
        } else {
            request.setAttribute("isFavorie", false);
        }
        try {
        	request.setAttribute("shoulu", DetailParserUtil.parseShoulu());
        } catch (SystemException e) {
            logger.error(e.getMessage(), e);
        }
//        if (ztfxService.checkZtfxExists(id)) {
//            request.setAttribute("ztfxIsExists", "true");
//            request.setAttribute("hotKeywords", ztfxService.hotKeywords("fwqs&" + id + "&2012&2016"));
//        } else {
//            request.setAttribute("ztfxIsExists", "false");
//        }
        Video video = favoriteService.getVideo(id);
        request.setAttribute("video", video);
        request.setAttribute("mindex", 2);
        if (request.getParameter("offset") != null && Comm.Mobile.equals(isMobile)) {
            return isMobile + "sites/detail";
        }
        return isMobile + "sites/detail";
    }


    @RequestMapping(value = {"/video"}, method = {RequestMethod.GET})
    public String video(HttpServletRequest request) {
        String submissionSystem = request.getParameter("submissionSystem");
        request.setAttribute("submissionSystem", submissionSystem);
        return "sites/qk-video";

    }


    private void addHistory(String keyword, String url, String batchId, Integer type, HttpSession session, String method, String db) {
        History h = new History();
        h.setKeyword(keyword);
        h.setUrl(url);
        h.setBatchId(batchId);
        h.setSystemType(type);
        h.setType(0);
        h.setTime(new Date());
        h.setSystemId(1);
        h.setMethod(method);
        h.setDb(db);
        int memberId = MemberIdFromSession.getMemberId(session);
        h.setMemberId(memberId);
        OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
        if (org != null) {
            h.setOrgFlag(org.getFlag());
        }
        logService.addAsynHistory(h);
    }

    ;

    @RequestMapping(value = {"/suggest/{value}"}, method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String suggest(@PathVariable String value) {
        List<String> suggest = suggestService.getSuggest(value);
        JSONArray jArr = JSONArray.fromObject(suggest);
        return jArr.toString();
    }


    private String getOrgFlag(HttpSession session) {
        OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
        if (org != null) {
            return org.getFlag();
        }
        return "ydd";
    }

    private String getKey(SearchCondition condition) {
        if (StringUtils.isNotBlank(condition.getValue())) {
            return condition.getValue();
        }
        String db = condition.getAuthorityDb(), subject = condition.getSubject();
        Integer year = condition.getDetailYear();
        String key = "";
        if (StringUtils.isNotBlank(db)) {
            key = db;
            if (StringUtils.isNotBlank(subject)) {
                key += " " + subject;
            }
        } else if (StringUtils.isNotBlank(subject)) {
            key = subject;
        }
        if (year != null) {
            key += "(" + year + ")";
        }
        return key;
    }

    /**
     * 期刊检索结果列表
     *
     * @param conditoin 检索条件
     * @param request
     * @return
     */
    @RequestMapping(value = {"/search/list"}, method = {RequestMethod.GET})
    public String search(SearchCondition conditoin, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        try {
            // 填充SearchComponent标识
            conditoin.setSearchComponentFlag("journal_search");
            // 执行检索
//            SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(conditoin.getSearchComponentFlag());
            if (StringUtils.isEmpty(conditoin.getValue()) || "请输入关键词".equalsIgnoreCase(conditoin.getValue())) {
                conditoin.setValue(null);
                if (conditoin.getFilterCdt().size() == 0 && conditoin.getFacetList().size() == 0
                        && conditoin.getFilterMap().size() == 0 && conditoin.getQueryCdt().size() == 0) {
                    return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/";
                }
            }
            String authorityDb = conditoin.getAuthorityDb();
            if (StringUtils.isNotBlank(authorityDb)) {
                session.setAttribute("db", authorityDb);
                if ("CSSCI".equals(authorityDb)) {
                    conditoin.setSort(3);
                }
                List<AuthorityDatabase> dbs = cacheModule.findDbPartitionFromCache();
                for (AuthorityDatabase db : dbs) {
                    if (db.getFlag().equals(authorityDb)) {
                        if (conditoin.getSort() == 11) {
                            conditoin.setSortField(db.getId() + "");
                            request.setAttribute("sortField", db.getId() + "");
                        }
                        request.setAttribute("field", db.getId() + "|" + conditoin.getDetailYear());
                        request.setAttribute("hasImpact", !Comm.subjectNO.contains(db.getFlag()));
                    }
                }
            } else {
                session.removeAttribute("db");
            }
//            if (null != searchService) {
//                long start = System.currentTimeMillis();
//                SystemContext.setPageSize(25);
//                SearchResult searchResult = searchService.search(conditoin);
//                List<Map<String, Object>> listDatas = searchResult.getDatas();
//                List<Map<String, Object>> datasList = new ArrayList<Map<String, Object>>();
//                for (Map<String, Object> mapDatas : listDatas) {
//                    String jGuid = (String) mapDatas.get("_id");
//                    JournalUrl mainLink = journalLinkService.searchMainLink(jGuid);
//                    if (mainLink != null) {
//                        mapDatas.put("mainLink", mainLink.getTitleUrl());
//                    } else {
//                        mapDatas.put("mainLink", "");
//                    }
//
//                    ArrayList shouLuList = (ArrayList) mapDatas.get("shouLu");
//                    for (int i = 0; i < shouLuList.size(); i++) {
//                        Map<String, Object> shouLuMap = (Map<String, Object>) shouLuList.get(i);
//                        if (shouLuMap.get("authorityDatabase").equals(conditoin.getAuthorityDb()) && ("CSCD".equals(shouLuMap.get("authorityDatabase")) || "CSSCI".equals(shouLuMap.get("authorityDatabase")))) {
//                            ArrayList detailList = (ArrayList) shouLuMap.get("detailList");
//                            int year = 0;
//                            String core = null;
//                            for (int j = 0; j < detailList.size(); j++) {
//                                Map<String, Object> map = (Map<String, Object>) detailList.get(j);
//                                String cor = (String) map.get("core");
//                                int detailYear = (int) map.get("detailYear");
//                                if (detailYear > year) {
//                                    year = detailYear;
//                                    core = cor;
//                                }
//                            }
//                            String info = shouLuMap.get("authorityDatabase") + " " + year + " " + core + "版";
//                            if ("CSSCI".equals(shouLuMap.get("authorityDatabase"))) {
//                                info = shouLuMap.get("authorityDatabase") + " " + (year - 1) + "-" + year + " " + core + "版";
//                            }
//                            String coreInfo = (String) mapDatas.get("coreInfo");
//                            if (coreInfo != null && "扩展".equals(core)) {
//                                coreInfo += "&#10;" + info;
//                                mapDatas.put("coreInfo", coreInfo);
//                            } else {
//                                if ("扩展".equals(core)) {
//                                    mapDatas.put("core", core);
//                                    mapDatas.put("coreInfo", info);
//                                }
//                            }
//                        }
//                    }
//                    datasList.add(mapDatas);
//                }
//                searchResult.setDatas(datasList);
//                //为了区分 购买和试用 的用户是否有使用中科院JCR数据的权限 zky=1：购买，其他没权限 (检索列表页--相关学科)其他地方都在jsp页面上控制
//                String zky = request.getSession().getAttribute("zky").toString();
//                Map<String, Map<String, String>> zkymap = searchResult.getFacetDatas();
//                Map<String, String> map = new HashMap<String, String>();
//                map.put("zky", zky);
//                zkymap.put("zky", map);
//                searchResult.setFacetDatas(zkymap);
//                request.setAttribute("searchResult", searchResult);
//                long end = System.currentTimeMillis();
//                searchResult.setTime(end - start);
//                request.setAttribute("cdt", conditoin);
//                request.setAttribute("offset", SystemContext.getOffset());
//
//                Date date = new Date();
//                DateFormat format = new SimpleDateFormat("HH:mm:ss");
//                String time = format.format(date);
//                String bat = conditoin.getSubject();
//                if (bat == null || "".equals(bat)) {
//                    bat = conditoin.getValue();
//                }
//                String batchId = MD5Util.getMD5(bat.getBytes());
//                conditoin.setBatchId(batchId);
//                if (StringUtils.isNotEmpty(conditoin.getValue())) {
//                    addHistory(getKey(conditoin), request.getQueryString(), batchId, 1, session, "search", conditoin.getAuthorityDb());
//                    request.setAttribute("searchType", "search");
//                } else {
//                    request.setAttribute("searchType", "category");
//                }
//            } else {
//                if (logger.isDebugEnabled()) {
//                    logger.debug("无法找到与[" + conditoin.getStrategyFlag() + "]对应的SearchServiceI实例!");
//                }
//            }
            
            
           
            request.setAttribute("cdt", conditoin);
            request.setAttribute("offset", SystemContext.getOffset());
            Date date = new Date();
            DateFormat format = new SimpleDateFormat("HH:mm:ss");
            String time = format.format(date);
            String bat = conditoin.getSubject();
            if (bat == null || "".equals(bat)) {
                bat = conditoin.getValue();
            }
            String batchId = MD5Util.getMD5(bat.getBytes());
            conditoin.setBatchId(batchId);
            if (StringUtils.isNotEmpty(conditoin.getValue())) {
                addHistory(getKey(conditoin), request.getQueryString(), batchId, 1, session, "search", conditoin.getAuthorityDb());
                request.setAttribute("searchType", "search");
            } else {
                request.setAttribute("searchType", "category");
            }
            

            try {
                List<AuthorityDatabase> dbs = cacheModule.findDbPartitionFromCache();
                request.setAttribute("authDbs", JsonUtil.obj2Json(dbs));
            } catch (SystemException e) {
                logger.error("缓存数据加载失败!", e);
                request.setAttribute("error", e.getMessage());
                return "error/error";
            }
            // 获取最新学科体系
            Map<String, Set<DisciplineSystem>> disciplineSystemMap;
            try {
                disciplineSystemMap = cacheModule.loadDisciplineSystemFromCache();
                request.setAttribute(new_discipline_system_param_name, disciplineSystemMap);
            } catch (SystemException e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
                return "error/error";
            }
            request.setAttribute(new_discipline_system_param_name, disciplineSystemMap);
            String offset = request.getParameter("offset");
            request.setAttribute("offset", offset);
            request.setAttribute("mindex", 2);
            String isMobile = (String) request.getSession().getAttribute("isMobile");
            if (offset != null && Comm.Mobile.equals(isMobile)) {
                return isMobile + "sites/listPage";
            }
            return isMobile + "sites/list";
        } catch (Exception e) {
            e.printStackTrace();
            return "error/error";
        }
    }

    /**
     * 期刊浏览结果列表
     *
     * @param conditoin
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = {"/category/list"}, method = {RequestMethod.GET})
    public String category(SearchCondition conditoin, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        String offset = request.getParameter("offset");
        try {
            // 填充SearchComponent标识
//            conditoin.setSearchComponentFlag("journal_search");
            int startYear = conditoin.getDetailYear();
            // 执行检索
//            SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(conditoin.getSearchComponentFlag());
            if (StringUtils.isEmpty(conditoin.getValue()) || "请输入关键词".equalsIgnoreCase(conditoin.getValue())) {
                conditoin.setValue(null);
                if (conditoin.getFilterCdt().size() == 0 && conditoin.getFacetList().size() == 0
                        && conditoin.getFilterMap().size() == 0 && conditoin.getQueryCdt().size() == 0) {
                    return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/";
                }
            }

            String authorityDb = conditoin.getAuthorityDb();
            request.getSession().setAttribute("db", authorityDb);
            //向中科院发送请求
            String jsonUrl = "";
            String subject = "";
            if ("中科院JCR分区(大类)".equals(authorityDb) && !"2016".equals(conditoin.getDetailYear())) {
                subject = URLEncoder.encode(conditoin.getSubject(), "utf-8");
                jsonUrl = "http://api.fenqubiao.com/api/journal/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/" + conditoin.getDetailYear() + "/%E5%A4%A7%E7%B1%BB/" + subject + "/0/desc/0/25";
                HttpUtil.getZkySubjectXml(jsonUrl);
            }
            if ("中科院JCR分区(小类)".equals(authorityDb) && !"2016".equals(conditoin.getDetailYear())) {
                subject = conditoin.getSubject().replaceAll(" ", "%20");
                subject = subject.replaceAll("&", "and");
                jsonUrl = "http://api.fenqubiao.com/api/journal/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/" + conditoin.getDetailYear() + "/%E5%B0%8F%E7%B1%BB/" + subject + "/0/desc/0/25";
                HttpUtil.getZkySubjectXml(jsonUrl);
            }
            if (StringUtils.isNotBlank(authorityDb)) {
                List<AuthorityDatabase> dbs = cacheModule.findDbPartitionFromCache();
                for (AuthorityDatabase db : dbs) {
                    if (db.getFlag().equals(authorityDb)) {
                        if (conditoin.getSort() == 11) {
                            conditoin.setSortField(db.getId() + "");
                            request.setAttribute("sortField", db.getId() + "");
                        }
                        request.setAttribute("field", db.getId() + "|" + conditoin.getDetailYear());
                        request.setAttribute("hasImpact", !Comm.subjectNO.contains(db.getFlag()));
                    }
                }
            } else {
                session.removeAttribute("db");
            }
//            if (null != searchService) {
//                long start = System.currentTimeMillis();
//                SystemContext.setPageSize(25);
//                SearchResult searchResult = searchService.search(conditoin);
//                List<Map<String, Object>> listDatas = searchResult.getDatas();
//                List<Map<String, Object>> datasList = new ArrayList<Map<String, Object>>();
//                for (Map<String, Object> mapDatas : listDatas) {
//                    String jGuid = (String) mapDatas.get("_id");
//                    JournalUrl mainLink = journalLinkService.searchMainLink(jGuid);
//                    if (mainLink != null) {
//                        mapDatas.put("mainLink", mainLink.getTitleUrl());
//                    } else {
//                        mapDatas.put("mainLink", "");
//                    }
//
//                    ArrayList shouLuList = (ArrayList) mapDatas.get("shouLu");
//                    for (int i = 0; i < shouLuList.size(); i++) {
//                        Map<String, Object> shouLuMap = (Map<String, Object>) shouLuList.get(i);
//                        if ("CSCD".equals(shouLuMap.get("authorityDatabase")) || "CSSCI".equals(shouLuMap.get("authorityDatabase"))) {
//                            ArrayList detailList = (ArrayList) shouLuMap.get("detailList");
//                            int year = 0;
//                            String core = null;
//                            for (int j = 0; j < detailList.size(); j++) {
//                                Map<String, Object> map = (Map<String, Object>) detailList.get(j);
//                                String cor = (String) map.get("core");
//                                int detailYear = (int) map.get("detailYear");
//                                if (detailYear > year && detailYear <= startYear) {
//                                    year = detailYear;
//                                    core = cor;
//                                }
//                            }
//                            mapDatas.put("core", core);
//                            mapDatas.put("coreInfo", core);
//                        }
//                    }
//                    datasList.add(mapDatas);
//                }
//
//                searchResult.setDatas(datasList);
//                request.setAttribute("searchResult", searchResult);
//                long end = System.currentTimeMillis();
//                searchResult.setTime(end - start);
//                request.setAttribute("cdt", conditoin);
//                request.setAttribute("offset", SystemContext.getOffset());
//
//                String bat = conditoin.getSubject();
//                if (bat == null) {
//                    bat = conditoin.getValue();
//                }
//                String batchId = MD5Util.getMD5(bat.getBytes());
//
//                conditoin.setBatchId(batchId);
//                addHistory(getKey(conditoin), request.getQueryString(), batchId, 1, session, "category", conditoin.getAuthorityDb());
//            } else {
//                if (logger.isDebugEnabled()) {
//                    logger.debug("无法找到与[" + conditoin.getStrategyFlag() + "]对应的SearchServiceI实例!");
//                }
//            }
            
            request.setAttribute("cdt", conditoin);
            request.setAttribute("offset", SystemContext.getOffset());
            String bat = conditoin.getSubject();
            if (bat == null || "".equals(bat)) {
                bat = conditoin.getValue();
            }
            String batchId = MD5Util.getMD5(bat.getBytes());
            conditoin.setBatchId(batchId);
            addHistory(getKey(conditoin), request.getQueryString(), batchId, 1, session, "category", conditoin.getAuthorityDb());

            try {
                List<AuthorityDatabase> dbs = cacheModule.findDbPartitionFromCache();
                request.setAttribute("authDbs", dbs);
            } catch (SystemException e) {
                logger.error("缓存数据加载失败!", e);
                request.setAttribute("error", e.getMessage());
                return "error/error";
            }
            // 获取最新学科体系
            Map<String, Set<DisciplineSystem>> disciplineSystemMap;
            try {
                disciplineSystemMap = cacheModule.loadDisciplineSystemFromCache();
                request.setAttribute(new_discipline_system_param_name, disciplineSystemMap);
            } catch (SystemException e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
                return "error/error";
            }
            request.setAttribute(new_discipline_system_param_name, disciplineSystemMap);

            request.setAttribute("mindex", 2);
            request.setAttribute("offset", offset);
            String isMobile = (String) request.getSession().getAttribute("isMobile");
            if (offset != null && Comm.Mobile.equals(isMobile)) {
                return isMobile + "sites/categoryListPage";
            }
            return isMobile + "sites/categoryList";
        } catch (Exception e) {
            e.printStackTrace();
            return "error/error";
        }
    }


//    @RequestMapping(value = {"/subject/{subjectNameId}/{id}/{year}"}, method = {RequestMethod.GET, RequestMethod.POST})
//    public String subjectList(@PathVariable int subjectNameId, @PathVariable int id, @PathVariable String year, String subject, HttpServletRequest request) {
//        SearchCondition condition = new SearchCondition();
//        String[] dbs = {"SCI-E", "中科院JCR分区(小类)", "中科院JCR分区(大类)", "CSCD", "Eigenfactor", "CSSCI", "北大核心", "SSCI", "SCOPUS", "ESI", "EI"};
//        String[] subjectNames = {"人文社科类", "理学", "工学", "农学", "医学", "综合"};
//        String db = dbs[id - 1];
//        String subjectName = subjectNames[subjectNameId - 1];
//        if ((id == 2 || id == 3) && !"2012".equals(year)) {
//            getResult(db, year);
//            //request.setAttribute("searchResult", result);
//        }
//        condition.setSearchComponentFlag("subject_system_search");
//        condition.addQueryCdt("scSName_3_1_" + subjectName);
//        condition.addQueryCdt("scDB_3_1_" + db);
//        condition.addQueryCdt("scYear_3_1_" + year);
//
//
//        if (!StringUtils.isEmpty(subject)) {
//            condition.addQueryCdt("scDis_3_1_" + subject);
//        }
//        SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
//        SearchResult result = searchService.search(condition);
//        request.setAttribute("searchResult", result);
//
//        return "sites/subjectList";
//    }
    
    @Autowired
    SearchApiServiceI searchAPIService;
    
    @RequestMapping(value = {"/subject/{subjectNameId}/{id}/{year}"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String subjectList(@PathVariable int subjectNameId, @PathVariable int id, @PathVariable String year, String subject, HttpServletRequest request) {
//        SearchCondition condition = new SearchCondition();
//        String[] dbs = {"SCI-E", "中科院JCR分区(小类)", "中科院JCR分区(大类)", "CSCD", "Eigenfactor", "CSSCI", "北大核心", "SSCI", "SCOPUS", "ESI", "EI"};
//        String[] subjectNames = {"人文社科类", "理学", "工学", "农学", "医学", "综合"};
//        String db = dbs[id - 1];
//        String subjectName = subjectNames[subjectNameId - 1];
//        if ((id == 2 || id == 3) && !"2012".equals(year)) {
//            getResult(db, year);
//            //request.setAttribute("searchResult", result);
//        }
//        condition.setSearchComponentFlag("subject_system_search");
//        condition.addQueryCdt("scSName_3_1_" + subjectName);
//        condition.addQueryCdt("scDB_3_1_" + db);
//        condition.addQueryCdt("scYear_3_1_" + year);
//
//
//        if (!StringUtils.isEmpty(subject)) {
//            condition.addQueryCdt("scDis_3_1_" + subject);
//        }
//        SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
//        SearchResult result = searchService.search(condition);
        String apiResult = searchAPIService.getSubjectList(subjectNameId, id, year, subject);
        SearchResult result = JsonUtil.json2Obj(apiResult, SearchResult.class);
        request.setAttribute("searchResult", result);
        return "sites/subjectList";
    }

    public static void getResult(String db, String year) {
        //SearchResult result= new SearchResult();
        //List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
        String jsonUrl = "http://api.fenqubiao.com/api/category/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/" + year + "/大类";
        if ("中科院JCR分区(小类)".equals(db)) {
            jsonUrl = "http://api.fenqubiao.com/api/category/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/" + year + "/小类";
        }
        HttpUtil util = new HttpUtil(jsonUrl);
        util.start();
		/*String subjects ="";
		try {
			subjects = HttpUtil.getZkySubjectXml(jsonUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//只是向中科院发送请求，并不使用返回的结果
		JSONArray myJsonArray = JSONArray.fromObject(subjects);
		if(myJsonArray.size()>0){
			  for(int i=0;i<myJsonArray.size();i++){
				Map<String, Object> map = new HashMap<String, Object>();
			    JSONObject job = myJsonArray.getJSONObject(i); 
			    String subject = job.get("Name").toString();
			    map.put("discipline", subject);
			    map.put("disciplineNotAnalyzed", subject);
			    map.put("authorityDatabase", db);
			    map.put("docType", "10");
			    map.put("isNew", "1");
			    map.put("dbYearDiscipline", db+"|"+year+"|"+subject);
			    map.put("rangeYear", year);
			    map.put("year", year);
			    datas.add(map);
			  }
		}
		result.setDatas(datas);*/
        //return result;
    }

    @RequestMapping(value = {"/subjectJSON"}, method = {RequestMethod.GET})
    @ResponseBody
    public JSONArray subjectJSON(String db, String year, HttpServletRequest request) {
        if (StringUtils.isBlank(db) || StringUtils.isBlank(year)) {
            return JSONArray.fromObject(new String[]{});
        }
        SearchCondition condition = new SearchCondition();
        condition.setSearchComponentFlag("subject_system_search");
        condition.addQueryCdt("scDB_3_1_" + db);
        condition.addQueryCdt("scYear_3_1_" + year);
        SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
        SearchResult result = searchService.search(condition);
        List<Map<String, Object>> datas = result.getDatas();
        Collections.sort(datas, new Comparator<Map<String, Object>>() {

            @Override
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                String name1 = (String) o1.get("discipline"), name2 = (String) o2.get("discipline"), p1, p2;
                p1 = PinYinUtil.getPingYin(name1);
                p2 = PinYinUtil.getPingYin(name2);
                return p1.compareTo(p2);
            }

        });
        return JSONArray.fromObject(datas);
    }

    @RequestMapping(value = {"/subjectSystem/{page}/{authorityDb}"}, method = {RequestMethod.GET})
    public String loadSubjectSystem(@PathVariable String page, @PathVariable String authorityDb, HttpServletRequest request, HttpSession session) {
        OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
        request.setAttribute("orgFlag", org.getFlag());
        String siteFlag = org.getSiteFlag();
        request.setAttribute("siteFlag", siteFlag);
        Map<String, Set<DisciplineSystem>> disciplineSystemMap = null;
        try {
            disciplineSystemMap = cacheModule.loadDisciplineSystemFromCache();
        } catch (SystemException e) {
            logger.error("缓存数据加载失败!", e);
            return "error/error";
        }
        if (null != disciplineSystemMap) {
            request.setAttribute("disciplineSystemList", disciplineSystemMap.get(authorityDb));
        }
        return "sites/" + page;
    }

    @RequestMapping(value = {"/loadJournalLink"}, method = {RequestMethod.GET})
    public void loadJournalLink(String journalFlag, Integer type, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");
        if (type == 1) {
            List<JournalUrl> list = journalLinkService.searchDbLinks(journalFlag);
            response.getWriter().print(JsonUtil.obj2Json(list));
        } else {
            JournalUrl mainLink = journalLinkService.searchMainLink(journalFlag);
            response.getWriter().print(JsonUtil.obj2Json(mainLink));
        }
    }

}
