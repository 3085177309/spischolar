package com.wd.comm.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.wd.comm.context.SystemContext;

public class PagerFiler implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Object obj = request.getParameter("offset");
		if (null != obj) {
			SystemContext.setOffset(Integer.parseInt(obj.toString()));
		}
		obj = request.getParameter("size");
		if (null != obj) {
			SystemContext.setPageSize(Integer.parseInt(obj.toString()));
		}
		chain.doFilter(request, response);
		SystemContext.removeOffset();
		SystemContext.removePageSize();
	}

	@Override
	public void destroy() {

	}

}
