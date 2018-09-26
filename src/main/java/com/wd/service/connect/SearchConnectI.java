package com.wd.service.connect;

import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

@WebService
@SOAPBinding(style = Style.RPC)
public interface SearchConnectI {

	public String executeSearch(@WebParam(name = "param") String requestParam);
}
