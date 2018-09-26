package com.wd.backend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/backend/proxy")
public class ProxyController {
	
	@RequestMapping(value = { "/index" }, method = { RequestMethod.GET })
	public String index() {
		return "backend/proxy/index";
	}
	
	@RequestMapping(value = { "/detail" }, method = { RequestMethod.GET })
	public String detail(){
		return "backedn/proxy/detail";
	}

}
