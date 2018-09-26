package com.wd.front.service;

/**
 * 用户操作异常
 * @author Administrator
 *
 */
public class OperationException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public OperationException(){
		super();
	}
	
	public OperationException(String msg){
		super(msg);
	}
	
	public OperationException(Throwable t){
		super(t);
	}
	
	public OperationException(String msg ,Throwable t){
		super(msg,t);
	}

}
