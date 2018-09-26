package com.wd.util;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Person;
import com.wd.backend.model.UserRequest;
import com.wd.backend.service.UserRequestServiceI;
import com.wd.comm.Comm;

/**
 * 学校后台（用户请求）
 * @author istrator
 *
 */
public class SchoolBackRequest {
	
	
	
	public boolean userRequest(HttpServletRequest request,String paramsJson){
		UserRequestServiceI userRequestService = SpringContextUtil.getBean(UserRequestServiceI.class);
		Org org = (Org) request.getSession().getAttribute("org");
		if("wdkj".equals(org.getFlag())) {
			return true;
		}
		String url = request.getRequestURL().toString();//访问页面
		Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
//		Person p = (Person) request.getSession().getAttribute("person");
		//Enumeration en = request.getParameterNames();
		
		Map<String, String[]> params = request.getParameterMap();  
	    String queryStrings = "";
	    
	    for (String key : params.keySet()) {
	    	String[] values = params.get(key);
	    	for (int i = 0; i < values.length; i++) {
	    		String value = values[i];
	    		queryStrings += key + "=" + value + "&";
	    	}
	    }
	    UserRequest userRequest = new UserRequest();
	    userRequest.setUrl(url+"?"+queryStrings);
	    userRequest.setTime(new Date());
	    userRequest.setParam(paramsJson);
	    userRequest.setSchool(org.getName());
	    userRequest.setMemberId(p.getId());
	    String function = null;
	    if(url.contains("org/list")) {
            function = "学校信息";
        }
	    if(url.contains("org/department")) {
            function = "学院信息";
        }
	    if(url.contains("member/list")) {
            function = "用户信息";
        }
	    
	    if(url.contains("update")) {
	    	function += "修改";
	    } else if(url.contains("add")) {
	    	function += "添加";
	    } else if(url.contains("delete")) {
	    	function += "删除";
	    } 
	    
	    if(url.contains("addUsers")) {
	    	function = "批量添加用户";
	    }
	    if(url.contains("org/department/addDep") && paramsJson.contains("/upload/")) {
	    	function = "批量添加学院";
	    }
	    userRequest.setFunction(function);
	    userRequestService.insert(userRequest);
	    //response.sendRedirect(request.getContextPath()+"/user/login");
		return false;
	}

}
