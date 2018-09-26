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
 * 判断访问来源是PC端还是移动端
 * @author LuJinFeng
 *
 */
public class MobileInterceptor extends HandlerInterceptorAdapter{

    private static final Pattern P1 = Pattern.compile(".*(Windows NT 6\\.1).*");
    private static final Pattern P2 = Pattern.compile(".*(Windows NT 5\\.1|Windows XP).*");
    private static final Pattern P3 = Pattern.compile(".*(Windows NT 5\\.2).*");
    private static final Pattern P4 = Pattern.compile(".*(Win2000|Windows 2000|Windows NT 5\\.0).*");
    private static final Pattern P5 = Pattern.compile(".*(Mac|apple|MacOS8).*");
    private static final Pattern P6 = Pattern.compile(".*(WinNT|Windows NT).*");
    private static final Pattern P7 = Pattern.compile(".*Linux.*");
    private static final Pattern P8 = Pattern.compile(".*(68k|68000).*");
    private static final Pattern P9 = Pattern.compile(".*(9x 4.90|Win9(5|8)|Windows 9(5|8)|95/NT|Win32|32bit).*");

    /**
     * Wap网关Via头信息中特有的描述信息
     */
    private static String[] mobileGateWayHeaders = new String[]{
            "ZXWAP",//中兴提供的wap网关的via信息，例如：Via=ZXWAP GateWayZTE Technologies，
            "chinamobile.com",//中国移动的诺基亚wap网关，例如：Via=WTP/1.1 GDSZ-PB-GW003-WAP07.gd.chinamobile.com (Nokia WAP Gateway 4.1 CD1/ECD13_D/4.1.04)
            "monternet.com",//移动梦网的网关，例如：Via=WTP/1.1 BJBJ-PS-WAP1-GW08.bj1.monternet.com. (Nokia WAP Gateway 4.1 CD1/ECD13_E/4.1.05)
            "infoX",//华为提供的wap网关，例如：Via=HTTP/1.1 GDGZ-PS-GW011-WAP2 (infoX-WISG Huawei Technologies)，或Via=infoX WAP Gateway V300R001 Huawei Technologies
            "XMS 724Solutions HTG",//国外电信运营商的wap网关，不知道是哪一家
            "wap.lizongbo.com",//自己测试时模拟的头信息
            "Bytemobile",//貌似是一个给移动互联网提供解决方案提高网络运行效率的，例如：Via=1.1 Bytemobile OSN WebProxy/5.1
    };
    /**电脑上的IE或Firefox浏览器等的User-Agent关键词*/
    private static String[] pcHeaders=new String[]{
    "Windows 98",
    "Windows ME",
    "Windows 2000",
    "Windows XP",
    "Windows NT",
    "Ubuntu"
    };
    /**手机浏览器的User-Agent里的关键词*/
    private static String[] mobileUserAgents=new String[]{
    "Nokia",//诺基亚，有山寨机也写这个的，总还算是手机，Mozilla/5.0 (Nokia5800 XpressMusic)UC AppleWebkit(like Gecko) Safari/530
    "SAMSUNG",//三星手机 SAMSUNG-GT-B7722/1.0+SHP/VPP/R5+Dolfin/1.5+Nextreaming+SMM-MMS/1.2.0+profile/MIDP-2.1+configuration/CLDC-1.1
    "MIDP-2",//j2me2.0，Mozilla/5.0 (SymbianOS/9.3; U; Series60/3.2 NokiaE75-1 /110.48.125 Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/413 (KHTML like Gecko) Safari/413
    "CLDC1.1",//M600/MIDP2.0/CLDC1.1/Screen-240X320
    "SymbianOS",//塞班系统的，
    "MAUI",//MTK山寨机默认ua
    "UNTRUSTED/1.0",//疑似山寨机的ua，基本可以确定还是手机
    "Windows CE",//Windows CE，Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.11)
    "iPhone",//iPhone是否也转wap？不管它，先区分出来再说。Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_1 like Mac OS X; zh-cn) AppleWebKit/532.9 (KHTML like Gecko) Mobile/8B117
    "iPad",//iPad的ua，Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; zh-cn) AppleWebKit/531.21.10 (KHTML like Gecko) Version/4.0.4 Mobile/7B367 Safari/531.21.10
    "Android",//Android是否也转wap？Mozilla/5.0 (Linux; U; Android 2.1-update1; zh-cn; XT800 Build/TITA_M2_16.22.7) AppleWebKit/530.17 (KHTML like Gecko) Version/4.0 Mobile Safari/530.17
    "BlackBerry",//BlackBerry8310/2.7.0.106-4.5.0.182
    "UCWEB",//ucweb是否只给wap页面？ Nokia5800 XpressMusic/UCWEB7.5.0.66/50/999
    "ucweb",//小写的ucweb貌似是uc的代理服务器Mozilla/6.0 (compatible; MSIE 6.0;) Opera ucweb-squid
    "BREW",//很奇怪的ua，例如：REW-Applet/0x20068888 (BREW/3.1.5.20; DeviceId: 40105; Lang: zhcn) ucweb-squid
    "J2ME",//很奇怪的ua，只有J2ME四个字母
    "YULONG",//宇龙手机，YULONG-CoolpadN68/10.14 IPANEL/2.0 CTC/1.0
    "YuLong",//还是宇龙
    "COOLPAD",//宇龙酷派YL-COOLPADS100/08.10.S100 POLARIS/2.9 CTC/1.0
    "TIANYU",//天语手机TIANYU-KTOUCH/V209/MIDP2.0/CLDC1.1/Screen-240X320
    "TY-",//天语，TY-F6229/701116_6215_V0230 JUPITOR/2.2 CTC/1.0
    "K-Touch",//还是天语K-Touch_N2200_CMCC/TBG110022_1223_V0801 MTK/6223 Release/30.07.2008 Browser/WAP2.0
    "Haier",//海尔手机，Haier-HG-M217_CMCC/3.0 Release/12.1.2007 Browser/WAP2.0
    "DOPOD",//多普达手机
    "Lenovo",// 联想手机，Lenovo-P650WG/S100 LMP/LML Release/2010.02.22 Profile/MIDP2.0 Configuration/CLDC1.1
    "LENOVO",// 联想手机，比如：LENOVO-P780/176A
    "HUAQIN",//华勤手机
    "AIGO-",//爱国者居然也出过手机，AIGO-800C/2.04 TMSS-BROWSER/1.0.0 CTC/1.0
    "CTC/1.0",//含义不明
    "CTC/2.0",//含义不明
    "CMCC",//移动定制手机，K-Touch_N2200_CMCC/TBG110022_1223_V0801 MTK/6223 Release/30.07.2008 Browser/WAP2.0
    "DAXIAN",//大显手机DAXIAN X180 UP.Browser/6.2.3.2(GUI) MMP/2.0
    "MOT-",//摩托罗拉，MOT-MOTOROKRE6/1.0 LinuxOS/2.4.20 Release/8.4.2006 Browser/Opera8.00 Profile/MIDP2.0 Configuration/CLDC1.1 Software/R533_G_11.10.54R
    "SonyEricsson",// 索爱手机，SonyEricssonP990i/R100 Mozilla/4.0 (compatible; MSIE 6.0; Symbian OS; 405) Opera 8.65 [zh-CN]
    "GIONEE",//金立手机
    "HTC",//HTC手机
    "ZTE",//中兴手机，ZTE-A211/P109A2V1.0.0/WAP2.0 Profile
    "HUAWEI",//华为手机，
    "webOS",//palm手机，Mozilla/5.0 (webOS/1.4.5; U; zh-CN) AppleWebKit/532.2 (KHTML like Gecko) Version/1.0 Safari/532.2 Pre/1.0
    "GoBrowser",//3g GoBrowser.User-Agent=Nokia5230/GoBrowser/2.0.290 Safari
    "IEMobile",//Windows CE手机自带浏览器，
    "WAP2.0"//支持wap 2.0的
    };
   
