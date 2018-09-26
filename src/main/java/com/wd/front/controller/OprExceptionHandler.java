package com.wd.front.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.wd.front.service.OperationException;

/**
 * 用户操作异常全局处理
 * @author Administrator
 *
 */
public class OprExceptionHandler implements HandlerExceptionResolver{

	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		if(ex instanceof OperationException){
			request.setAttribute("msg", ex.getMessage());
			return new ModelAndView("commServicePage/error");
		}
		return null;
	}

}
