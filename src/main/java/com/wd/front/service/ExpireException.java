package com.wd.front.service;

/**
 * 缓存过期
 * @author Shenfu
 *
 */
public class ExpireException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public ExpireException(){
		super();
	}
	
	public ExpireException(String msg){
		super(msg);
	}
	
	public ExpireException(Throwable t){
		super(t);
	}
	
	public ExpireException(String msg,Throwable t){
		super(msg,t);
	}

}