     @Override
     public boolean preHandle(HttpServletRequest request, HttpServletResponse resp,
                              Object obj) throws Exception {
    	 
    	 request.getSession().setMaxInactiveInterval(15*60);    //设置session时长，每次访问之后重新设置
    	 isMobile(request,resp);
    	 
    	 return true;
     }
     /**
      * 根据当前请求的特征，判断该请求是否来自手机终端，主要检测特殊的头信息，以及user-Agent这个header
      * @param request http请求
      */
     private void isMobile(HttpServletRequest request, HttpServletResponse resp) {
    	 String isMobile = (String) request.getSession().getAttribute("isMobile");
    	 if(isMobile != null) {
    		 return;
    	 }
         String b = "/";
         boolean pcFlag = false;
         boolean mobileFlag = false;
         String via = request.getHeader("Via");
         String userAgent = request.getHeader("user-agent");
         for (int i = 0; via!=null && !"".equals(via.trim()) && i < mobileGateWayHeaders.length; i++) {
             if(via.contains(mobileGateWayHeaders[i])){
                 mobileFlag = true;
                 break;
             }
         }
         for (int i = 0; !mobileFlag && userAgent!=null && !"".equals(userAgent.trim()) && i < mobileUserAgents.length; i++) {
             if(userAgent.contains(mobileUserAgents[i])){
                 mobileFlag = true;
                 break;
             }
         }
         for (int i = 0; userAgent!=null && !"".equals(userAgent.trim()) && i < pcHeaders.length; i++) {
             if(userAgent.contains(pcHeaders[i])){
                 pcFlag = true;
                 break;
             }
         }
         if(mobileFlag==true && pcFlag==false){
             b="mobiles/";
         }
         request.getSession().setAttribute("isMobile", b);
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
