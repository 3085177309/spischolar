package com.wd.front.listener;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.mail.Flags.Flag;
import javax.servlet.http.*;

import com.wd.util.LoginUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.ChickPage;
import com.wd.backend.model.Member;
import com.wd.backend.model.Person;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.interceptor.LoginInterceptor;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.BrowseServiceI;
import com.wd.front.service.OperationException;
import com.wd.front.service.UserServiceI;
import com.wd.front.service.impl.UserServiceImpl;
import com.wd.util.BrowseInfoUtil;
import com.wd.util.DateUtil;
import com.wd.util.SpringContextUtil;

public class SessionListener implements HttpSessionListener {
	private static final Logger logger=Logger.getLogger(SessionListener.class);
	
	@Autowired
	private CacheModuleI cacheModule;
	
	@Autowired
	private BrowseInfoUtil browseInfoUtil;
	@Override
	public void sessionCreated(HttpSessionEvent se) {

        logger.info("创建session:" + se.getSession().getId());
        SessionListener.addSession(se.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        UserServiceI userService = SpringContextUtil.getBean(UserServiceI.class);
        //后台用户
        Member user = (Member) se.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        String isMobile = (String) se.getSession().getAttribute("isMobile");
        if (user != null) {
            logger.info(user.getUsername() + ":session销毁,sessionId:" + se.getSession().getId());
        }
        try {
            //insertBrowse(se,user);
            insertBrowseToEs(se, user);
            SessionListener.delSession(se.getSession());//先将mymap中的这个session移除
            Iterator it = mymap.entrySet().iterator(); //遍历mymap
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                String key = (String) entry.getKey();
                HttpSession val = (HttpSession) entry.getValue();
                Member mem = (Member) val.getAttribute(Comm.MEMBER_SESSION_NAME);
                String isMobiles = (String) val.getAttribute("isMobile");
                if (user != null && mem != null) {  //如果mymap中还有和当前session相同的用户，则不需要修改登录状态
                    if (mem.getUsername().equals(user.getUsername()) && isMobile.equals(isMobiles)) {
                        logger.info("存在相同user，退出：" + mem.getUsername());
                        return;        //因为关闭浏览器在重新打开访问，会产生两个相同的MEMBER_SESSION_NAME
                    }
                }
            }
        } catch (Exception e) {
            logger.warn("session可能已销毁");
        }
        if (user != null) {
            user = userService.detail(user.getId());
            int isOnline = 0;
            if (user.getIsOnline() == 3 && Comm.Mobile.equals(isMobile)) {
                isOnline = 1;
            } else if (user.getIsOnline() == 3 && !Comm.Mobile.equals(isMobile)) {
                isOnline = 2;
            }
            user.setIsOnline(isOnline);
            userService.updateLogin(user);
            delSessionMap(se.getSession(), user.getId().toString());
        }
    }

    private static Map<String, HttpSession> mymap = new HashMap();

    public static synchronized void addSession(HttpSession session) {
        if (session != null) {
            mymap.put(session.getId(), session);
        }
    }

    public static synchronized void delSession(HttpSession session) {
        if (session != null) {
            mymap.remove(session.getId());
            logger.info("mymap中session移除"+session.getId());
        }
    }

    public static synchronized HttpSession getSession(String session_id) {
        if (session_id == null) {
            return null;
        }
        return mymap.get(session_id);
    }
    
    //记录登陆用户
    private static Map<String, HttpSession> sessionMap = new HashMap();

    /**
     * 记录登陆用户
     * @param session
     * @param memberId
     */
    public static synchronized void addSessionMap(HttpSession session,String memberId) {
    	String isMobile = (String) session.getAttribute("isMobile");
        if (session != null) {
        	sessionMap.put(memberId+isMobile, session);
        }
    }
    public static synchronized void delSessionMap(HttpSession session,String memberId) {
    	String isMobile = (String) session.getAttribute("isMobile");
        sessionMap.remove(memberId+isMobile);
    }
    /**
     * 相同账号强制下线
     */
    public static synchronized void imposedOut(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String memberId) {
        String isMobile = (String) session.getAttribute("isMobile");
        HttpSession imposedOutSession = (HttpSession) sessionMap.get(memberId + isMobile);
        if (imposedOutSession != null && !session.getId().equals(imposedOutSession.getId())) {
            try {
                imposedOutSession.setAttribute("imposedOut", "挤出登陆");
                imposedOutSession.removeAttribute(Comm.ORG_SESSION_NAME);
                imposedOutSession.removeAttribute(Comm.ORG_FLAG_NAME);
                imposedOutSession.removeAttribute("org");
                imposedOutSession.removeAttribute(Comm.MEMBER_SESSION_NAME);
                imposedOutSession.removeAttribute("spischolarID");
                Map<String, String> cookies = new HashMap<String, String>();
                cookies.put("thisId", session.getId());
                cookies.put("username", null);
                cookies.put("password", null);
                LoginUtil.creatCookie(cookies,req,resp,0);
    		}catch(Exception e) {
    			
    		}
    	}
    }
    
