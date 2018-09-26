package com.wd.backend.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.model.DeliveryValidity;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;
import com.wd.backend.model.Member;
import com.wd.backend.model.News;
import com.wd.backend.model.Org;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Quota;
import com.wd.backend.model.UserRequest;
import com.wd.backend.service.ContentAnalysisServiceI;
import com.wd.backend.service.DocDeliveryManagerI;
import com.wd.backend.service.DownloadRecordManagerI;
import com.wd.backend.service.FeedbackManagerI;
import com.wd.backend.service.FlowAnalysisServiceI;
import com.wd.backend.service.MailService;
import com.wd.backend.service.MemberManagerI;
import com.wd.backend.service.NewsManagerI;
import com.wd.backend.service.OrgServiceI;
import com.wd.backend.service.SystemManageServiceI;
import com.wd.backend.service.UserRequestServiceI;
import com.wd.backend.service.VisitServiceI;
import com.wd.browse.service.AdditionServiceI;
import com.wd.comm.Comm;
import com.wd.comm.context.SystemContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.AjaxResult;
import com.wd.util.DateUtil;
import com.wd.util.FileUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;

@Controller
@RequestMapping("/backend/system")
public class SystemManageController {

    @Autowired
    private SystemManageServiceI sysService;
    @Autowired
    private CacheModuleI cacheModule;
    @Autowired
    private UserRequestServiceI userRequestService;
    @Autowired
    private MemberManagerI member;
    @Autowired
    private DocDeliveryManagerI docDeliveryService;
    @Autowired
    private MailService mailService;
    @Autowired
    private ContentAnalysisServiceI contentAnalysisService;
    @Autowired
    DownloadRecordManagerI downloadRecordManagerService;
    @Autowired
    private VisitServiceI visitService;

    @Autowired
    private OrgServiceI orgService;

    /**
     * 用户请求
     *
     * @return
     */
    @RequestMapping(value = {"/userRequest"}, method = {RequestMethod.GET})
    public String userRequest(HttpServletRequest request) {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        if (SimpleUtil.strIsNull(type)) {
            type = "-1";
        }
        if (SimpleUtil.strIsNull(keyword)) {
            keyword = null;
        }
        request.setAttribute("show", 6);
        List<UserRequest> list = userRequestService.findAll(Integer.parseInt(type), keyword);
        int count = userRequestService.findAllCount(Integer.parseInt(type), keyword);
        request.setAttribute("list", list);
        request.setAttribute("count", count);
        request.setAttribute("type", type);
        request.setAttribute("keyword", keyword);
        return "back/system/userRequest";
    }

    /**
     * 权限设置
     *
     * @return
     */
    @RequestMapping(value = {"/powers"}, method = {RequestMethod.GET})
    public String powers(HttpServletRequest request) {
        Powers powers = sysService.getPowersList();
        List<Quota> quotaList = sysService.getAllQuota();
        request.setAttribute("powers", powers);
        request.getSession().setAttribute("quotaList", quotaList);
        request.setAttribute("show", 6);
        return "back/system/powers";
    }

    /**
     * 流量指标设置
     *
     * @return
     */
    @RequestMapping(value = {"/powers/quota"}, method = {RequestMethod.GET})
    public String quota(HttpServletRequest request) {
        Pager orgQuotaPager = sysService.getOrgQuotas();
        request.setAttribute("orgQuotaPager", orgQuotaPager);
        request.setAttribute("offset", SystemContext.getOffset());
        request.setAttribute("show", 6);
        return "back/system/quota";
    }

