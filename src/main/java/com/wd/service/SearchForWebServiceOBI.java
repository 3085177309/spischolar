package com.wd.service;

import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
/**
 * 韩国云主机谷歌接口地址
 * @author hadoop
 *
 */
@WebService
@SOAPBinding(style = Style.RPC)
public interface SearchForWebServiceOBI {

	public String search(@WebParam(name = "param") String requestParam);
	
	/**
	 * 清除缓存
	 * @param validateCode 验证码
	 * @return
	 */
	public Boolean cleanCache(@WebParam(name = "param") String validateCode);
}
