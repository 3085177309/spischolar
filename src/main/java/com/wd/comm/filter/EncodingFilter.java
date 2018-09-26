package com.wd.comm.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 字符编码过滤器
 * 
 * @author pan
 * 
 */
public class EncodingFilter implements Filter {

	private String encoding;

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse resp = (HttpServletResponse) arg1;

		req.setCharacterEncoding(encoding);
		resp.setCharacterEncoding(encoding);
		if ("get".equalsIgnoreCase(req.getMethod().trim().toString())) {
			encoding(req);
		}
		arg2.doFilter(req, arg1);
	}

	private void encoding(HttpServletRequest request) {
		Enumeration<?> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String[] values = request.getParameterValues(names.nextElement()
					.toString());
			for (int i = 0; i < values.length; ++i) {
				try {
					values[i] = new String(values[i].getBytes("ISO-8859-1"),
							encoding);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		this.encoding = arg0.getInitParameter("encoding");
	}

}