    /**
     * 项目添加学校
     *
     * @return
     */
    @RequestMapping(value = {"/powers/add"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult add(HttpServletRequest request) {
        String id = request.getParameter("id");
        String pid = request.getParameter("pid");
        String flags = request.getParameter("flags");
        sysService.insertPermission(id, pid, flags);
        cacheModule.reloadAllOrgCache();
        String js = JsonUtil.obj2Json("1");
        return new AjaxResult(js);
    }

    /**
     * 项目删除学校
     *
     * @return
     */
    @RequestMapping(value = {"/powers/del"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult del(HttpServletRequest request) {
        String id = request.getParameter("id");
        String pid = request.getParameter("pid");
        String flag = request.getParameter("flag");
        String orgId = request.getParameter("orgId");
        sysService.deletePermission(id, pid, flag);
        if (orgId != null) {
            cacheModule.reloadOrgCache(Integer.parseInt(orgId));
        }
        String js = JsonUtil.obj2Json("1");
        return new AjaxResult(js);
    }

    /**
     * 数据管理
     *
     * @return
     */
    @RequestMapping(value = {"/dataManage"}, method = {RequestMethod.GET})
    public String dataManage() {
        return "back/system/dataManage";
    }

    /**
     * 权限设置查询结果页面
     *
     * @return
     */
    @RequestMapping(value = {"/powers/powerSerach"}, method = {RequestMethod.GET})
    public String powerSerach(HttpServletRequest request) {
        String name = request.getParameter("name");
        Map<String, Object> map = sysService.getPowersListByOrg(1, name);
        Powers powers = sysService.getPowersList();
        request.setAttribute("powers", powers);
        request.setAttribute("name", name);
        request.setAttribute("resutlmap", map);
        request.setAttribute("show", 6);
        return "back/system/powerSerach";
    }

    /**
     * 新建权限
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/powers/build"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult build(HttpServletRequest request) {
        String ids = request.getParameter("ids");
        String flag = request.getParameter("flag");
        String orgId = request.getParameter("orgId");
        String ss = "1";
        try {
            sysService.insertNewPermission(ids, flag);
            cacheModule.reloadOrgCache(Integer.parseInt(orgId));
        } catch (Exception e) {
            ss = "0";
            e.printStackTrace();
        }
        return new AjaxResult(ss);
    }

    /**
     * 应用到其他学校
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/powers/mapped"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult mapped(HttpServletRequest request) {
        String cids = request.getParameter("cids");
        String flags = request.getParameter("flags");
        String ss = "1";
        try {
            sysService.mappedPermission(cids, flags);
            cacheModule.reloadAllOrgCache();
        } catch (Exception e) {
            ss = "0";
            e.printStackTrace();
        }
        return new AjaxResult(ss);
    }

    /**
     * 添加指标权限
     *
     * @return
     */
    @RequestMapping(value = {"/powers/addQuota"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult addQuota(HttpServletRequest request) {
        String type = request.getParameter("type");
        String qids = request.getParameter("qids");
        String flag = request.getParameter("flag");
        String orgId = request.getParameter("orgId");
        sysService.addQuota(qids, flag, type);
        if ("1".equals(type)) {
            cacheModule.reloadOrgCache(Integer.parseInt(orgId));
        } else {
            cacheModule.reloadAllOrgCache();
        }
        String js = JsonUtil.obj2Json("1");
        return new AjaxResult(js);
    }

    /**
     * 删除指标权限
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delQuota"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult delQuota(HttpServletRequest request) {
        String id = request.getParameter("id");
        String orgId = request.getParameter("orgId");
        sysService.delQuota(id);
        cacheModule.reloadOrgCache(Integer.parseInt(orgId));
        String js = JsonUtil.obj2Json("1");
        return new AjaxResult(js);
    }

    /**
     * 流量指标查询结果页面
     *
     * @return
     */
    @RequestMapping(value = {"/powers/pvSerach"}, method = {RequestMethod.GET})
    public String pvSerach(HttpServletRequest request) {
        String name = request.getParameter("pvname");
        Map<String, Object> map = sysService.getschoolQuotaByName(name);
        request.setAttribute("name", name);
        request.setAttribute("resutlmap", map);
        request.setAttribute("show", 6);
        return "back/system/pvSerach";
    }

    /**
     * 文献传递请求
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delivery"}, method = {RequestMethod.GET})
    public String delivery(HttpServletRequest request) {
        String keyWord = request.getParameter("keyWord");
        Pager pager = docDeliveryService.findDeliveryValidity(keyWord);
        request.setAttribute("keyWord", keyWord);
        request.setAttribute("pager", pager);
        request.setAttribute("show", 6);
        return "back/system/delivery";
    }

    /**
     * 文献传递请求权限设置（通过邮箱找学校）
     */
    @RequestMapping(value = {"/powers/delivery/findByEmail"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult findByEmail(HttpServletRequest request, String email) {
        Member mem = member.findByEmail(email);
        String js = JsonUtil.obj2Json(mem);
        return new AjaxResult(js);
    }

    /**
     * 文献传递请求（添加）
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delivery/add"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult deliveryAdd(HttpServletRequest request, DeliveryValidity deliveryValidity) {
        Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        Date date = new Date();
        SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sp.format(date);
        deliveryValidity.setProcesorId(user.getId());
        deliveryValidity.setProcesorName(user.getUsername());
        deliveryValidity.setTime(time);
        Member mem = member.findByEmail(deliveryValidity.getEmail());
        if (mem != null) {
            deliveryValidity.setOrgFlag(mem.getSchoolFlag());
            deliveryValidity.setOrgName(mem.getSchool());
        }
        int result = docDeliveryService.addDeliveryValidity(deliveryValidity);
        if (result == 1) {
            return new AjaxResult("添加成功");
        }
        return new AjaxResult("添加失败");
    }

    /**
     * 文献传递请求（修改）
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delivery/update"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult deliveryUpdate(HttpServletRequest request, DeliveryValidity deliveryValidity) {
        Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        Date date = new Date();
        SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sp.format(date);
        deliveryValidity.setProcesorId(user.getId());
        deliveryValidity.setProcesorName(user.getUsername());
        deliveryValidity.setTime(time);
        Member mem = member.findByEmail(deliveryValidity.getEmail());
        if (mem != null) {
            deliveryValidity.setOrgFlag(mem.getSchoolFlag());
            deliveryValidity.setOrgName(mem.getSchool());
        }
        int result = docDeliveryService.updateDeliveryValidity(deliveryValidity);
        if (result == 1) {
            return new AjaxResult("修改成功");
        }
        return new AjaxResult("修改失败");
    }

    /**
     * 文献传递请求（删除）
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delivery/delete"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult deliveryDelete(HttpServletRequest request, int id) {
        docDeliveryService.deleteDeliveryValidity(id);
        return new AjaxResult("");
    }

    /**
     * 文献传递请求（发送邮件）
     *
     * @return
     */
    @RequestMapping(value = {"/powers/delivery/sendEmail"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult deliverySendEmail(HttpServletRequest request) {
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        try {
            mailService.send(email, subject, content, null);
        } catch (Exception e) {
            return new AjaxResult("邮件发送失败");
        }
        return new AjaxResult("邮件已发送");
    }


    /**
     * 内容发布
     */
    @Autowired
    private NewsManagerI newsService;

    @RequestMapping(value = {"/list"}, method = {RequestMethod.GET})
    public String list(String type, String key, HttpServletRequest request) {
        request.setAttribute("show", 6);
        Pager pager = newsService.search(key, type);
        request.setAttribute("data", pager);
        request.setAttribute("type", type);
        return "back/system/list";
    }

    /**
     * 控制显示隐藏，已取消
     */
    @RequestMapping(value = {"/list/varify/{id}/{isShow}"}, method = {RequestMethod.GET})
    public String varify(@PathVariable Integer id, @PathVariable Integer isShow, HttpServletRequest request) {
        newsService.verify(id, isShow);
        request.setAttribute("msg", "设置成功");
        request.setAttribute("location", "backend/news/list");
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/system/list";
//		return "backend/success";
    }

    /**
     * 添加
     */
    @RequestMapping(value = {"/list/add"}, method = {RequestMethod.GET})
    public String addNew(HttpServletRequest request) {
        request.setAttribute("method", "add");
        return "back/system/edit";
    }

    /**
     * 添加
     */
    @RequestMapping(value = {"/list/add"}, method = {RequestMethod.POST})
    public String addNew(News news, HttpServletRequest request) {
        Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
//		Person p = (Person) request.getSession().getAttribute("person");
        news.setPublishers(p.getId() + "");
        newsService.add(news);
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/system/list";
    }

    /**
     * 修改
     */
    @RequestMapping(value = {"/list/edit/{newsId}"}, method = {RequestMethod.GET})
    public String edit(@PathVariable Integer newsId, HttpServletRequest request) {
        News news = newsService.detail(newsId);
        request.setAttribute("news", news);
        request.setAttribute("method", "edit");
        return "back/system/edit";
    }

    /**
     * 修改
     */
    @RequestMapping(value = {"/list/edit"}, method = {RequestMethod.POST})
    public String edit(News news, HttpServletRequest request) {
        newsService.update(news);
        request.setAttribute("msg", "更新公告成功");
        request.setAttribute("location", "backend/news/list");
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/system/list";
//		return "backend/success";
    }

    /**
     * 编辑插件图片上传
     *
     * @param file
     * @param request
     * @param response
     * @throws FileUploadException
     * @throws IOException
     */
    @RequestMapping(value = {"/list/img"}, method = {RequestMethod.POST})
    public void img(@RequestParam(value = "imgFile", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws FileUploadException, IOException {
        //文件保存目录路径
        String savePath = FileUtil.getSysUserHome(), dailyPath = FileUtil.getDailyPath();
        savePath += dailyPath;
        FileUtil.createDir(new File(savePath));//创建目录
        String fileName = file.getOriginalFilename();
        savePath = savePath + fileName;
//		byte[] aa = file.getBytes();
        File savefile = new File(savePath);
//		List results = new ArrayList();
        try {
            FileCopyUtils.copy(file.getBytes(), savefile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //       results.add(savePath);
        String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/" + "upload/" + dailyPath + "/" + fileName;
        JSONObject obj = new JSONObject();
        obj.put("error", 0);
        obj.put("url", url);
        response.getWriter().write(obj.toString());
    }

    /**
     * 删除
     */
    @RequestMapping(value = {"/list/delete/{newsId}"}, method = {RequestMethod.GET})
    public String delete(@PathVariable Integer newsId) {
        newsService.delete(newsId);
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/system/list";
    }


    @Autowired
    private FeedbackManagerI manager;

    @RequestMapping(value = {"/feedback"}, method = {RequestMethod.GET})
    public String list(String isProcess, HttpServletRequest request) {
        request.setAttribute("show", 6);
        Map<String, Object> params = new HashMap<String, Object>();
        if ("-1".equals(isProcess)) {
            isProcess = null;
        }
        params.put("isProcess", isProcess);
        Pager p = manager.findPager(params);
        List<Feedback> list = new ArrayList<Feedback>();
        for (int i = 0; i < p.getRows().size(); i++) {
            Feedback feedback = (Feedback) p.getRows().get(i);
            Member user = member.getById(feedback.getMemberId());
            feedback.setMemberName(user.getUsername());
            list.add(feedback);
        }
        p.setRows(list);
        request.setAttribute("isProcess", isProcess);
        request.setAttribute("data", p);
        return "back/system/feedback";
    }

    /**
     * 后台ajax获取反馈详细
     *
     * @return
     */
    @RequestMapping(value = {"/feedback/{id}"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult findFeedback(@PathVariable Integer id, HttpServletRequest request) {
        //List<FeedbackInfo> list=manager.findListInfo(id);
        Feedback feedback = manager.getById(id);
        Member user = member.getById(feedback.getMemberId());
        feedback.setMemberName(user.getUsername());
        String result = JsonUtil.obj2Json(feedback);
        return new AjaxResult(result);
    }
	
/*	@RequestMapping(value = { "/feedback/answer/{id}" }, method = { RequestMethod.GET })
	public String answer(@PathVariable Integer id,HttpServletRequest request){
		request.setAttribute("show",6);
		request.setAttribute("feedback", manager.get(id));
		return "back/system/answer";
	}*/

    @RequestMapping(value = {"/feedback/answer"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult answer(Feedback feedback, HttpServletRequest request) {
        FeedbackInfo feedbackInfo = new FeedbackInfo();
        String content = request.getParameter("content");
        Date time = new Date();

        feedback.setTime(time);
        feedback.setIsProcess((short) 1);
        manager.updateTime(feedback);

        feedbackInfo.setContent(content);
        feedbackInfo.setFeedbackId(feedback.getId());
        feedbackInfo.setTime(time);
        feedbackInfo.setType(2);
        manager.saveInfo(feedbackInfo);

        //request.setAttribute("msg", "回复成功");
        //request.setAttribute("location", "backend/system/feedback");
//		manager.answer(feedback);
        String result = JsonUtil.obj2Json(feedbackInfo);
        return new AjaxResult(1, result);
    }

    @RequestMapping(value = {"/apply"}, method = {RequestMethod.GET})
    public String apply(HttpServletRequest request) {
        request.setAttribute("show", 6);
        String key = request.getParameter("key");
        String permission = request.getParameter("permission");
        if ("-1".equals(permission) || "".equals(permission)) {
            permission = null;
        }
        if ("".equals(key)) {
            key = null;
        }
        Map<String, Object> params = new HashMap<String, Object>();
        if (key != null) {
            params.put("key", "%" + key + "%");
        }
        params.put("permission", permission);
        Pager pager = member.findPagerByApply(params);
        request.setAttribute("data", pager);
        request.setAttribute("permissions", permission);
        return "back/system/apply";
    }

    /**
     * 校外登录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/apply"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult applyManage(HttpServletRequest request) {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String permission = request.getParameter("permission");
        Date date = new Date();
        Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        Member members = member.getById(Integer.parseInt(id));
        members.setPermission(Integer.parseInt(permission));
        members.setHandleTime(date);
        members.setApplyTime(date);
        members.setHandlePeople(user.getUsername());
        if (permission != null && !"".equals(permission) && Integer.parseInt(permission) == 4) {
            Calendar c = Calendar.getInstance();
            c.setTime(date);
            c.add(Calendar.MONTH, 6);
            members.setLifespan(c.getTime());
        }
        member.applyLogin(members);
        try {
            //if(permission != null && !"".equals(permission) && Integer.parseInt(permission) == 3) {
            //	mailService.send(member.getEmail(), "校外登录申请回馈", "您好，您提交的校外访问申请已经审核通过", null);
            //} else {
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");
            mailService.send(email, subject, content, null);
            //	}
        } catch (Exception e) {
            return new AjaxResult("邮件发送失败");
        }
        return new AjaxResult("邮件已成功发送");
    }

    /**
     * 查看图片
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/apply/photo"}, method = {RequestMethod.GET})
    public String photo(HttpServletRequest request) {
        String id = request.getParameter("id");
        Member user = member.getById(Integer.parseInt(id));
        request.setAttribute("user", user);
        return "back/system/photo";
    }

    /**
     * 数据添加功能（获取原始数据）关键词
     *
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis"}, method = {RequestMethod.GET})
    public String contentAnalysis(HttpServletRequest request) {
        String browseHandId = request.getParameter("browseHandId");
        if (browseHandId == null) {
            return UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/system/contentAnalysis/browseHand";
        }
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        Map<String, Object> browseHandMap = additionService.getAddBrowseHandById(browseHandId, null);
        String orgFlag = browseHandMap.get("orgFlag").toString();
        if (StringUtils.isEmpty(beginTime)) {
            beginTime = browseHandMap.get("beginTime").toString();
        }
        if (StringUtils.isEmpty(endTime)) {
            endTime = browseHandMap.get("endTime").toString();
        }
//		String beginTime = browseHandMap.get("beginTime").toString();
//		String endTime = browseHandMap.get("endTime").toString();

        String journalType = request.getParameter("journalType");
        String size = request.getParameter("size");
        if (StringUtils.isEmpty(journalType)) {
            journalType = "1";
        }
        if (StringUtils.isEmpty(size)) {
            size = "20";
        }
        List<Map<String, Object>> list = contentAnalysisService.getJournalKeyWord(orgFlag, beginTime, endTime, 0, journalType, size);
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> log = contentAnalysisService.getLog(orgFlag, list.get(i).get("keyword").toString());
            if (log != null) {
                list.get(i).put("username", log.get("username"));
                list.get(i).put("time", log.get("time"));
            }
        }
        Pager logPager = contentAnalysisService.getLogList(orgFlag, journalType);
        OrgBO org = orgService.findOrgByFlag(orgFlag);
        for (int i = 0; i < org.getProductList().size(); i++) {
            String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
            int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
            if (dayNum > 0) {
                request.setAttribute("registerEndDate", "至今");
                break;
            } else {                                                //到期
                request.setAttribute("registerEndDate", endDate);
            }
        }
        request.setAttribute("type", browseHandMap.get("type"));
        request.setAttribute("browseHandId", browseHandId);
        request.setAttribute("org", org);
        request.setAttribute("list", list);
        request.setAttribute("data", logPager);
        request.setAttribute("orgFlag", orgFlag);
        request.setAttribute("beginTime", beginTime.substring(0, 10));
        request.setAttribute("endTime", endTime.substring(0, 10));
        request.setAttribute("journalType", journalType);
        request.setAttribute("size", size);
        return "back/system/contentAnalysis";
    }

    /**
     * 手动添加期刊文章统计
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/add"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult addContentAnalysis(HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String orgFlag = request.getParameter("orgFlag");
        String browseHandId = request.getParameter("browseHandId");
        String journalType = request.getParameter("journalType");
        String[] keywords = request.getParameterValues("keyword");
        String[] addNum = request.getParameterValues("addNum");
        String[] urls = request.getParameterValues("url");
        Map<String, Object> browseHandMap = additionService.getAddBrowseHandById(browseHandId, null);
        String beginTime = browseHandMap.get("beginTime").toString().substring(0, 10);
        String endTime = browseHandMap.get("endTime").toString().substring(0, 10);
        String orgName = browseHandMap.get("orgName").toString();
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("orgFlag", orgFlag);
        params.put("orgName", orgName);
        params.put("beginTime", beginTime);
        params.put("endTime", endTime);
        params.put("browseHandId", browseHandId);
        params.put("journalType", journalType);
        params.put("keywords", keywords);
        params.put("addNum", addNum);
        params.put("urls", urls);
        contentAnalysisService.addContentAnalysis(params, member.getUsername());
        request.setAttribute("journalType", journalType);
        return new AjaxResult("已添加!");
    }

    /**
     * 数据添加功能（获取原始数据）下载统计
     *
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/downloadRecord"}, method = {RequestMethod.GET})
    public String downloadRecord(HttpServletRequest request) {
        String orgFlag = request.getParameter("orgFlag");

        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String size = request.getParameter("size");
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        if (StringUtils.isEmpty(size)) {
            size = "20";
        }
        if (!StringUtils.isEmpty(orgFlag)) {
            OrgBO org = orgService.findOrgByFlag(orgFlag);
            for (int i = 0; i < org.getProductList().size(); i++) {
                String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
                int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
                if (dayNum > 0) {
                    request.setAttribute("registerEndDate", "至今");
                    break;
                } else {                                                //到期
                    request.setAttribute("registerEndDate", endDate.substring(0, 10));
                }
            }
            request.setAttribute("org", org);
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", org.getName());
        } else {
            orgFlag = null;
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", "全部学校");
        }
        List<Map<String, Object>> list = downloadRecordManagerService.getDownLoadRecordTitle(orgFlag, beginTime, endTime, size);
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> log = downloadRecordManagerService.getLog(orgFlag, list.get(i).get("title").toString());
            if (log != null) {
                list.get(i).put("username", log.get("username"));
                list.get(i).put("time", log.get("time"));
            }
        }
        Pager logPager = downloadRecordManagerService.getLogList(orgFlag);
        request.setAttribute("list", list);
        request.setAttribute("data", logPager);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        request.setAttribute("size", size);
        return "back/system/downloadRecord";
    }

    @RequestMapping(value = {"/contentAnalysis/downloadRecord/add"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult addDownloadRecord(HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String orgFlag = request.getParameter("orgFlag");
        String orgName = request.getParameter("orgName");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String[] titles = request.getParameterValues("title");
        String[] addNum = request.getParameterValues("addNum");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("orgFlag", orgFlag);
        params.put("orgName", orgName);
        params.put("beginTime", beginTime);
        params.put("endTime", endTime);
        params.put("beginTime", beginTime);
        params.put("titles", titles);
        params.put("addNum", addNum);
        downloadRecordManagerService.addDownloadInfo(params, member.getUsername());
        request.setAttribute("orgFlag", orgFlag);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        return new AjaxResult("success");
    }

    /**
     * 数据添加功能（获取原始数据）文献传递
     *
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/deliveryRecord"}, method = {RequestMethod.GET})
    public String deliveryRecord(HttpServletRequest request) {
        String orgFlag = request.getParameter("orgFlag");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String size = request.getParameter("size");
        if (StringUtils.isEmpty(orgFlag)) {
            orgFlag = "wdkj";
        }
        request.setAttribute("orgFlag", orgFlag);
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        if (StringUtils.isEmpty(size)) {
            size = "20";
        }
        List<Map<String, Object>> list = docDeliveryService.getDeliveryRecordTitle(orgFlag, beginTime, endTime, size);
        OrgBO org = orgService.findOrgByFlag(orgFlag);
        for (int i = 0; i < org.getProductList().size(); i++) {
            String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
            int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
            if (dayNum > 0) {
                request.setAttribute("registerEndDate", "至今");
                break;
            } else {                                                //到期
                request.setAttribute("registerEndDate", endDate.substring(0, 10));
            }
        }
        request.setAttribute("org", org);
        request.setAttribute("list", list);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        request.setAttribute("size", size);
        return "back/system/deliveryRecord";
    }


    @Autowired
    public AdditionServiceI additionService;
    @Autowired
    private FlowAnalysisServiceI flowAnalysisService;
    static String[] pageRatioName = {"1", "2-10", "11-20", "21-30"};
    static String[] timeRatioName = {"00:00:00—06:00:00", "06:00:00—12:00:00", "12:00:00—18:00:00", "18:00:00—24:00:00"};
    static String[] monthRatioName = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};

    /**
     * 自动添加pv记录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/browseAutomatic"}, method = {RequestMethod.GET})
    public String browseAutomatic(HttpServletRequest request) {
        String orgFlag = request.getParameter("orgFlag");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        Map<String, Object> automaticMap = null;
        if (!StringUtils.isEmpty(orgFlag)) {
            automaticMap = additionService.getAddBrowseAutomatic(orgFlag);
        } else {
            orgFlag = null;
        }
        Map<String, Object> map = flowAnalysisService.avgPV(orgFlag, beginTime, endTime);    //原始日均PV
        List<Map<String, Object>> list = visitService.getNewOld("-1", orgFlag, beginTime, endTime);//原始新老访客比例
        for (Map<String, Object> it : list) {
            if ((long) it.get("memberType") == 0) {
                map.put("newOld", it.get("proportion"));
            }
        }
        Pager logPager = additionService.getContentAnalysisLog(orgFlag, "数据自动添加");
        String[] pageRatios = "0,25,50,25".split(",");
        String[] timeRatios = "10,30,30,30".split(",");
        String[] monthRatios = {"100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"};
        if (automaticMap != null) {
            String pageRatio = (String) automaticMap.get("pageRatio");
            pageRatios = pageRatio.split(",");
            String timeRatio = (String) automaticMap.get("timeRatio");
            timeRatios = timeRatio.split(",");
            String monthRatio = (String) automaticMap.get("monthRatio");
            monthRatios = monthRatio.split(",");
        } else {
            automaticMap = new HashMap<String, Object>();
        }
        List<Map<String, Object>> pageRatioList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < 4; i++) {
            Map<String, Object> pageRatioMap = new HashMap<String, Object>();
            pageRatioMap.put("name", pageRatioName[i]);
            pageRatioMap.put("oldRatio", 0);
            pageRatioMap.put("ratio", pageRatios[i]);
            pageRatioList.add(pageRatioMap);
        }
        List<Map<String, Object>> timeRatioList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < 4; i++) {
            Map<String, Object> timeRatioMap = new HashMap<String, Object>();
            timeRatioMap.put("name", timeRatioName[i]);
            timeRatioMap.put("ratio", timeRatios[i]);
            timeRatioList.add(timeRatioMap);
        }
        List<Map<String, Object>> monthRatioList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < 12; i++) {
            Map<String, Object> monthRatioMap = new HashMap<String, Object>();
            monthRatioMap.put("name", monthRatioName[i]);
            monthRatioMap.put("ratio", monthRatios[i]);
            monthRatioList.add(monthRatioMap);
        }
        automaticMap.put("pageRatioList", pageRatioList);
        automaticMap.put("timeRatioList", timeRatioList);
        automaticMap.put("monthRatioList", monthRatioList);
        if (!StringUtils.isEmpty(orgFlag)) {
            OrgBO org = orgService.findOrgByFlag(orgFlag);
            for (int i = 0; i < org.getProductList().size(); i++) {
                String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
                int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
                if (dayNum > 0) {
                    request.setAttribute("registerEndDate", "至今");
                    break;
                } else {                                                //到期
                    request.setAttribute("registerEndDate", endDate.substring(0, 10));
                }
            }
            request.setAttribute("org", org);
            request.setAttribute("orgName", org.getName());
            request.setAttribute("orgFlag", orgFlag);
        } else {
            request.setAttribute("orgName", "全部学校");
            request.setAttribute("orgFlag", null);
        }
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        request.setAttribute("data", logPager);
        request.setAttribute("map", map);
        request.setAttribute("automaticMap", automaticMap);

        return "back/system/browseAutomatic";
    }

    @RequestMapping(value = {"/contentAnalysis/browseAutomatic/add"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult insertAddBrowseAutomatic(HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String id = request.getParameter("id");
        String orgFlag = request.getParameter("orgFlag");
        String orgName = request.getParameter("orgName");
        String minPvint = request.getParameter("minPv");
        String maxPvint = request.getParameter("maxPv");
        String minPvWaveint = request.getParameter("minPvWave");
        String maxPvWaveint = request.getParameter("maxPvWave");
        String pvRatio = request.getParameter("pvRatio");
        String avgTime = request.getParameter("avgTime");
        String pageRatio = request.getParameter("pageRatio");
        String timeRatio = request.getParameter("timeRatio");
        String monthRatio = request.getParameter("monthRatio");
        String newOld = request.getParameter("newOld");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        params.put("orgFlag", orgFlag);
        params.put("orgName", orgName);
        params.put("minPv", minPvint);
        params.put("maxPv", maxPvint);
        params.put("minPvWave", minPvWaveint);
        params.put("maxPvWave", maxPvWaveint);
        params.put("pvRatio", pvRatio);
        params.put("avgTime", Integer.parseInt(avgTime));
        params.put("pageRatio", pageRatio);
        params.put("timeRatio", timeRatio);
        params.put("monthRatio", monthRatio);
        params.put("newOld", newOld);
        params.put("username", member.getUsername());

        Org org = orgService.findOrgByFlag(orgFlag);
        params.put("province", org.getProvince());
        additionService.insertAddBrowseAutomatic(params);
        return new AjaxResult("success");
    }

    /**
     * 手动添加pv记录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/browseHand"}, method = {RequestMethod.GET})
    public String browseHand(HttpServletRequest request) {
        String orgFlag = request.getParameter("orgFlag");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        if (!StringUtils.isEmpty(orgFlag)) {
            OrgBO org = orgService.findOrgByFlag(orgFlag);
            for (int i = 0; i < org.getProductList().size(); i++) {
                String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
                int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
                if (dayNum > 0) {
                    request.setAttribute("registerEndDate", "至今");
                    break;
                } else {                                                //到期
                    request.setAttribute("registerEndDate", endDate.substring(0, 10));
                }
            }
            request.setAttribute("org", org);
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", org.getName());
        } else {
            orgFlag = null;
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", "全部学校");
        }
        Map<String, Object> map = flowAnalysisService.avgPV(orgFlag, beginTime, endTime);
        List<Map<String, Object>> list = visitService.getNewOld("-1", orgFlag, beginTime, endTime);//原始新老访客比例
        for (Map<String, Object> it : list) {
            if ((long) it.get("memberType") == 0) {
                map.put("newOld", it.get("proportion"));
            }
        }
        Pager page = additionService.getAddBrowseInfo(orgFlag);
        request.setAttribute("map", map);
        request.setAttribute("data", page);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        return "back/system/browseHand";
    }

    @RequestMapping(value = {"/contentAnalysis/browseHand/add"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult insertAddBrowseHand(HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String orgFlag = request.getParameter("orgFlag");
        String orgName = request.getParameter("orgName");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String pv = request.getParameter("pv");
        String avgTime = request.getParameter("avgTime");
        String pageRatio = request.getParameter("pageRatio");
        String timeRatio = request.getParameter("timeRatio");
        String newOld = request.getParameter("newOld");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("orgFlag", orgFlag);
        params.put("orgName", orgName);
        params.put("beginTime", beginTime);
        params.put("endTime", endTime);
        params.put("pv", Integer.parseInt(pv));
        params.put("avgTime", Integer.parseInt(avgTime));
        params.put("pageRatio", pageRatio);
        params.put("timeRatio", timeRatio);
        params.put("newOld", newOld);
        params.put("type", 0);
        Org org = orgService.findOrgByFlag(orgFlag);
        params.put("province", org.getProvince());
        params.put("username", member.getUsername());
        Integer id = additionService.insertAddBrowseHand(params);
        return new AjaxResult(id.toString());
    }

    @RequestMapping(value = {"/contentAnalysis/browseHand/start"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult browseHandStart(HttpServletRequest request) {
        String browseHandId = request.getParameter("browseHandId");
        additionService.browseHandStart(Integer.parseInt(browseHandId));
//		browseAddTask.executeHand(Integer.parseInt(browseHandId));
        return new AjaxResult("已启动！正在处理...");
    }


    /**
     * 数据添加功能  学校用户统计
     *
     * @return
     */
    @RequestMapping(value = {"/contentAnalysis/userRecord"}, method = {RequestMethod.GET})
    public String userRecord(HttpServletRequest request) {
        String orgFlag = request.getParameter("orgFlag");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String size = request.getParameter("size");
//		if(StringUtils.isEmpty(orgFlag)) orgFlag="wdkj";
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        if (StringUtils.isEmpty(size)) {
            size = "20";
        }
        if (!StringUtils.isEmpty(orgFlag)) {
            OrgBO org = orgService.findOrgByFlag(orgFlag);
            for (int i = 0; i < org.getProductList().size(); i++) {
                String endDate = DateUtil.format(org.getProductList().get(i).getEndDate());
                int dayNum = DateUtil.getDayNum(endDate, DateUtil.format(new Date()));  //计算学校产品到期时间和当前时间的时间差
                if (dayNum > 0) {
                    request.setAttribute("registerEndDate", "至今");
                    break;
                } else {                                                //到期
                    request.setAttribute("registerEndDate", endDate.substring(0, 10));
                }
            }
            request.setAttribute("org", org);
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", org.getName());
        } else {
            orgFlag = null;
            request.setAttribute("orgFlag", orgFlag);
            request.setAttribute("orgName", "全部学校");
        }
        Map<String, Object> map = member.findTouristCount(orgFlag, beginTime, endTime);
        Pager logPager = member.getLogList(orgFlag);
        List<Map<String, Object>> result = logPager.getRows();
        for (Map<String, Object> log : result) {
            if (log.get("name").toString().contains("增加游客数") && !map.containsKey("touristUsername")) {
                map.put("touristUsername", log.get("username"));
                map.put("touristTime", log.get("time"));
            }
            if (log.get("name").toString().contains("增加登陆次数") && !map.containsKey("loginAddUsername")) {
                map.put("loginAddUsername", log.get("username"));
                map.put("loginAddTime", log.get("time"));
            }
        }
        request.setAttribute("map", map);
        request.setAttribute("data", logPager);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime.substring(0, 10));
        request.setAttribute("size", size);
        return "back/system/userRecord";
    }

    @RequestMapping(value = {"/contentAnalysis/userRecord/add"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult addUserRecord(HttpServletRequest request) {
        Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String orgFlag = request.getParameter("orgFlag");
        String orgName = request.getParameter("orgName");
        String loginCount = request.getParameter("loginCount");
        String touristCount = request.getParameter("touristCount");
        String time = request.getParameter("time");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        beginTime = DateUtil.handleBeginTime(beginTime);
        endTime = DateUtil.handleEndTime(endTime);
        Map<String, Object> param = new HashMap<>();
        param.put("orgFlag", orgFlag);
        param.put("orgName", orgName);
        param.put("loginCount", loginCount);
        param.put("touristCount", touristCount);
        param.put("time", time);
        param.put("beginTime", beginTime);
        param.put("endTime", endTime);
        member.addUserRecord(param, user.getUsername());
        return new AjaxResult("success");
    }
}
