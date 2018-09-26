package com.wd.backend.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;

@Controller
@RequestMapping("/backend/cache")
public class CacheCotroller {

	@Autowired
	private CacheModuleI cacheModule;

	/**
	 * 机构缓存重加载
	 * 
	 * @param id
	 * @throws IOException
	 */
	@RequestMapping(value = { "/orgCacheReload/{id}" }, method = { RequestMethod.GET })
	public void clearOrgCache(@PathVariable Integer id, HttpServletResponse response) throws IOException {
		cacheModule.reloadOrgCache(id);
		response.getWriter().print("{}");
	}

	@RequestMapping(value = { "/overallSituation/reload" }, method = { RequestMethod.GET })
	public void reloadOverallSituationCache(HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String rs = "{}";
		try {
			cacheModule.reloadOverallSituationCache();
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.getWriter().print(rs);
	}
}
