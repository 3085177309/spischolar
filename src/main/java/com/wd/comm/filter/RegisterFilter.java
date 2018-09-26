package com.wd.comm.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Created by DimonHo on 2018/1/17.
 */
public class RegisterFilter implements Filter {

    private String casServerRegisterUrl;

    private String serverName;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.casServerRegisterUrl = filterConfig.getInitParameter("casServerRegisterUrl");
        this.serverName = filterConfig.getInitParameter("serverName");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        final HttpServletRequest request = (HttpServletRequest) servletRequest;
        final HttpServletResponse response = (HttpServletResponse) servletResponse;
        String url = this.casServerRegisterUrl + "?redirect_url="+URLEncoder.encode(this.serverName,"utf-8");
        response.sendRedirect(url);
    }


    @Override
    public void destroy() {

    }
}
