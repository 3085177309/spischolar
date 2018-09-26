package com.wd.front.controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wd.front.service.*;
import com.wd.util.*;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;













































import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.Department;
import com.wd.backend.model.DocDelivery;
import com.wd.backend.model.DownloadInfo;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.Feedback;
import com.wd.backend.model.FeedbackInfo;
import com.wd.backend.model.History;
import com.wd.backend.model.JournalImage;
import com.wd.backend.model.JournalUrl;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.service.MailService;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchDocument;
import com.wd.front.bo.ShouluMap;
import com.wd.front.listener.SessionListener;
import com.wd.front.module.cache.CacheModuleI;


/**
 * 用户中心
 * @author Shenfu<651777512@qq.com>
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	private static final Logger log=Logger.getLogger(UserController.class);
	
	@Autowired
	private CacheModuleI cacheModule;
	
	/**用户信息修改*/
	@Autowired
	private UserServiceI userService;
	
	/**历史记录**/
	@Autowired
	private HistoryServiceI historyService;
	
	/**反馈**/
	@Autowired
	public FeedbackServiceI feedbackService;
	
	/**收藏*/
	@Autowired
	private FavoriteServiceI favoriteService;
	
	@Autowired
	private OrgInfoServiceI orgService;
	
	@Autowired
	private SearchLogServiceI service;
	
	@Autowired
	private PersonDaoI personDao;
	
	@Autowired
	private OrgDaoI orgDao;
	
	/**下载记录*/
	@Autowired
	private DownloadRecordI downloadRecordService;

	@Autowired
	private TranslateServiceI translateService;
	
	@Autowired
	private MailService mailService;
	private String title="[文献互助•成功]——%s";
	private String template="您好！您求助的文献  %s 已应助成功。";
