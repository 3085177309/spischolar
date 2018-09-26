package com.wd.front.interceptor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.bo.PersonBO;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Person;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Quota;
import com.wd.comm.Comm;
import com.wd.comm.filter.NewPermissionFilter;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;

public class BackLoginInterceptor extends HandlerInterceptorAdapter{
	private static final Logger log=Logger.getLogger(BackLoginInterceptor.class);
	@Autowired
	private CacheModuleI cacheModule;
	@Autowired
	private OrgInfoServiceI orgInfoService;
	private AntPathMatcher antPathMatcher = new AntPathMatcher();
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
		long startTimne = System.currentTimeMillis();
		//req.getSession().setMaxInactiveInterval(15*60);    //设置session时长，每次访问之后重新设置
		
		List<Org> orgList = orgInfoService.findAll();
		List<Org> pList = orgInfoService.findProvince();
		Collections.sort(orgList);
		req.getSession().setAttribute("orgList", orgList);
		req.getSession().setAttribute("pList", pList);
		
		String reqPath = req.getServletPath();
		Org org =(Org)req.getSession().getAttribute("org");
		List<Quota> quotas = cacheModule.findQuotaByOrgIdFromCache(org.getId());
		req.getSession().setAttribute("quotas", quotas);
		List<Powers> powerList = cacheModule.findPowersByOrgIdFromCache(org.getId());
		// 需要进行权限判断
		boolean hasPermission = false;
		for (Powers power : powerList) {
			if (antPathMatcher.match("/" + power.getPermissionUrl(), reqPath)) {
				hasPermission = true;
				break;
			}
		}
		if(reqPath.contains("/backend/index")) {
			hasPermission = true;
		}
		if (!hasPermission) {
			long endTime = System.currentTimeMillis();
//			System.out.println("用时=" + ((endTime - startTimne) / 1000) + "秒");
			return false;
		}
		Map<String,List<Powers>> permission = new HashMap<String,List<Powers>>();
		List<Powers> permissionList2 = new ArrayList<Powers>();
		List<Powers> permissionList3 = new ArrayList<Powers>();
		List<Powers> permissionList4 = new ArrayList<Powers>();
		List<Powers> permissionList5 = new ArrayList<Powers>();
		List<Powers> permissionList6 = new ArrayList<Powers>();
		List<Powers> permissionList7 = new ArrayList<Powers>();
		List<Powers> permissionList8 = new ArrayList<Powers>();
		for(Powers po : powerList){
			if(po.getPid()==2){
				permissionList2.add(po);
			}
			if(po.getPid()==3){
				permissionList3.add(po);
			}
			if(po.getPid()==4){
				permissionList4.add(po);
			}
			if(po.getPid()==5){
				permissionList5.add(po);
			}
			if (po.getPid() == 6) {
				permissionList6.add(po);
			}
			if (po.getPid() == 7) {
				permissionList7.add(po);
			}
			if (po.getPid() == 8) {
				permissionList8.add(po);
			}
		}
		permission.put("wzgk", permissionList2);
		permission.put("llfx", permissionList3);
		permission.put("yhfx", permissionList4);
		permission.put("nrfx", permissionList5);
		permission.put("xxgl", permissionList6);
		permission.put("xtgl", permissionList7);
		permission.put("xtrz", permissionList8);
		req.getSession().setAttribute("permission", permission);
		long endTime = System.currentTimeMillis();
		log.info("BackLoginInterceptor用时=" + ((endTime - startTimne) / 1000) + "秒");
		return true;
	}
}