 //   ,"/user/register","/user/register/success","/user/logout"
 //   ,"注册","注册成功","主动退出登录"
    String[] urls = {".*/scholar",".*/journal",".*/scholar/list.*",     ".*/scholar/redirect.*",".*/scholar/journalList.*",    ".*/journal/category/list.*",".*/journal/search/list.*",".*/journal/detail.*"      ,".*/user/logout" ,".*/user/avatar",".*/user/profile",".*/user/applyLogin",".*/user/security",".*/user/history.*",".*/user/deleteHistory.*",".*/user/dilivery.*",".*/user/dilivery/.*",".*/user/dilivery/download/.*",".*/user/favorite.*",".*/user/unfavorite/.*",".*/user/favorite/.*",".*/user/feedbacks.*",".*/user/feedback.*",".*/user/feedback/.*",".*/journal/subject/[1-6]/1/.*",".*/journal/subject/[1-6]/8/.*",".*/journal/subject/[1-6]/10/.*",".*/journal/subject/[1-6]/9/.*",".*/journal/subject/[1-6]/4/.*",".*/journal/subject/[1-6]/6/.*",".*/journal/subject/[1-6]/7/.*",".*/journal/subject/[1-6]/2/.*",".*/journal/subject/[1-6]/3/.*",".*/journal/subject/[1-6]/5/.*"};
	String[] page = {"蛛网学术搜索首页","学术期刊指南首页","蛛网学术搜索结果列表",   "学术文章详情","期刊最新文章",    "学术期刊指南浏览列表","学术期刊指南检索列表","期刊详细页面"       ,"主动退出登录" ,"头像设置","个人基本信息","校外登录申请","重置密码","检索历史","删除检索历史","查看文献传递记录","申请文献传递","文献传递下载","查看收藏记录","取消收藏","添加收藏","我的反馈","提交反馈","反馈详情","学科分类:SCI-E","学科分类:SSCI","学科分类:ESI","学科分类:SCOPUS","学科分类:CSCD","学科分类:CSSCI","学科分类:北大核心","学科分类:中科院JCR分区(大类)","学科分类:中科院JCR分区(小类)","学科分类:Eigenfactor"};
	
	
	
	
	 /**
     * 保存用户访问记录信息
     * @param se
     * @param user
     * @throws SystemException 
     */
    public void insertBrowseToEs(HttpSessionEvent se,Member user) throws SystemException {
    	BrowseServiceI browseService = SpringContextUtil.getBean(BrowseServiceI.class);
    	UserServiceI userService = SpringContextUtil.getBean(UserServiceI.class);
    	BrowseCount browseCount = (BrowseCount) se.getSession().getAttribute("browseInformation");
		String id = (String) se.getSession().getAttribute("spischolarID");
		OrgBO org = (OrgBO) se.getSession().getAttribute(Comm.ORG_SESSION_NAME);
		
		List<String> previousUrlList = (List<String>) se.getSession().getAttribute("previousUrlList");
		List<String> urlList = (List<String>) se.getSession().getAttribute("urlList");
		int pageNum = 0;
		String pageName = null;
		List<ChickPage> chickPageList = new ArrayList<ChickPage>();
		if(urlList == null) {
			return;
		}
		//上一页
		List previousUrlName = new ArrayList();
		for(int i=0; i<previousUrlList.size(); i++) {
			String previousUrl = previousUrlList.get(i);
			if("http://test.spischolar.com/".equals(previousUrl) || "http://192.168.1.107:8888/journal/".equals(previousUrl) || "http://localhost:8888/journal/".equals(previousUrl) || "http://www.spischolar.com/".equals(previousUrl)) {
				pageName = "首页";
				previousUrlName.add(pageName);
				continue;
			}
			for(int j=urls.length; j > 0; j--) {//&& !previousUrl.contains("/journal/subject/")
				if(previousUrl.matches(urls[j-1])  && !previousUrl.contains("/journal/subjectJSON") && !previousUrl.contains("/journal/image")) {
					pageName = page[j-1];
					previousUrlName.add(pageName);
					break;
				}
				if(j == 1) {
                    previousUrlName.add(previousUrl);
                }
			}
		}
 		for(int i=0; i<urlList.size(); i++) {
			String url = urlList.get(i);
			String beginTime = url.substring(url.indexOf("begin=")+6);
			url = url.substring(0,url.indexOf("begin="));
			String lastTime =  null;
			if(i < urlList.size()-1){
				lastTime = urlList.get(i+1).substring(urlList.get(i+1).indexOf("begin=")+6);
			} else {
				lastTime = beginTime;
			}
			ChickPage chickPage = new ChickPage();
			chickPage.setPreviousPage((String) previousUrlName.get(i));
			chickPage.setBeginTime(beginTime);
			chickPage.setLastTime(lastTime);
			chickPage.setTime(DateUtil.getTimeNum(chickPage.getLastTime(),chickPage.getBeginTime()));
			
			if("http://test.spischolar.com/".equals(url) || "http://192.168.1.107:8888/journal/".equals(url) || "http://localhost:8888/journal/".equals(url) || "http://www.spischolar.com/".equals(url)) {
				pageName = "首页";
				chickPage.setUrl(url);
				chickPage.setPageName(pageName);
				
				String keyWord = null;
				if(url.contains("val=")) {
					keyWord = url.substring(url.indexOf("val=")+4);
				}
				if(url.contains("value=")) {
					keyWord = url.substring(url.indexOf("value=")+6);
				}
				if(keyWord != null && keyWord.contains("&")) {
					keyWord = keyWord.substring(0,keyWord.indexOf("&"));
				}
				chickPage.setKeyWord(keyWord);
				
				pageNum++;
				chickPageList.add(chickPage);
				logger.info("pageNum:"+pageNum);
				logger.info("pageName:"+pageName);
				logger.info("url:"+url);
				logger.info("chickPageList:"+chickPageList.size());
				continue;
			}
			for(int j=urls.length; j > 0; j--) {//&& !url.contains("/journal/subject/")
				if(url.matches(urls[j-1])  && !url.contains("/journal/subjectJSON") && !url.contains("/journal/image")) {
					pageName = page[j-1];
					chickPage.setUrl(url);
					chickPage.setPageName(pageName);
					String keyWord = null;
					if(url.contains("val=")) {
						keyWord = url.substring(url.indexOf("val=")+4);
					}
					if(url.contains("value=")) {
						keyWord = url.substring(url.indexOf("value=")+6);
					}
					if(keyWord != null && keyWord.contains("&")) {
						keyWord = keyWord.substring(0,keyWord.indexOf("&"));
					}
					chickPage.setKeyWord(keyWord);
					
					pageNum++;
					chickPageList.add(chickPage);
					logger.info("pageNum:"+pageNum);
					logger.info("pageName:"+pageName);
					logger.info("url:"+url);
					logger.info("chickPageList:"+chickPageList.size());
					break;
				}
			}
		}
		//获得本次访问的浏览量
 		String lastTime = (String) se.getSession().getAttribute("lastTime");
		if(pageNum == 0 || (pageNum==1 && "注册".equals(chickPageList.get(0).getPageName()))) {//校外登录被拒绝
			return;
		}
		//通过来源网址来得到来源网站机构
		List<BrowseCount> list = browseService.findRefOrg();
		String ref = browseCount.getRefererUrl();
		for(int i=0; i<list.size(); i++) {
			if(ref == null) {
                ref = "http://www.spischolar.com/";
            }
			browseCount.setRefererUrl(ref);
			if(ref.contains(list.get(i).getRefererUrl())) {
				browseCount.setRefererOrg(list.get(i).getRefererOrg());
			}
		}
		browseCount.setPageNum(pageNum);
		//获得本次访问的结束时间
		browseCount.setLastTime(lastTime);
		browseCount.setType(0);//原始数据
		if(org == null) {
			org = cacheModule.findOrgByIpFromCache(browseCount.getIp());  //通过IP获得机构名
		}
		browseCount.setSchoolFlag(org.getFlag());
		browseCount.setSchoolName(org.getName());
		browseCount.setSchoolProvince(org.getProvince());
		if(user != null) {
		} else if(id != null) {
			user = userService.detail(Integer.parseInt(id));
		} else {
			return;
		}
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date visitDate = null;
		try {
			visitDate = df.parse(browseCount.getBeginTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(visitDate.after(user.getRegisterTime())) {
			browseCount.setMemberType(1);
        } else {
        	browseCount.setMemberType(0);
        }
		browseCount.setMemberId(user.getId());
		if("Tourist".equals(user.getEmail())) {
			browseCount.setRegister(false);
    	} else {
    		browseCount.setRegister(true);
    	}
		logger.info("最后browseCountNum="+pageNum);
		browseCount.setChickPageList(chickPageList);
		browseCount.setTime(DateUtil.getTimeNum(browseCount.getLastTime(),browseCount.getBeginTime()));
		BrowseInfoUtil.insertBrowseInfo(browseCount);
		
    }
}