//	private String templateUrl ="请点击以下链接下载全文  %s （临时链接，有效期30天，请及时下载）。<br><br>欢迎您使用Spischolar学术资源在线<br>http://www.spischolar.com/";
	private String templateUrl ="<br>请点击以下链接下载全文  %s <br>注意：该链接有效期为15天（  %s 止），请及时下载。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	
	/**
	 * 文献传递
	 */
	@Autowired
	private DocDiliveryServiceI docDiliveryService;
	
	/**
	 * 查看session是否有登陆信息
	 * @param session
	 * @return
	 */
	private boolean checkLogin(HttpSession session){
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user != null){
			return true;
		}else{
			return false;
		}
	}
	
	@RequestMapping(value = { "/login" }, method = { RequestMethod.GET })
	public String login(HttpServletRequest request, HttpServletResponse response,HttpSession session){
		if(checkLogin(session)){//如果已经登录
			return UrlBasedViewResolver.FORWARD_URL_PREFIX+"/";
		} 
	/*	try {
			response.sendRedirect("http://sso.wd.com/login?service=http://web.com:8888/journal");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;*/
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		String isImposedOut = (String) session.getAttribute("isImposedOut");
		if(isImposedOut != null) {
			session.removeAttribute("isImposedOut");
			request.setAttribute("isImposedOuts", isImposedOut);
		}
		return isMobile+"sites/logins";
	}
	
	/**
	 * 12-29改版登陆
	 */
	@RequestMapping(value = { "/login" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult login(String username,String password,Boolean rember,HttpServletRequest request, HttpServletResponse response) throws SystemException{
		//spischolarID是保存在session和cookie中的用户ID
		//未登陆用户通过保存在cookie中的spischolarID赖判定改用户是否访问过本网站
		String id = (String) request.getSession().getAttribute("spischolarID");
		password=MD5Util.getMD5(password.getBytes());
		Member user=userService.login(username, password,request,response);
		if(user != null){
			Map<String,String> cookie = new HashMap<String,String>();
			cookie.put("username",user.getEmail());
            cookie.put("thisId",request.getSession().getId());
			int time = 60*60*24;
			LoginUtil.creatCookie(cookie,request,response,time);
			if("spischolar".equals(user.getUsername())) {//通用账号
				String ip =IpUtil.getIpAddr(request);
				Org org = orgDao.findByFlag("wdkj");
				OrgBO orgBO = new OrgBO();
				BeanUtils.copyProperties(org, orgBO);
//				OrgBO orgBO = cacheModule.findOrgByIpFromCache("127.0.0.1");
				request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgBO);
				//request.setAttribute(Comm.ORG_FLAG_NAME, orgBO.getFlag());
				user.setSchoolFlag("wdkj");
				request.getSession().setAttribute(Comm.MEMBER_SESSION_NAME, user);
				return new AjaxResult(1,"登录成功");
			}
			if(user.getStat() == 1) {//登录成功
				//记录密码,下次自动登陆
				if(rember!=null && rember.booleanValue()==true){
					request.getSession().setAttribute("rember", "yes");
					request.getSession().setAttribute("password", password);
				}
				request.getSession().setAttribute("spischolarID", user.getId()+"");
				request.getSession().setAttribute(Comm.MEMBER_SESSION_NAME, user);

				SessionListener.addSessionMap(request.getSession(), user.getId().toString());
				loginHis(id,user.getId()+"");
			}
			if(user.getPermission() == 3) {
				userService.updatePermission(user.getId());
			}
			return new AjaxResult(user.getStat(),user.getInfo());
		}else{
			return new AjaxResult(0,"登录失败!账号或密码错误!");
		}
	}
	
	/**
	 * 找回密码
	 * @return
	 */
	@RequestMapping(value = { "/findPwd" }, method = { RequestMethod.GET })
	public String findPwd(HttpServletRequest request){
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/findPwd";
	}
	
	@RequestMapping(value = { "/findPwd" }, method = { RequestMethod.POST })
	public String findPwd(String username,String code,HttpServletRequest request,HttpSession session){
		Member member=userService.findByUsername(username);
		String sessionCode=(String)session.getAttribute("backend:code");
		if(member == null){//
			request.setAttribute("email", "用户名不存在!");
		}else if(StringUtils.isBlank(code) || !code.equalsIgnoreCase(sessionCode)){
			request.setAttribute("email", "验证码错误!");
		}else{
			String path = request.getContextPath();
			// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
			String basePath = request.getScheme() + "://" + request.getServerName()
					+ ":" + request.getServerPort() + path + "/user/checkLink";
			userService.sendResetMail(member, basePath);
			request.setAttribute("email", "邮件发送成功！请注意查收！");
//			throw new OperationException("邮件发送成功！请注意查收！");
		}
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/findPwd";
	}
	
	@RequestMapping(value = { "/findPwdUser" }, method = { RequestMethod.POST })
	@ResponseBody
	public Boolean findPwdUser( HttpServletRequest request) {
		String username = request.getParameter("username");
		Member member=userService.findByUsername(username);
		if(member == null) {
			return false;
		} else {
			return true;
		}
	}
	
	@RequestMapping(value = { "/checkLink" }, method = { RequestMethod.GET })
	public String checkLink(String sid,String username,HttpServletRequest request){
		try {
			if(StringUtils.isBlank(sid) || StringUtils.isBlank(username)){//检测
				throw new OperationException("链接错误,请重新申请找回密码");
			}
			Member member=userService.checkResetInfo(sid, username);
			request.setAttribute("member", member);
			request.setAttribute("message", null);
		} catch(Exception e) {
			request.setAttribute("message", e.getMessage());
		}
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/resetPwd";
	}
	
	@RequestMapping(value = { "/resetPwdUL" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult resetPwdUL(Integer id,String newPwd,String rePwd ,HttpServletRequest request){
		if(StringUtils.isBlank(newPwd) || StringUtils.isBlank(rePwd)){
			return AjaxResult.errorResult("密码不能为空!");
		}
		if(!rePwd.equals(newPwd)){
			return AjaxResult.errorResult("两次输入的密码不相同!");
		}
		try{
			userService.setPwd(id, newPwd);
		}catch(OperationException e){
			return AjaxResult.errorResult(e.getMessage()); 
		}
		return new AjaxResult("重置密码成功!需要重新登录。","user/login");
	}
	
	
	
	
	/**
	 * 将未登录用户的记录收藏到已登录用户中
	 * @param oldId
	 * @param memberId
	 */
	public void loginHis(String oldId,String memberId){
		try {
			favoriteService.update(oldId, memberId);//未登录用户的收藏记录收藏到已登录用户的收藏中
			docDiliveryService.update(oldId, memberId);//未登录用户的文献传递记录收藏到已登录用户中

			if (oldId!=null){
				Pager pager = historyService.findPage(null, Integer.parseInt(oldId), -10);
				if(pager.getRows() != null) {
					for(int i = 0; i < pager.getRows().size(); i++) {
						History history = (History) pager.getRows().get(i);
						history.setMemberId(Integer.parseInt(memberId));
						history.setMethod("search");
						service.addAsynHistory(history);
					}
				}
				historyService.deleteHistory(Integer.parseInt(oldId),0);
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	/**
	 * 检测邮箱是否已经注册
	 * @param email
	 * @return
	 */
	@RequestMapping(value = { "/checkEmail" }, method = { RequestMethod.GET })
	@ResponseBody
	public Boolean checkEmail(String email){
		if(userService.checkEmail(email)){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 检测用户是否已经注册
	 * @param username
	 * @return
	 */
	@RequestMapping(value = { "/checkUsername" }, method = { RequestMethod.GET })
	@ResponseBody
	public Boolean checkUsername(String username){
		if(userService.checkUsername(username)){
			return false;
		}else{
			return true;
		}
		
	}
	
	/**
	 * 注册
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/register" }, method = { RequestMethod.GET })
	public String register(HttpServletRequest request){
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		List<Org> list=orgService.findAll();
		Collections.sort(list);
		request.getSession().setAttribute("orgs",list );
		return isMobile+"sites/register";
	}
	
	@RequestMapping(value = { "/register" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult register(Member member,String code,HttpServletRequest request,HttpSession session){
		String isMobile = (String) request.getParameter("isMobile");//手机注册不使用验证码
		if(!"yes".equals(isMobile)) {
			String sessionCode=(String)session.getAttribute("backend:code");
			if(StringUtils.isBlank(code) || !code.equalsIgnoreCase(sessionCode)){
				return AjaxResult.errorResult("验证码错误!");
			}
		}
		try{
			String ip =IpUtil.getIpAddr(request);
			OrgBO org = cacheModule.findOrgByIpFromCache(ip);  //通过IP获得机构名
			if(org != null) {
				member.setSchool(org.getName());
				member.setSchoolFlag(org.getFlag());
			}
			member.setRegisterIp(ip);
			userService.register(member);
		}catch(Exception e){//操作错误!
			return AjaxResult.errorResult(e.getMessage());
		}
		session.setAttribute(Comm.MEMBER_SESSION_NAME, member);
		if(!"yes".equals(isMobile)) {
			session.setAttribute("register_email",member.getEmail());
			return new AjaxResult("您已注册成功，请完善个人信息！");
		} else {
			return new AjaxResult("您已注册成功！");
		}
	}
	
	@RequestMapping(value = { "/register/success" }, method = { RequestMethod.GET })
	public String regusterSuccess(HttpServletRequest request){
		//String isMobile = (String) request.getSession().getAttribute("isMobile");
		return "sites/register-success";
	}
	
	@RequestMapping(value = { "/logout" }, method = { RequestMethod.GET })
	public String logout(HttpServletRequest request,HttpSession session,HttpServletResponse response){
		session.invalidate();
        Map<String,String> cookies = new HashMap<String,String>();
        cookies.put("thisId", session.getId());
        cookies.put("username", null);
        cookies.put("password", null);
        LoginUtil.creatCookie(cookies,request,response,0);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/";
		//return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"http://sso.wd.com/logout?service=http://web.com:8888/journal";
	}
	
	/**
	 * 设置照片
	 * @return
	 */
	@RequestMapping(value = { "/avatar" }, method = { RequestMethod.GET })
	public String avatar(HttpServletRequest request){
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/avatar";
	}
	
	@RequestMapping(value = { "/avatar" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult avatar(HttpSession session,HttpServletRequest request){
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 由CommonsMultipartFile继承而来,拥有上面的方法.
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
					realPath+=dailyPath;
					FileUtil.createDir(new File(realPath));//创建目录
					File attachFile=FileUtil.createTimeNewFile(realPath, file.getOriginalFilename());//创建一个新文件
					try {
						FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
						String savePath=dailyPath+attachFile.getName();
						
						Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
						String smallPsth = user.getAvatar()+"," + user.getFristAvatar() + "," + user.getTwoAvatar();
						userService.updateAvatar(user.getId(), savePath,user);
						user.setAvatar(savePath);
						user.setAvatarSmall(smallPsth);
					} catch (IOException e) {
						log.error("文件保存失败!",e);
					}
				}
			}
		}
		
		
		
		
		return new AjaxResult("头像修改成功!");
	}
	
	/**
	 * 基本信息修改
	 * @return
	 */
	@RequestMapping(value = { "/profile" }, method = { RequestMethod.GET })
	public String profile(HttpServletRequest request,HttpSession session){
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user == null) {
            return "redirect:/";
        }
		Member member=userService.detail(user.getId());
		List<Org> list=orgService.findAll();
		Collections.sort(list);
		if(member.getSchool() != null) {
			for(int i=0; i < list.size(); i++) {
				if(list.get(i).getName().equals(member.getSchool()) ) {
					request.setAttribute("schoolId",list.get(i).getId());
				}
			}
		} else {
			request.setAttribute("schoolId","0" );
		}
		request.setAttribute("orgs",list );
		request.setAttribute("member", member);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/profile";
	}
	/**
	 * 个人信息修改
	 * @param member
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/profile" }, method = { RequestMethod.POST })
	public String profile(Member member,HttpSession session,HttpServletRequest request){
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user == null) {
            return "redirect:/";
        }
		member.setId(user.getId());
		userService.resetProfile(member);
		List<Org> list=orgService.findAll();
		if(StringUtils.isNotBlank(member.getSchoolFlag())){//如果学校标识不为空
			Org org=orgService.getOrgByFlag(member.getSchoolFlag());
			if(null != org){
				OrgBO orgBO = new OrgBO();
				BeanUtils.copyProperties(org, orgBO);
				request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgBO);
				request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
			}
		}
		Member members=userService.detail(user.getId());
		Collections.sort(list);
		if(member.getSchool() != null) {
			for(int i=0; i < list.size(); i++) {
				if(list.get(i).getName().equals(member.getSchool()) ) {
					request.setAttribute("schoolId",list.get(i).getId() );
				}
			}
		} else {
			request.setAttribute("schoolId","0" );
		}
		request.setAttribute("orgs",list );
		request.setAttribute("member", members);
		request.setAttribute("success", "个人信息修改成功");
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/profile";
	}
	/**
	 * 查询各个学校的学院
	 * @param schoolId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/department/{schoolId}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult department(@PathVariable String schoolId,HttpServletRequest request) {
		List<Department> list = orgService.findDepartment(Integer.parseInt(schoolId));
		Collections.sort(list);
		request.setAttribute("department",list );
		String js = JsonUtil.obj2Json(list);
		System.out.print(js);
		return new AjaxResult(js);
	}
	private String titleLLogin ="Spischolar校外登录申请";
	private String templateLoginTrue ="亲爱的用户，您好！<br>"
			+ "您注册的账号“校外登录申请”已经审核通过，请妥善保管好您的账号信息：<br>"
			+ "您的用户名：%s<br>"
			+ "您的注册邮箱：%s<br><br><br>"
			+ "欢迎您加入Spischolar！<br>"
			+ "Spischolar（http://www.spischolar.com/)";
	private String templateLoginFalse ="亲爱的用户，您好！<br>"
			+ "您注册的账号“校外登录申请”审核失败，请填写您的真实信息再次提交申请。<br>"
			+ "如有疑问，请联系Spischolar学术资源服务中心：1962740172@qq.com<br><br><br>"
			+ "欢迎您加入Spischolar！<br>"
			+ "Spischolar（http://www.spischolar.com/)";
	public static Date getNextDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, +6);
		date = calendar.getTime();
		return date;
	}
	/**
	 * 校外登陆
	 * @return
	 */
	@RequestMapping(value = { "/applyLogin" }, method = { RequestMethod.GET })
	public String apply(HttpServletRequest request,HttpSession session){
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user == null) {
            return "redirect:/";
        }
		Member member=userService.detail(user.getId());
		List<Org> list=orgService.findAll();
		Collections.sort(list);
		if(member.getSchool() != null && !"".equals(member.getSchool())) {
			for(int i=0; i < list.size(); i++) {
				if(list.get(i).getName().equals(member.getSchool()) ) {
					request.setAttribute("schoolId",list.get(i).getId() );
				}
			}
		} else {
			request.setAttribute("schoolId","0" );
		}
		
		request.setAttribute("orgs",list );
		request.setAttribute("member", member);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/apply";
	}
	/**
	 * 登录申请
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/applyLogin" }, method = { RequestMethod.POST })
//	@ResponseBody
	public String applyLogin(@RequestParam(value = "file", required = false) MultipartFile file,Member member,HttpSession session,HttpServletRequest request) {
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		String path = request.getParameter("path");
		if(user == null) {
            return "redirect:/";
        }
		member.setId(user.getId());
		userService.resetProfile(member);
		List<Org> list=orgService.findAll();
		if(StringUtils.isNotBlank(member.getSchoolFlag())){//如果学校标识不为空
			Org org=orgService.getOrgByFlag(member.getSchoolFlag());
			if(null != org){
				OrgBO orgBO = new OrgBO();
				BeanUtils.copyProperties(org, orgBO);
				request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgBO);
				request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
			}
		}
		Member members=userService.detail(user.getId());
		Collections.sort(list);
		if(member.getSchool() != null) {
			for(int i=0; i < list.size(); i++) {
				if(list.get(i).getName().equals(member.getSchool()) ) {
					request.setAttribute("schoolId",list.get(i).getId() );
				}
			}
		} else {
			request.setAttribute("schoolId","0" );
		}
		request.setAttribute("orgs",list );
		request.setAttribute("member", members);
		//校外登陆
		String msg = null;
		if(path !=null && !"".equals(path)) {
			member.setIdentification(path);
			member.setLifespan(null);
			member.setPermission(2);//校外登录的权限设置，0为不能校外登录，1为可以，2为申请中
			msg="正在审核您的校外访问申请，请耐心等待。";
			mailService.send("spischolar@126.com", "校外访问申请", "<p><span style='color: blue;'>"+ member.getSchool() +"大学</span>用户"+"<span style='color: blue;'>"+member.getUsername()+"</span>"+"提交了新的用户反馈，请及时处理！</p>", null);
		} else {
			member.setLifespan(getNextDay(new Date()));
			member.setPermission(4);//校外登录的权限设置，0为不能校外登录，1为可以，2为申请中,3为通过提示，4为6个月访问权限
			msg="您已经获得校外访问权限！";
		}
		member.setApplyTime(new Date());
		request.setAttribute("success", msg);
		userService.applyLogin(member);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/apply";
	}
	/**
	 * 请求学校验证api接口
	 * @param jsonUrl
	 * @return
	 * @throws Exception
	 */
	public String api(String jsonUrl) throws Exception {
		URL url = new URL(jsonUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.connect();
		InputStream inputStream = connection.getInputStream();
		// 对应的字符编码转换
		Reader reader = new InputStreamReader(inputStream, "UTF-8");
		BufferedReader bufferedReader = new BufferedReader(reader);
		String str = null;
		StringBuffer sb = new StringBuffer();
		while ((str = bufferedReader.readLine()) != null) {
			sb.append(str);
		}
		reader.close();  
        connection.disconnect(); 
        System.out.println(sb.toString());
        return sb.toString();
	}
	
	/**
	 * 重置密码
	 * @return
	 */
	@RequestMapping(value = { "/security" }, method = { RequestMethod.GET })
	public String security(HttpServletRequest request){
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/security";
	}
	
	@RequestMapping(value = { "/security" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult security(String oldPwd,String newPwd,String rePwd,HttpServletRequest request,HttpSession session){
		if(rePwd == null || !rePwd.equals(newPwd)){
			return AjaxResult.errorResult("两次输入的新密码不相同!");
		}
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		try{
			userService.resetPwd(user, oldPwd, newPwd);
		}catch(OperationException e){
			return AjaxResult.errorResult(e.getMessage()); 
		}
		return new AjaxResult("重置密码成功!需要重新登录。","user/logout");
	}
	
	/**
	 * 检索历史
	 * @return
	 */
	@RequestMapping(value = { "/history" }, method = { RequestMethod.GET })
	public String history(Integer type,HttpServletRequest request,HttpSession session){
		Pager p=historyService.findPage(type,MemberIdFromSession.getMemberId(session),1);  
		Pager pTwo=historyService.findPage(type,MemberIdFromSession.getMemberId(session),2);
		request.setAttribute("data", p);
		request.setAttribute("dataTwo", pTwo);
		request.setAttribute("type", type);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		if(request.getParameter("offset") != null && Comm.Mobile.equals(isMobile)) {
			return isMobile+"sites/historyPage";
		}
		return isMobile+"sites/history";
	}
	/**
	 * 检索历史删除
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = { "/deleteHistory" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult deleteHistory(HttpServletRequest request,HttpSession session){
        String[] name = request.getParameterValues("title");
		int types = Integer.parseInt(request.getParameter("deleteType"));
		if(types == 0) {
			historyService.deleteHistory(MemberIdFromSession.getMemberId(session),0);
		} else {
			for(int i=0; i<name.length; i++) {
				historyService.deleteHistory(Integer.parseInt(name[i]),1);
			}
		}
		return new AjaxResult("删除成功");
	}
	
	/**
	 * 文献传递
	 */
	@RequestMapping(value = { "/dilivery" }, method = { RequestMethod.GET })
	public String dilivery(HttpServletRequest request,HttpSession session){
		String email = request.getParameter("email");
		int memberId =0;
		if(email == null || "".equals(email)) {//如果不查询email，如果查询email则memberID=0
			email = MemberIdFromSession.getMemberEmail(session);//是否登陆，登陆用户根据email和memberID查询，没登陆用户只根据memberID
			memberId = MemberIdFromSession.getMemberId(session);
		}
		//if(email == null || "".equals(email)) email=MemberIdFromSession.getMemberEmail(session);
		String title = request.getParameter("title");
		String processType = request.getParameter("processType");
		if(SimpleUtil.strIsNull(processType)) {
            processType="-1";
        }
		Pager p=docDiliveryService.findPage(memberId,Integer.parseInt(processType),email,title);
		request.setAttribute("data", p);
		request.setAttribute("processType", processType);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		String offset = request.getParameter("offset");
		request.setAttribute("offset", offset);
		request.setAttribute("processType",processType);
		request.setAttribute("email", email);
		if(offset != null && Comm.Mobile.equals(isMobile)) {
			return isMobile+"sites/diliveryPage";
		}
		return isMobile+"sites/dilivery";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/dilivery/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult dilivery(@PathVariable String id,HttpServletRequest request,HttpSession session){
		int source = (int) session.getAttribute("source");
		List<SearchDocument> list=(List<SearchDocument>)session.getAttribute(Comm.DOC_SESSION_CACHE);
		SearchDocument document=null;
		if(list != null) {
			for(SearchDocument doc : list){
				if(doc.getId().equals(id)){
					document=doc;
				}
			}
		}
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(document==null){
			Favorite f=favoriteService.getByDocId(id,user.getId());
			document=JsonUtil.json2Obj(f.getContent(), SearchDocument.class);
		}
		OrgBO org = (OrgBO)session.getAttribute(Comm.ORG_SESSION_NAME);
		if(document != null){
			DocDelivery delivery=new DocDelivery();
			delivery.setTitle(document.getTitle());
			delivery.setUrl(document.getHref());
			if(user != null) {
				delivery.setMemberId(user.getId());
				delivery.setOrgFlag(user.getSchoolFlag());
				delivery.setOrgName(user.getSchool());
				delivery.setEmail(user.getEmail());
				if(user.getSchool() == null || "".equals(user.getSchool())) {
					//OrgBO org = (OrgBO)session.getAttribute(Comm.ORG_SESSION_NAME);
					delivery.setOrgFlag(org.getFlag());
					delivery.setOrgName(org.getName());
				}
			} else {
				delivery.setMemberId(Integer.parseInt((String) session.getAttribute("spischolarID")));
				delivery.setOrgFlag(org.getFlag());
				delivery.setOrgName(org.getName());
			}
			if(request.getParameter("email") != null) {
				delivery.setEmail(request.getParameter("email"));
			}
			delivery.setAddDate(new Date());
			delivery.setProcessDate(null);
			int diliveryCount = docDiliveryService.findcountByEmailFromValidity(delivery.getEmail());
			if(diliveryCount == 0) {
				if(user != null) {//注册用户默认文献传递数
					diliveryCount = (int) session.getAttribute("userDeliveryCount");
				} else {
					diliveryCount = (int) session.getAttribute("diliveryCount");
				}
			}
			int count = docDiliveryService.findcountByEmail(delivery.getEmail());
			Short proStatus =  (Short) session.getAttribute("proStatus");
			String isMobile = (String) request.getSession().getAttribute("isMobile");
			if(count >= diliveryCount && proStatus == 1) { //购买
				return new AjaxResult(0,diliveryInfo(proStatus,org,isMobile,user));
			}
			if(count >= diliveryCount && proStatus == 2) { //试用
				return new AjaxResult(0,diliveryInfo(proStatus,org,isMobile,user));
			}
			
			DocDelivery delivery2 = docDiliveryService.findUrl(delivery);
			if(delivery2 != null) {
				return new AjaxResult(1,"请不要重复提交！");
			} else {
				//复用文献传递，自动传递文献
				DocDelivery deliveryReuse = docDiliveryService.findByReuse(delivery);
				if(deliveryReuse != null) {
					delivery.setProcessType((short)6);
					delivery.setProcessDate(new Date());
					delivery.setPath(deliveryReuse.getPath());
				}
				delivery.setProductId(2);
				docDiliveryService.addDilivery(delivery);
				if(deliveryReuse != null) {
					String url = request.getRequestURL() + "/download/delivery?id="+delivery.getId()+"&time=" + System.currentTimeMillis();;
					url = url.replace("/user/dilivery/"+id, "");
					String time = DateUtil.getEndTime(DateUtil.format(new Date()), 16*24*60*60).substring(0,10);//到期时间
					String content = String.format(template, delivery.getTitle()) + String.format(templateUrl, url,time);
					mailService.send(delivery.getProductId(),delivery.getEmail(), String.format(title, delivery.getTitle()), content, null);
					return new AjaxResult(1,"文献求助已提交，你可以在<a style='color: #005cd9' target='_blank' href='http://www.spischolar.com/user/diliveryHelp'>文献互助中心</a>或提交邮箱中查看求助进度。部分邮箱系统会将回复邮件识别为垃圾邮件，请注意检查。");
				}
				mailService.send("spischolar@126.com", "用户文献互助", "<p><span style='color: blue;'>"+delivery.getOrgName()+"</span>"+"用户"+"<span style='color: blue;'>"+delivery.getEmail()+"</span>"+"已提交文献互助请求，请及时处理！</p>", null);
				return new AjaxResult(1,"文献求助已提交，你可以在<a style='color: #005cd9' target='_blank' href='http://www.spischolar.com/user/diliveryHelp'>文献互助中心</a>或提交邮箱中查看求助进度。部分邮箱系统会将回复邮件识别为垃圾邮件，请注意检查。");
			}
		}
		return new AjaxResult(1,"抱歉,处理出错了!");
	}
	
	private String diliveryInfo(int proStatus,OrgBO org,String isMobile,Member user) {
		String info = "";
		if(Comm.Mobile.equals(isMobile)) {//手机
			if(proStatus == 2) {//试用
				info = "由于贵校未正式购买Spischolar学术资源在线，您今天提交的文献互助请求已达上限。\r\n请联系图书馆老师获取更多文献互助提交权限！";
				if(org.getContactPerson() != null) {
					info = info +org.getContactPerson() + ":" +org.getContact() + "&nusp;&nusp;&nusp;&nusp; " + org.getEmail() +"\r\n";
				}
				info = info + "或直接联系Spischolar客服（QQ：1962740172）\r\n";
			} else if(proStatus == 1) {
				info = "您今天提交的文献互助请求已达上限，请明天再来……\r\n"
						+ "获取更多文献互助提交权限，请登录后使用或联系"
						+ "Spischolar客服（QQ：1962740172）\r\n";
			}
		} else {
			if(proStatus == 2) {//试用
				info = "由于贵校未正式购买Spischolar学术资源在线，您今天提交的文献互助请求已达上限。<br/>\r\n请联系图书馆老师获取更多文献互助提交权限！<br/>\r\n";
				if(!StringUtils.isEmpty(org.getContactPerson())) {
					info = info +org.getContactPerson() + ":" +org.getContact() + "&nbsp;&nbsp;&nbsp;&nbsp;" + org.getEmail() +"<br/>\r\n";
				}
				info = info + "或直接联系<a style='color: #005cd9' href='tencent://message/?Menu=yes&amp;uin=1962740172' class='sug qq-link'>Spischolar客服</a>（QQ：1962740172）<br/><br/>\r\n";
				if(!StringUtils.isEmpty(org.getEmail())) {
					info = info + "<a  class='btn-blue' href='mailto:"+org.getEmail()+"'>发送邮件</a> ";
				}
				info = info+"<a  class='btn-blue close'>取消</a>";
			} else if(proStatus == 1) {
				info = "您今天提交的文献互助请求已达上限，请明天再来……<br/>\r\n获取更多文献互助提交权限，请";
				if(user == null) {
					info = info + "<a style='color: #005cd9' href='javascript:void(0)' id='login-btn-dilivery'>登录</a>后使用或";
				}
				info = info + "联系<a style='color: #005cd9' href='tencent://message/?Menu=yes&amp;uin=1962740172' class='sug qq-link'>Spischolar客服</a>（QQ：1962740172）<br/><br/>\r\n";
				info = info+"<a  class='btn-blue close'>取消</a>";
			}
		}
		return info;
	}
	
	private String getName(File file,String userAgent) throws UnsupportedEncodingException{
		String fileName=file.getName(),ext,name;
		ext=fileName.substring(fileName.lastIndexOf(".")+1);
		name=fileName.substring(0,fileName.lastIndexOf("."));
		name=name+"."+ext;
		byte[] bytes = userAgent.contains("MSIE") ? name.getBytes()
		        : name.getBytes("UTF-8"); // fileName.getBytes("UTF-8")处理safari的乱码问题
		return  new String(bytes, "ISO-8859-1"); 
	}
	
	@RequestMapping(value = { "/dilivery/download/{id}" }, method = { RequestMethod.GET })
	public void downFile(@PathVariable Long id ,HttpServletRequest request,HttpServletResponse response ){
		DocDelivery del=docDiliveryService.get(id);
		String path=del.getPath(),basePath=request.getSession().getServletContext().getRealPath("/");
		File file=new File(basePath+path);  
	    BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null;  
	    try{
	    	long fileLength = file.length();  
	    	response.setContentType("application/octet-stream"); 
	    	String fileName=getName(file,request.getHeader("User-Agent"));
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", fileName));
	    	response.setHeader("Content-Length", String.valueOf(fileLength));  
	    	bis = new BufferedInputStream(new FileInputStream(file));  
	        bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	
	    }finally{
	    	if(bis!=null){
	    		try{
	    			bis.close();
	    			bis=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	if(bos!=null){
	    		try{
	    			bos.close();
	    			bos=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    }
	}
	
	
	/**
	 * 收藏
	 * @return
	 */
	@RequestMapping(value = { "/favorite" }, method = { RequestMethod.GET })
	public String favorite(HttpServletRequest request,HttpSession session){
		String type = request.getParameter("type");
		if(StringUtils.isEmpty(type)) {
            type = "1";
        }
		Pager p=favoriteService.findPager(MemberIdFromSession.getMemberId(session),Integer.parseInt(type));
		if(Integer.parseInt(type) == 2 ) {
			List<Favorite> favoriteList = p.getRows();
			if(favoriteList != null) {
				String[] ids = new String[favoriteList.size()];
				for (int i = 0; i < favoriteList.size(); i++) {
					ids[i] = favoriteList.get(i).getDocId();
				}
				session.setAttribute("ids", JsonUtil.obj2Json(ids));
			}
//			findJournal(p);
		}
		session.setAttribute("favorite", p);
		request.setAttribute("data", p);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		
		String offset = request.getParameter("offset");
		request.setAttribute("offset", offset);
		request.setAttribute("type", type);
		if(offset != null && Comm.Mobile.equals(isMobile)) {
			return isMobile+"sites/favoritePage";
		}
		return isMobile+"sites/favorite";
	}
	
	public void findJournal(Pager p) {
		List<Favorite> favoriteList = p.getRows();
		if(favoriteList == null || favoriteList.size() == 0) {
            return;
        }
		for(int i=0;i<favoriteList.size();i++) {
			Favorite favorite = favoriteList.get(i);
			String id = favorite.getDocId();
			Map<String, Object> doc=detailService.getDoc(id);
			JournalUrl mainLink = journalLinkService.searchMainLink(id);
			doc.put("mainLink", mainLink);
			List<JournalUrl> list = journalLinkService.searchDbLinks(id);
			doc.put("dbLinks", list);
			JournalImage jImage = journalImageService.findImage(id);
			if(jImage!=null&&jImage.getLogo()!=null){
				if(jImage.getLogo().length>0){
					doc.put("jImage", jImage);
				}
			}
			try {
				Map<String,ShouluMap> map = DetailParserUtil.parseShoulu((List<Map<String, Object>>) doc.get("shouLu"));
				favorite.setShoulu(map);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			favorite.setDocJournal(doc);
			favoriteList.set(i, favorite);
		}
		p.setRows(favoriteList);
	}
	
	/**
	 * 取消收藏
	 * @param id
	 * @return
	 */
	@RequestMapping(value = { "/unfavorite/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult unfavorite(@PathVariable String id,HttpSession session){
		favoriteService.delete(id,MemberIdFromSession.getMemberId(session)+"");
		return new AjaxResult("取消收藏成功!");
	}
	
	@Autowired
	private JournalLinkServiceI journalLinkService;
	
	@Autowired
	private DetailServiceI detailService;
	
	@Autowired
	private JournalImageServiceI journalImageService;
	/**
	 * 添加收藏
	 * @param id
	 * @param session
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/favorite/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult favorite(@PathVariable String id,HttpSession session,HttpServletRequest request){
		int source = (int) session.getAttribute("source");
		String type = request.getParameter("type");
		if(StringUtils.isEmpty(type)) { //文章收藏
			List<SearchDocument> list=(List<SearchDocument>)session.getAttribute(Comm.DOC_SESSION_CACHE);
			Pager p= (Pager) session.getAttribute("favorite");
			if(list == null && p == null) {
				return AjaxResult.errorResult("由于您长时间没有操作，链接已失效，请刷新页面。");
			}
			String docId;
			if(list != null) {
				for(SearchDocument doc : list){
					docId=doc.getId();
					if(docId.equals(id)){
//						if(source == 1) {
//							doc.setHref("http://www.spischolar.com/scholar/bingRedirect/"+docId+"?batchId=");
//						}
						Favorite f=new Favorite();
						doc.setFavorite(true);
						f.setType(1);
						f.setContent(JsonUtil.obj2Json(doc));
						f.setMemberId(MemberIdFromSession.getMemberId(session));
						f.setDocId(docId);
						try{
							favoriteService.save(f);
							return new AjaxResult("添加成功!");
						}catch(OperationException e){
							return AjaxResult.errorResult(e.getMessage());
						}
					}
				}
			}
			if(p != null) {
				for(int i =0; i < p.getRows().size(); i++) {
					Favorite f = (Favorite) p.getRows().get(i);
					if(f.getDocId().equals(id)) {
						try{
							favoriteService.save(f);
							return new AjaxResult("添加成功!");
						}catch(OperationException e){
							return AjaxResult.errorResult(e.getMessage());
						}
					}
				}
			}
		} else {//期刊收藏
			String title = request.getParameter("title");
			Favorite f=new Favorite();
			f.setContent(title);
			f.setMemberId(MemberIdFromSession.getMemberId(session));
			f.setDocId(id);
			f.setType(2);
			favoriteService.save(f);
		}
		return new AjaxResult("添加成功!");
	}
	
	
	/**
	 * 反馈情况列表
	 * @return
	 */
	@RequestMapping(value = { "/feedbacks" }, method = { RequestMethod.GET })
	public String feedbacks(HttpServletRequest request,HttpSession session){
		Pager p=feedbackService.findPager(MemberIdFromSession.getMemberId(session));
		request.setAttribute("data", p);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/feedbacks";
	}
	
	/**反馈详情*/
	@RequestMapping(value = { "/feedback/{id}" }, method = { RequestMethod.GET })
	public String feedback(@PathVariable Integer id,HttpServletRequest request){
		Feedback fb=feedbackService.get(id);
		request.setAttribute("feedback", fb);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		return isMobile+"sites/feedback";
	}
	/**
	 * 前台ajax获取反馈列表
	 * @return
	 */
	@RequestMapping(value = { "/findFeedbacks" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult findFeedbacks(HttpServletRequest request,HttpSession session){
		Pager p=feedbackService.findPager(MemberIdFromSession.getMemberId(session));
		request.setAttribute("data", p);
		String result = JsonUtil.obj2Json(p.getRows());
		return new AjaxResult(result);
	}
	/**
	 * 前台ajax获取反馈详细
	 * @return
	 */
	@RequestMapping(value = { "/findFeedback/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult findFeedback(@PathVariable Integer id,HttpServletRequest request){
		List<FeedbackInfo> list=feedbackService.findListInfo(id);
		String result = JsonUtil.obj2Json(list);
		return new AjaxResult(result);
	}
	/**
	 * 前台反馈邮箱
	 * @return
	 */
	@RequestMapping(value = { "/feedbackEmail" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult feedbackEmail(HttpServletRequest request){
		int id = Integer.parseInt(request.getParameter("id"));
		Feedback feedback = feedbackService.get(id);
		String email = request.getParameter("email");
		feedback.setContact(email);
		feedbackService.updateFeedbackEmail(feedback);
		return new AjaxResult("");
	}
	
	/**
	 * 用户提交反馈
	 * @param feedback
	 * @param session
	 * @return
	 */
	@RequestMapping(value = { "/feedback" }, method = { RequestMethod.POST })
	@ResponseBody
	public String feedback(HttpServletRequest request,Feedback feedback,HttpSession session,@RequestParam(value = "file", required = false) MultipartFile file){
		log.info("进入feedback");
		Member member = (Member) session.getAttribute(Comm.MEMBER_SESSION_NAME);
		FeedbackInfo feedbackInfo = new FeedbackInfo();
		feedbackInfo.setContent(request.getParameter("contents"));
		feedbackInfo.setType(1);
		if (file != null && !file.isEmpty()) {
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			File attachFile=FileUtil.createNewFile(realPath, file.getOriginalFilename());//创建一个新文件
			try {
				FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
				String savePath=dailyPath+attachFile.getName();
				feedbackInfo.setOptions(savePath);//附件地址路径
			} catch (IOException e) {
				log.error("文件保存失败!",e);
			}
		}
		Date time = new Date();
		feedback.setMemberId(MemberIdFromSession.getMemberId(session));
		feedback.setTime(time);
		feedback.setIsProcess((short) 0);
		if(feedback.getId() == null) {
			feedbackService.save(feedback);
		} else {
			feedbackService.updateTime(feedback);
		}
		feedbackInfo.setFeedbackId(feedback.getId());
		feedbackInfo.setTime(time);
		feedbackService.saveInfo(feedbackInfo);
		if(member != null) {
			mailService.send("spischolar@126.com", "用户反馈提醒", "<p>"+"用户"+"<span style='color: blue;'>"+member.getUsername()+"</span>"+"提交了新的用户反馈，请及时处理！</p>", null);
		} else {
			mailService.send("spischolar@126.com", "用户反馈提醒", "<p><span style='color: blue;'>游客</span>"+"提交了新的用户反馈，请及时处理！</p>", null);
		}
		
		List<FeedbackInfo> list=feedbackService.findListInfo(feedback.getId());
		String result = JsonUtil.obj2Json(list);
		return result;
	}
	
	/**
	 * 文件上传
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/upload" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult upload(HttpServletRequest request){

		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {

				// 由CommonsMultipartFile继承而来,拥有上面的方法.
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
					realPath+=dailyPath;
					FileUtil.createDir(new File(realPath));//创建目录
					File attachFile=FileUtil.createTimeNewFile(realPath, file.getOriginalFilename());//创建一个新文件
					try {
						FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
						String savePath=dailyPath+attachFile.getName();
						return AjaxResult.dataResult("上传成功!", savePath);
					} catch (IOException e) {
						log.error("文件保存失败!",e);
					}
				}
			}
		}
		return AjaxResult.errorResult("没有上传文件");
	}	
	
	
	@RequestMapping(value = { "/img" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult img(String verify,HttpSession session,HttpServletRequest request){
		String code=(String)session.getAttribute("backend:code");
		
		if(null==verify||!verify.equalsIgnoreCase(code)){
			return new AjaxResult("验证码错误!");
		}
		session.removeAttribute("acquisition");
		request.getSession().removeAttribute("journalMap");
		request.getSession().removeAttribute("searchMap");
		return new AjaxResult("验证成功！");
	}
	
	/**
	 * 手机版个人中心personal
	 */
	@RequestMapping(value = { "/personal" }, method = { RequestMethod.GET })
	public String personal(HttpServletRequest request){
		Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		request.setAttribute("mindex", 3);
		if(user == null) {
			return Comm.Mobile + "sites/personal";
		} else {
			return Comm.Mobile + "sites/personalout";
		}
	}
	/**
	 * 提交反馈
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/editFeedback" }, method = { RequestMethod.GET })
	public String editFeedBack(HttpServletRequest request){
		return Comm.Mobile+"sites/editFeedback";
	}
	/**
	 * 账户管理
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/account" }, method = { RequestMethod.GET })
	public String account  (HttpServletRequest request){
		return Comm.Mobile+"sites/account";
	}
	
	/**
	 * 下载点击量统计
	 * @param session
	 * @param request
	 * @return
	 * @throws SystemException
	 */
	@RequestMapping(value = { "/downloadRecord" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult downloadRecord(HttpSession session,HttpServletRequest request) throws SystemException{
		DownloadInfo info = new DownloadInfo();
		String title = request.getParameter("title");
		String url = request.getParameter("url");
		String ip =IpUtil.getIpAddr(request); 
		Member user=(Member)request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		info.setIp(ip);
		info.setTitle(title);
		info.setUrl(url);
		info.setTime(new Date());
		if(user != null) {
			info.setUsername(user.getUsername());
			info.setSchool(user.getSchool());
			info.setSchoolFlag(user.getSchoolFlag());
		} else {
			OrgBO org = cacheModule.findOrgByIpFromCache(ip);  //通过IP获得机构名
			info.setSchool(org.getName());
			info.setSchoolFlag(org.getFlag());
		}
		info.setType(0);
		downloadRecordService.insertDownloadRecordInfo(info);
		return new AjaxResult("");
	}
	
	/**
	 * 输入框弹出检索历史
	 * @return
	 */
	@RequestMapping(value = { "/historyForSearch" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult findHistoryForSearch(HttpSession session,HttpServletRequest request){
		String keyword = request.getParameter("keyword");
		String type = request.getParameter("type");
		List<History> list =historyService.findListForSearch(MemberIdFromSession.getMemberId(session),keyword,type);  
		String result = JsonUtil.obj2Json(list);
		return new AjaxResult(result);
	}
	
	/**
	 * 输入框弹出检索历史
	 * @return
	 */
	@RequestMapping(value = { "/version" }, method = { RequestMethod.POST })
	@ResponseBody
	public String version(HttpSession session,HttpServletRequest request){
		String result = "2.1.0";
		return result;
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/downloadPac" }, method = { RequestMethod.GET })
	public void downLoad(HttpServletRequest request ,HttpServletResponse response){
		
		String version = request.getParameter("version");
		
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
		try{
			response.setContentType("application/octet-stream"); 
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", "proxy111.pac"));
	    	File file = new File("C:/Users/Administrator/Desktop/acc32/proxy.pac");
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	
	    }finally{
	    	if(bis!=null){
	    		try{
	    			bis.close();
	    			bis=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	if(bos!=null){
	    		try{
	    			bos.close();
	    			bos=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    }
	}
	
	/**
	 * 文献互助中心
	 */
	@RequestMapping(value = { "/diliveryHelp" }, method = { RequestMethod.GET })
	public String diliveryHelp(HttpServletRequest request,HttpSession session){
		String val = request.getParameter("val");
		if(val == null || "".equals(val)) {
            val = null;
        }
		String offset = request.getParameter("offset");
		String processType = request.getParameter("type");
		if(SimpleUtil.strIsNull(processType)) {
            processType="1";
        }
		Pager p=docDiliveryService.findPageHelp(Integer.parseInt(processType),val);
		request.setAttribute("data", p);
		request.setAttribute("offset", offset);
		request.setAttribute("type",processType);
		request.setAttribute("val", val);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		if(offset != null && Comm.Mobile.equals(isMobile)) {
			return isMobile+"sites/diliveryPageHelp";
		}
		return isMobile+"sites/diliveryHelp";
	}
	
	/**
	 * 验证是否可以互助
	 * @return
	 */
	@RequestMapping(value = { "/diliveryHelp/check" }, method = { RequestMethod.GET })
	@ResponseBody
	public String check(int id,HttpServletRequest request){
		String memberId = (String) request.getSession().getAttribute("spischolarID");
		String result = docDiliveryService.check(id,Integer.parseInt(memberId));
//		if(result == 1000) {
//			return "每个用户只能同时应助一条数据！";
//		}
		return result;
	}
	
	/**
	 * 取消应助
	 * @return
	 */
	@RequestMapping(value = { "/diliveryHelp/removeHelp" }, method = { RequestMethod.GET })
	@ResponseBody
	public String removeHelp(int id,HttpServletRequest request){
		String memberId = (String) request.getSession().getAttribute("spischolarID");
		long result = docDiliveryService.removeHelp(id,Integer.parseInt(memberId));
		return result+"";
	}
	
	/**
	 * 文件上传
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/uploadDilivery" }, method = { RequestMethod.POST })
	@ResponseBody
	public String process(String docid,HttpServletRequest request,HttpSession session){
		AjaxResult result = new AjaxResult("fail");
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(session.getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 由CommonsMultipartFile继承而来,拥有上面的方法.
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
					realPath+=dailyPath;
					FileUtil.createDir(new File(realPath));//创建目录
					File attachFile=FileUtil.createNewFile(realPath, file.getOriginalFilename());//创建一个新文件
					try {
						FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
						String savePath=dailyPath+attachFile.getName();
						docDiliveryService.updatePath(savePath, Long.parseLong(docid));
					} catch (IOException e) {
						log.error("文件保存失败!",e);
					}
				}
			}
		}
		result.setMessage("success");
		return result.toString();
	}

	@RequestMapping("/showFile")
	public void getFile(String filename,HttpServletRequest request,HttpServletResponse response){
		String filePath = FileUtil.getSysUserHome()+filename;
		InputStream inputStream = null;
		OutputStream writer = null;
		try {
			inputStream = new FileInputStream(new File(filePath));
			writer = response.getOutputStream();

			byte[] buf = new byte[1024];
			int len = 0;
			while ((len = inputStream.read(buf)) != -1) {
				writer.write(buf, 0, len);
			}
			inputStream.close();
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		} finally{
			try {
				if(inputStream != null){
					inputStream.close();
				}
				if(writer != null){
					writer.close();
				}
			} catch (IOException e) {
				log.error(e.getMessage(),e);
			}
		}
	}

	@RequestMapping(value = { "/updateShowQunwp" }, method = { RequestMethod.GET })
	@ResponseBody
	public String updateShowQunwp(HttpSession session){
		String id = (String) session.getAttribute("spischolarID");
		if (id!= null){
			userService.updateShowQunwp(Integer.parseInt(id));
		}
		Member member = (Member) session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if (member!=null){
			member.setShowQunwpa(false);
			session.setAttribute(Comm.MEMBER_SESSION_NAME,member);
			userService.updateShowQunwp(member.getId());
		}
		session.setAttribute("showQunwpa", false);
		return "ok";
	}
}
