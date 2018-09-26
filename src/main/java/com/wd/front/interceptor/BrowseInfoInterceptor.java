package com.wd.front.interceptor;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.model.BrowseCount;
import com.wd.util.IpUtil;

/**
 * 浏览记录拦截器
 * @author Administrator
 *
 */
public class BrowseInfoInterceptor extends HandlerInterceptorAdapter {

	private static final Pattern P1 = Pattern.compile(".*(Windows NT 6\\.1).*");
	private static final Pattern P2 = Pattern.compile(".*(Windows NT 5\\.1|Windows XP).*");
	private static final Pattern P3 = Pattern.compile(".*(Windows NT 5\\.2).*");
	private static final Pattern P4 = Pattern.compile(".*(Win2000|Windows 2000|Windows NT 5\\.0).*");
	private static final Pattern P5 = Pattern.compile(".*(Mac|apple|MacOS8).*");
	private static final Pattern P6 = Pattern.compile(".*(WinNT|Windows NT).*");
	private static final Pattern P7 = Pattern.compile(".*Linux.*");
	private static final Pattern P8 = Pattern.compile(".*(68k|68000).*");
	private static final Pattern P9 = Pattern.compile(".*(9x 4.90|Win9(5|8)|Windows 9(5|8)|95/NT|Win32|32bit).*");

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
		browseInfo(req);
		return true;
	}
	
	 /**
 	 * 获取用户客户端信息
 	 * @param request
 	 */
 	public void browseInfo(HttpServletRequest request) {
 		String ip =IpUtil.getIpAddr(request);                  //获取访客ip地址
 		//上一页URL
 		List<String> previousUrlList = (List<String>) request.getSession().getAttribute("previousUrlList");
 		List<String> urlList = (List<String>) request.getSession().getAttribute("urlList");
 		if(urlList == null) {
 			urlList = new ArrayList<String>();
 		}
 		if(previousUrlList == null) {
 			previousUrlList = new ArrayList<String>();
 		}
 		String previousUrl = request.getHeader("Referer");
 		if(previousUrl == null) {
            previousUrl = "http://www.spischolar.com/";
        }
 		
 		
 		String url = request.getRequestURL().toString();//访问页面
 		
 		//获取完整URL
 		if(request.getQueryString() != null) {
 			String queryString = request.getQueryString(); 
 			try {
 				//转码中文
 				queryString = URLDecoder.decode(queryString, request.getCharacterEncoding());
 			} catch (UnsupportedEncodingException e) {
 				e.printStackTrace();
 			} 
 			url = url + "?" + queryString;
 		}
 		//页面访问时间 !url.contains("/journal/subject/") &&
 		if( !url.contains("/journal/subjectJSON") && !url.contains("/journal/image") && !url.contains("/user/historyForSearch")){
 			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 			urlList.add(url + "begin=" + sdf.format(new Date()));
 			previousUrlList.add(previousUrl);
 		}
 		request.getSession().setAttribute("previousUrlList",previousUrlList);
 		request.getSession().setAttribute("urlList",urlList);
 		//保存访问过得页面
 		//保存用户的电脑配置信息，浏览器信息等
 		BrowseCount browseCount = (BrowseCount)request.getSession().getAttribute("browseInformation");
 		
 		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = df.format(new Date()); 
 		if(browseCount == null) {
 			//固定信息
 			String refererUrl = request.getHeader("Referer");  //来源网站
 			String userBrowser =request.getHeader("user-agent");//返回客户端浏览器的版本号、类型
 			String win = getClientOS(userBrowser); //win2003竟然是win xp？
 			
 			String browserName = getBrowserName(userBrowser);//区分浏览器方法
 			request.getSession().setAttribute("browserName", browserName);
 			
 			
 			
 			browseCount = new BrowseCount(); 
 			//browseCount.setBeginTime(new Date());
 			browseCount.setBeginTime(time);
 			
 			browseCount.setIp(ip);
 			browseCount.setRefererUrl(refererUrl);
 			browseCount.setUserBrowser(browserName);
 			browseCount.setWin(win);
 			request.getSession().setAttribute("browseInformation", browseCount);
 		}
 		//设置访问结束时间，每次访问后更新
 		//request.getSession().setAttribute("lastTime", new Date());
 		request.getSession().setAttribute("lastTime", time);
 	}
 	
 	/**
	 * 分辨浏览器
	 * @param agent
	 * @return
	 */
	public String getBrowserName(String agent) {
		agent = agent.toLowerCase();
		  if(agent.indexOf("msie 7")>0){
		   return "ie7";
		  }else if(agent.indexOf("msie 8")>0){
		   return "ie8";
		  }else if(agent.indexOf("msie 9")>0){
		   return "ie9";
		  }else if(agent.indexOf("msie 10")>0){
		   return "ie10";
		  }else if(agent.indexOf("msie")>0){
		   return "ie";
		  }else if(agent.indexOf("opera")>0){
		   return "欧朋";
		  }else if(agent.indexOf("firefox")>0){
		   return "火狐";
		  }else if(agent.indexOf("gecko")>0 && agent.indexOf("rv:11")>0){
		   return "ie11";
		  } else if(agent.indexOf("qqbrowser")>0) {
			  return "QQ浏览器";
		  } else if(agent.indexOf("chrome")>0) {
			  return "谷歌";
		  } else if(agent.indexOf("maxthon")>0) {
			  return "遨游";
		  } else{
		   return "其他";
		  }
	}  
	
	
	public static String getClientOS(String userAgent)
    {
        String cos = "unknow os";

        Matcher m = P1.matcher(userAgent);
        if(m.find())
        {
            cos = "Win 7";
            return cos;
        }

        m = P2.matcher(userAgent);
        if(m.find())
        {
            cos = "WinXP";
            return cos;
        }

        m = P3.matcher(userAgent);
        if(m.find())
        {
            cos = "Win2003";
            return cos;
        }

        m = P4.matcher(userAgent);
        if(m.find())
        {
            cos = "Win2000";
            return cos;
        }

        m = P5.matcher(userAgent);
        if(m.find())
        {
            cos = "MAC";
            return cos;
        }

        m = P6.matcher(userAgent);
        if(m.find())
        {
            cos = "WinNT";
            return cos;
        }

        m = P7.matcher(userAgent);
        if(m.find())
        {
            cos = "Linux";
            return cos;
        }

        m = P8.matcher(userAgent);
        if(m.find())
        {
            cos = "Mac68k";
            return cos;
        }

        m = P9.matcher(userAgent);
        if(m.find())
        {
            cos = "Win9x";
            return cos;
        }
        return cos;
    }

}
