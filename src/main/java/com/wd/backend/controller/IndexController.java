package com.wd.backend.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wd.util.LoginUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.PersonBO;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Person;
import com.wd.backend.model.VisiteInformation;
import com.wd.backend.service.ContentAnalysisServiceI;
import com.wd.backend.service.DocDeliveryManagerI;
import com.wd.backend.service.DownloadRecordManagerI;
import com.wd.backend.service.FlowAnalysisServiceI;
import com.wd.backend.service.MemberManagerI;
import com.wd.comm.Comm;
import com.wd.front.listener.SessionListener;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.front.service.UserServiceI;
import com.wd.util.AjaxResult;
import com.wd.util.JsonUtil;
import com.wd.util.MD5Util;

/**
 * 后台管理首页控制器
 * 
 * @author pan
 * 
 */
@Controller
@RequestMapping("/backend")
public class IndexController {
	
	private static final Logger log=Logger.getLogger(IndexController.class);

	@Autowired
	private FlowAnalysisServiceI flowAnalysisService;
	
	@Autowired
	private OrgInfoServiceI orgInfoService;
	
	@Autowired
	private PersonDaoI personDao;
	
	@Autowired
	private OrgDaoI orgDao;
	
	@Autowired
	private ContentAnalysisServiceI contService;
	
	@Autowired
	private DocDeliveryManagerI docDeliveryService;
	
	@Autowired
	DownloadRecordManagerI downloadRecordManagerService;
	
	@Autowired
	private MemberManagerI memberManager;

	@RequestMapping(value = { "/login" }, method = { RequestMethod.GET })
	public String login() {
		return "back/login";
	}

	@RequestMapping(value = { "/logout" }, method = { RequestMethod.GET })
	public String logout(HttpServletResponse response,HttpServletRequest request) {
		request.getSession().invalidate();
		//移除自动登陆
		Map<String,String> cookieMap = new HashMap<>();
		cookieMap.put("username",null);
		cookieMap.put("password", null);
		LoginUtil.creatCookie(cookieMap,request,response,0);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/login";
	}

	/**用户信息修改*/
	@Autowired
	private UserServiceI userService;
	/**
	 * 用户登录
	 * @param person
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/login" }, method = { RequestMethod.POST })
	public String login(PersonBO person,String valCode, HttpServletRequest request,HttpServletResponse response,HttpSession session) {
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		request.setAttribute("loginperson", person);  //登陆页面的输入框文字保留
		String code=(String)session.getAttribute("backend:code");
		if(null==valCode||!valCode.equalsIgnoreCase(code)){
			request.setAttribute("error", "验证码错误!");
			return "back/login";
		}
		String password=MD5Util.getMD5(person.getPassword().getBytes());
		Member user=userService.backLogin(person.getEmail(), password, request,response);
		if(user != null){
			if(user.getStat() == 1) {//登录成功
				Map<String,String> cookie = new HashMap<String,String>();
				cookie.put("username",user.getEmail());
				cookie.put("thisId",request.getSession().getId());
				int time = 60*60*24;
				LoginUtil.creatCookie(cookie,request,response,time);
				request.getSession().setAttribute("spischolarID", user.getId()+"");
				request.getSession().setAttribute(Comm.MEMBER_SESSION_NAME, user);
				SessionListener.addSessionMap(request.getSession(), user.getId().toString());
				request.getSession().setAttribute("type", "-1");
				return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/index";
			} else {
				request.setAttribute("error", user.getInfo());
				return "back/login";
			}
		}else{
			request.setAttribute("error", "登录账号或密码错误!");
			return "back/login";
		}
	}
	/**
	 * 重置登陆信息
	 */
	@RequestMapping(value = { "/user" }, method = { RequestMethod.GET })
	public String user(HttpServletRequest request) {
		Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		Org org=orgDao.findByFlag(p.getSchoolFlag());
		if(null != org){
			OrgBO orgBO = new OrgBO();
			BeanUtils.copyProperties(org, orgBO);
			request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgBO);
			request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
		}
		
