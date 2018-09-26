package com.wd.backend.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wd.util.*;
import org.apache.commons.io.FileUtils;
import org.apache.cxf.common.util.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.PropertiesEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.model.Department;
import com.wd.backend.model.Org;
import com.wd.backend.service.OrgServiceI;
import com.wd.backend.service.UserRequestServiceI;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;

/**
 * 机构信息管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/backend/org")
public class OrgController {
	
	private static final Logger log=Logger.getLogger(OrgController.class);

	@Autowired
	private OrgServiceI orgService;
	
	@Autowired
	private CacheModuleI cacheModule;
	
	/**
	 * 日期格式转换器
	 * @author Shenfu
	 *
	 */
	static class DatePropertyEditor extends PropertiesEditor {
		
		private String format;
		
		private DateFormat dateFormat;

		public DatePropertyEditor(String format){
			this.format=format;
			dateFormat=new SimpleDateFormat(format);
		}

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			if(StringUtils.isEmpty(text)){
				setValue(null);
			}
			try {
				setValue(dateFormat.parse(text));
			} catch (ParseException e) {
				throw new IllegalArgumentException("不合法的日期格式,日期格式："+format);
			}
		}

		@Override
		public String getAsText() {
			Object value=getValue();
			if(value==null){
				return null;
			}else{
				return dateFormat.format((Date)value);
			}
		}
		
	}
	
	@InitBinder
	protected void initBinder(HttpServletRequest request,ServletRequestDataBinder binder) throws Exception {
	  binder.registerCustomEditor(Date.class, new DatePropertyEditor("yy-MM-dd"));
	 }

	@RequestMapping(value = { "/index" }, method = { RequestMethod.GET })
	public String index() {
		return "backend/org/index";
	}
	
	@RequestMapping(value = { "/list/home/{orgId}" }, method = { RequestMethod.GET })
	public String home(@PathVariable Integer orgId, HttpServletRequest request,HttpSession session){
		OrgBO org=orgService.detail(orgId);
		session.setAttribute(Comm.ORG_SESSION_NAME, org);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/";
	}
	
	@RequestMapping(value = { "/list/backendHome/{orgId}" }, method = { RequestMethod.GET })
	public String backendHome(@PathVariable Integer orgId, HttpSession session){
		OrgBO org=orgService.detail(orgId);
	//	session.setAttribute("backend:loginOrg", org);
		session.setAttribute("org", org);
	//	session.setAttribute("backendOrgFlag", org.getFlag());
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/index";
	}

	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String key,String status,String offset,HttpServletRequest request) {
		Org org =(Org)request.getSession().getAttribute("org");
		request.setAttribute("show",5);
		//如果登录后台帐号是本公司帐号，则显示列表页面，如果是别的学校帐号，则只显示该学习详细信息页面
		if("wdkj".equals(org.getFlag())){
			request.setAttribute("key", key);
			if("1".equals(status)){
				request.setAttribute("statusName", "购买");
			}else if("2".equals(status)){
				request.setAttribute("statusName", "试用");
			}else if("0".equals(status)){
				request.setAttribute("statusName", "停用");
			}else if("3".equals(status)){
				request.setAttribute("statusName", "过期");
			}else if("5".equals(status)){
				request.setAttribute("statusName", "全部");
			}else{
				request.setAttribute("statusName", "全部");
			}
			request.setAttribute("status", status);
			request.setAttribute("offset", offset);
			Pager pager = orgService.searchPager(key,status);
			request.setAttribute("orgPager", pager);
			return "back/org/list";
		}else{
			return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/list/detail/"+org.getId();
		}
		
	}
	/**
	 * 基本信息
	 * @param orgId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/list/detail/{orgId}" }, method = { RequestMethod.GET })
	public String detail(@PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("show",5);
		Org org =(Org)request.getSession().getAttribute("org");
		request.setAttribute("org", orgService.detail(orgId));
		if("wdkj".equals(org.getFlag())){
			return "back/org/information";
		}else{
			return "back/org/informationOrg";
		}
		
	}
	
	@RequestMapping(value = { "/list/add" }, method = { RequestMethod.GET })
	public String add(HttpServletRequest request) {
		request.setAttribute("show",5);
		request.setAttribute("tmpls", getTemplates(request));
		return "back/org/add";
	}

	/**
	 * 添加一个机构
	 * @param org
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/list/addin" }, method = { RequestMethod.POST })
	public String add(OrgBO org,Map<String,String> params, HttpServletRequest request) {
		Integer orgId=null;
		request.setAttribute("org", org);
		try {
			orgService.add(org);
			orgId=org.getId();
			request.setAttribute("orgId", orgId);
		} catch (SystemException e) {//添加数据失败
			request.setAttribute("tmpls", getTemplates(request));
			request.setAttribute("prepareOpt", "add");
			request.setAttribute("error", e.getMessage());
			return "back/org/add";
		}
		cacheModule.reloadAllOrgCache();
		request.setAttribute("msg", "机构添加成功");
		request.setAttribute("location", "backend/org/list");
		return "backend/success";
	}
	
	/**
	 * 修改编辑一个机构
	 * @param org
	 * @param response
	 */
	@RequestMapping(value = { "/list/updateOrg" }, method = { RequestMethod.POST })
	public String updateOrg(OrgBO org,HttpServletRequest request, HttpServletResponse response) {
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		Integer orgId=org.getId();
		
		Org model = new Org();
		BeanUtils.copyProperties(org, model);
		SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
		boolean flag = schoolBackRequest.userRequest(request,JsonUtil.obj2Json(model));
		if(!flag) {
			request.setAttribute("prepareOpt", "add");
			request.setAttribute("error", "已成功发送给管理员审核！");
			request.setAttribute("org", orgService.detail(orgId));
			return "back/org/informationOrg";
		}
		
		try {
			orgService.edit(org,backloginOrg.getFlag());
		} catch (SystemException e) {
			log.error("数据修改出错!",e);
			//request.setAttribute("tmpls", getTemplates(request));
			request.setAttribute("prepareOpt", "add");
			request.setAttribute("error", e.getMessage());
			request.setAttribute("org", org);
			return "back/org/information";
		}
		cacheModule.reloadOrgCache(orgId);
		cacheModule.reloadOrgProductCache(org.getFlag());
		//如果后台登录的是本公司帐号，则会执行修改产品信息，则需要重新加载产品缓存
		//if("wdkj".equals(backloginOrg.getFlag())){
			//cacheModule.reloadOrgProductCache(org.getFlag());
		//}
		request.setAttribute("msg", "机构修改成功");
		request.setAttribute("location", "backend/org/list");
		return "backend/success";
	}
	
	
	
	/**
	 * 获取所有的模版名称
	 * @param request
	 * @return
	 */
	private List<String> getTemplates(HttpServletRequest request){
		String tempPath=request.getSession().getServletContext().getRealPath("/sites")+File.separator;
		File dir=new File(tempPath);
		List<String> tmpls=new ArrayList<String>();
		if(dir.isDirectory()){
			for(File file:dir.listFiles()){
				if(file.isDirectory()&&checkTmplDir(file)){
					tmpls.add(file.getName());
				}
			}
		}
		return tmpls;
	}
	
	/**
	 * 检测文件是否是模板目录
	 * 如果是期刊导航，必须包含index.jsp,list.jsp,overview.jsp
	 * 如果是轻学术发现，必须包含docIndex.jsp,docList.jsp,
	 * @param dir
	 * @return
	 */
	private boolean checkTmplDir(File dir){
		int index=0;
		for(File file:dir.listFiles()){
			String fileName=file.getName();
			if(file.isFile()&&("index.jsp".equals(fileName) || "list.jsp".equals(fileName)
					|| "overview.jsp".equals(fileName) || "docIndex.jsp".equals(fileName)
					|| "docList.jsp".equals(fileName))){
				index++;
			}
		}
		if(index>=5){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 检测机构标识是否存在
	 * @param flag
	 * @param response
	 */
	@RequestMapping(value = { "/list/checkFlagExist" }, method = { RequestMethod.GET })
	public void checkFlagExist(String flag,HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		String rs="{}";
		try{
			if(orgService.findExistsFlag(flag)){
				rs="{'exist':1}";
			}else{
				rs="{'exist':0}";
			}
		}catch(Exception e){
			rs="{'exist':1}";
		}
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 检测机构是否已经存在
	 * @param orgName
	 * @param response
	 */
	@RequestMapping(value = { "/list/checkOrgNameExist" }, method = { RequestMethod.GET })
	public void checkOrgNameExist(String orgName,HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		String rs="{}";
		try{
			if(orgService.findOrgNameExist(orgName)){
				rs="{'exist':1}";
			}else{
				rs="{'exist':0}";
			}
		}catch(Exception e){
			rs="{'exist':1}";
		}
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 检测IP地址是否已经存在
	 * @param startIp
	 * @param endIp
	 */
	@RequestMapping(value = { "/list/checkIpRangesExist" }, method = { RequestMethod.GET })
	public void checkIpRangesExist(Integer orgId,String startIp,String endIp,String ipRanges,String id,HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		String rs="{}";
		try{
			log.info("findIpRangesExist");
			if(orgService.findIpRangesExist(orgId, startIp, endIp)){
				log.info("{'exist':1}");
				rs="{'exist':1}";
				//rs="该ip范围已定义!";
			}else{
				rs="{'exist':0}";
			}
			OrgBO org = new OrgBO();
			org.setIpRanges(ipRanges);
			if(id != null) {
				org.setId(Integer.parseInt(id));
			}
			log.info("validateIpRange");
			orgService.validateIpRange(org);
		}catch(Exception e){
			String mess = e.getMessage();
			log.info(mess);
			rs="{'exist':1}";
			//rs="该ip范围已定义!";
		}
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	
	/**
	 * 学校资源配置
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/resource" }, method = { RequestMethod.GET })
	public String resources(HttpServletRequest request){
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		String dbType = request.getParameter("dbType");
		String orgFlag = backloginOrg.getFlag();
		if(request.getParameter("orgFlag")!=null){
			orgFlag=request.getParameter("orgFlag");
		}
		if(StringUtils.isEmpty(dbType)) {
            dbType="1";
        }
		request.setAttribute("show",5);
		String offset = request.getParameter("offset");
		if(offset != null) {
			request.setAttribute("offsets", "offset="+offset);
		}
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("dbType", dbType);
		OrgBO bo=orgService.findOrgByFlag(orgFlag);
		request.setAttribute("orgName", bo.getName());
		return "back/org/resource";
	}

	/**
	 * 删除一个机构
	 * @param orgId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/delete/{orgId}" }, method = { RequestMethod.GET })
	public String delete(@PathVariable Integer orgId, HttpServletRequest request) {
		orgService.delete(orgId);
		request.setAttribute("prepareOpt", "delOver");
		//跳转到列表页面
		return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/org/list";
	}

	/**
	 * 编辑IP地址变化范围
	 * @param org
	 * @param response
	 */
	@RequestMapping(value = { "/editIpRange" }, method = { RequestMethod.POST })
	public void editIpRange(OrgBO org, HttpServletResponse response) {
		String rs = null;
		try {
			orgService.editIpRange(org);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		if (null == rs) {
			rs = "{}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().println(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	/**
	 * 学院
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/department" }, method = { RequestMethod.GET })
	public String deptartment(HttpServletRequest request){
		request.setAttribute("show",5);
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		request.setAttribute("schoolId", backloginOrg.getId());
		//String schoolId = request.getParameter("schoolId");
		//request.setAttribute("schoolId", schoolId);
		return "back/org/department";
	}
	/**
	 * 根据学校id查学院
	 */
	@RequestMapping(value = { "/department/findDepBySchool" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult findDepBySchool(HttpServletRequest request) {
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		int schoolId = backloginOrg.getId();
		if(request.getParameter("schoolId")!=null&&!"".equals(request.getParameter("schoolId"))){
			schoolId = Integer.parseInt(request.getParameter("schoolId"));
		}
		List<Department> list = orgService.findDepBySchool(schoolId);
		Collections.sort(list);
		String js = JsonUtil.obj2Json(list);
		return new AjaxResult(js);
	}
	/**
	 * 根据学校id添加学院
	 */
	@RequestMapping(value = { "/department/addDep" }, method = { RequestMethod.POST })
	public String addDep(@RequestParam(value = "file", required = false) MultipartFile file,Department department,HttpServletRequest request){
		String path = null;
		if(!file.isEmpty()) {
			//如果上传了文件，先保存
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			//创建目录
			FileUtil.createDir(new File(realPath));
			//创建一个新文件
			File attachFile=FileUtil.createNewFile(realPath, file.getOriginalFilename());
			try {
				FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
			} catch (IOException e) {
				request.setAttribute("error", "上传文件失败！");
				return "back/org/department";
			}
			path = "/upload"+dailyPath+attachFile.getName();
		}
		SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
		boolean flag = false;
		if(path != null) {
			//如果上传了文件，传入文件保存路径
			flag = schoolBackRequest.userRequest(request,path);
		} else {
			//不然就保存json对象
			flag = schoolBackRequest.userRequest(request,JsonUtil.obj2Json(department));
		}
		if(!flag) {
			//判断是否有修改权限
			request.setAttribute("error", "已成功发送给管理员审核！");
			return "back/org/department";
		}
		
		String schoolId = request.getParameter("schoolId");
		String departmentName = request.getParameter("departmentName");
		if(SimpleUtil.strIsNull(schoolId)) {
            schoolId="60";
        }
		request.setAttribute("schoolId", schoolId);
		try {
			InputStream input = file.getInputStream();
			orgService.addDep(input, Integer.parseInt(schoolId), departmentName,path);
		} catch (IOException | NumberFormatException | SystemException e) {
			request.setAttribute("error", e.getMessage());
		}
		return "back/org/department";
		//return UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/org/department";
		//return "redirect:/backend/org/department?schoolId="+schoolId;
	}
	
	/**
	 * 用户请求（添加一个或多个学院）
	 * @param request
	 * @return
	 */
	@RequestMapping(value={"/department/addDep"},method={RequestMethod.GET})
	@ResponseBody
	public AjaxResult addDepByRequest(String path, HttpServletRequest request){
		String id = request.getParameter("requestId");
		userRequestService.updateById(Integer.parseInt(id));
		String schoolId = request.getParameter("schoolId");
		String departmentName = request.getParameter("departmentName");
		if(SimpleUtil.strIsNull(schoolId)) {
            schoolId="60";
        }
		
		if(path != null) {
			File file =  new File(request.getSession().getServletContext().getRealPath("/")+path);
			InputStream input;
			try {
				input = new FileInputStream(file);
				orgService.addDep(input, Integer.parseInt(schoolId), departmentName,path);
			} catch (SystemException e) {
				return new AjaxResult("文本格式内容不正确！");
			}catch (FileNotFoundException e1) {
				return new AjaxResult("文件没找到或已被删除！");
			}
		} else {
			try {
				orgService.addDep(null, Integer.parseInt(schoolId), departmentName,path);
			} catch (NumberFormatException | SystemException e) {
				return new AjaxResult("文本格式内容不正确！");
			}
		}
		return new AjaxResult("用户请求已通过！添加用户成功！");
	}
	
	@RequestMapping(value = {"/department/deleteDepartment"}, method={ RequestMethod.GET })
	@ResponseBody
	public AjaxResult deleteDepartment(Department department,HttpServletRequest request){
		
		SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
		boolean flag = schoolBackRequest.userRequest(request,JsonUtil.obj2Json(department));
		if(!flag) {
			return new AjaxResult(JsonUtil.obj2Json("已成功发送给管理员审核！"));
		}
		//String schoolId = request.getParameter("schoolId");
		//if(SimpleUtil.strIsNull(schoolId)) schoolId="60";
		
		orgService.deleteDepartment(department.getDepartmentId());
		List<Department> list = orgService.findDepBySchool(department.getSchoolId());
		Collections.sort(list);
		String js = JsonUtil.obj2Json(list);
		
		String requestId = request.getParameter("requestId");
		if(!SimpleUtil.strIsNull(requestId)) {
			userRequestService.updateById(Integer.parseInt(requestId));
			js="用户请求已通过！院系删除成功！";
		}
		return new AjaxResult(js);
	}
	
	@RequestMapping(value = {"/department/updateDepartment"}, method={ RequestMethod.GET })
	@ResponseBody
	public AjaxResult updateDepartment(Department department,HttpServletRequest request){
		SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
		boolean flag = schoolBackRequest.userRequest(request,JsonUtil.obj2Json(department));
		if(!flag) {
			return new AjaxResult("已成功发送给管理员审核！");
		}
		
//		String departmentId = request.getParameter("departmentId");
//		String departmentName = request.getParameter("departmentName");
	//	String schoolId = request.getParameter("schoolId");
	//	if(SimpleUtil.strIsNull(schoolId)) schoolId="60";
		orgService.updateDepartment(department.getDepartmentName(),department.getDepartmentId());
		List<Department> list = orgService.findDepBySchool(department.getSchoolId());
		Collections.sort(list);
		String js = JsonUtil.obj2Json(list);
		
		String requestId = request.getParameter("requestId");
		if(!SimpleUtil.strIsNull(requestId)) {
			userRequestService.updateById(Integer.parseInt(requestId));
			js="用户请求已通过！院系修改成功！";
		}
		return new AjaxResult(js);
	}
	
	/**
	 * 用户请求（修改编辑一个机构）
	 * @param request
	 * @return
	 */
	@RequestMapping(value={"/list/updateOrg"},method={RequestMethod.GET})
	@ResponseBody
	public AjaxResult updateOrgByRequest(OrgBO org, HttpServletRequest request){
		String id = request.getParameter("requestId");
		userRequestService.updateById(Integer.parseInt(id));
		
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		try {
			orgService.edit(org,org.getFlag());
		} catch (SystemException e) {
			return new AjaxResult("数据修改出错!");
		}
		cacheModule.reloadOrgCache(org.getId());
		//如果后台登录的是本公司帐号，则会执行修改产品信息，则需要重新加载产品缓存
		if("wdkj".equals(backloginOrg.getFlag())){
			cacheModule.reloadOrgProductCache(org.getFlag());
		}
		return new AjaxResult("用户请求已通过！机构修改成功！");
	}
	
	@Autowired
	UserRequestServiceI userRequestService;


}