		request.getSession().setAttribute("org", org);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/index";
	}
	/**
	 * 网站概况，流量统计
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/index" }, method = { RequestMethod.GET })
	public String index(HttpServletRequest request) {
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if("wdkj".equals(school)) {
            school = "all";
        }
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		String type = (String) request.getSession().getAttribute("type");
		request.setAttribute("school", school);
		if(school != null && "all".equals(school)) {
			school = null;
		}
		if(type == null || "".equals(type)) {
			type = "-1";
		}
		request.getSession().setAttribute("type", type);
		List<Map<String, Object>> list =flowAnalysisService.visite(school, type);
		
		List<Org> orgList = orgInfoService.findAll();
		List<Org> pList = orgInfoService.findProvince();
		Collections.sort(orgList);
		
		List<Map<String,Object>> searchInfoList = contService.getAllSearchInfoCount(school,type,null,null);
		int deliveryCount = docDeliveryService.findAllDeliveryCountBySchool(school);
		int downloadCount = downloadRecordManagerService.getAllCount(school, null, null,type);
		Map<String,Object> memberList = memberManager.getCount(school,type);
		
		
		request.setAttribute("visiteList", list);
		request.setAttribute("show",1);
		request.getSession().setAttribute("orgList", orgList);
		request.getSession().setAttribute("pList", pList);
		request.setAttribute("searchInfoList",searchInfoList);
		request.setAttribute("deliveryCount",deliveryCount);
		request.setAttribute("downloadCount",downloadCount);
		request.setAttribute("memberList",memberList);
		return "/back/index";
	}
	
	//获取随机颜色
	private Color getRandColor(int fc,int bc){  
		Random random = new Random();  
		if(fc>255) {
            fc=255;
        }
		if(bc>255) {
            bc=255;
        }
		int r = fc + random.nextInt(bc - fc);  
		int g = fc + random.nextInt(bc - fc);  
		int b = fc + random.nextInt(bc - fc);  
		return new Color(r,g,b);  
    } 
	
	@RequestMapping(value = { "/img" }, method = { RequestMethod.GET })
	public void validateImg(HttpServletResponse response,HttpSession session){
		
		
		//设置页面不缓存   
	    response.setHeader("Pragma", "No-cache");  
	    response.setHeader("Cache-Control", "no-cache");     
	    response.setDateHeader("Expires", 0);  
	    //在内存中创建图像  
	    int width = 60;  
	    int height = 20;  
	    BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);  
	    //获取图形上下文  
	    Graphics g = image.getGraphics();  
	    //随机类  
	    Random random = new Random();  
	    //设定背景  
	    g.setColor(getRandColor(200, 250));  
	    g.fillRect(0, 0, width, height);  
	    //设定字体  
	    g.setFont(new Font("Times New Roman",Font.PLAIN,18));  
	   //随机产生干扰线  
	   g.setColor(getRandColor(160, 200));     
	   for (int i = 0; i < 100; i++) {     
	        int x = random.nextInt(width);     
	        int y = random.nextInt(height);     
	        int xl = random.nextInt(12);     
	        int yl = random.nextInt(12);     
	        g.drawLine(x, y, x + xl, y + yl);     
	   }   
	   //随机产生4位验证码  
	   String[] codes = {"2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z"};  
	   String code = "";  
	   for(int i=0;i<4;i++){  
	       String str = codes[random.nextInt(codes.length)];  
	       code += str;  
	       // 将认证码显示到图象中  
	       g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));  
	       //调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成     
	       g.drawString(str, 13 * i + 6, 16);     
	   }  
	    // 将认证码存入SESSION     
	   session.setAttribute("backend:code", code);  
	   // 图象生效     
	   g.dispose();
	   try{
		   // 输出图象到页面     
		   ImageIO.write(image, "JPEG", response.getOutputStream());  
		   //加上下面代码,运行时才不会出现java.lang.IllegalStateException: getOutputStream() has already been called ..........等异常  
		   response.getOutputStream().flush();    
		   response.getOutputStream().close();    
		   response.flushBuffer(); 
	   }catch(Exception e){
		   log.error("验证码生成出错!",e);
	   }
	}
	
	@RequestMapping(value = { "/index/changeType" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult changeType(HttpServletRequest request) {
		String type = request.getParameter("type");
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(!"wdkj".equals(school)) {
			type = "-1";
		}
		System.out.println(type);
		request.getSession().setAttribute("type", type);
		return new AjaxResult("成功!");
	}

}
