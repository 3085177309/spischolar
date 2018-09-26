package com.wd.util;

import net.sf.json.JSONObject;

public class AjaxResult{
	
	private static final int ERROR=0;
	
	private static final int SUCCESS=1; 

	/**
	 * 状态
	 */
	private Integer status=SUCCESS;
	
	/**消息内容*/
	private String message;
	
	/**跳转地址*/
	private String redirect;
	
	/**数据*/
	private String data;
	
	public static AjaxResult errorResult(String msg){
		return new AjaxResult(ERROR,msg);
	}
	public static AjaxResult successResult(String msg){
		return new AjaxResult(SUCCESS,msg);
	}
	
	public static AjaxResult dataResult(String msg,String data){
		return new AjaxResult(SUCCESS,msg,null,data);
	}
	
	@Override
	public String toString(){
		JSONObject obj=new JSONObject();
		obj.put("status", status);
		obj.put("message", message);
		obj.put("redirect", redirect);
		obj.put("data", data);
		return obj.toString();
	}
	
	public AjaxResult(String msg){
		this.message=msg;
	}
	
	public AjaxResult(int status,String message){
		this.status=status;
		this.message=message;
	}
	
	public AjaxResult(String message,String redirect){
		this.message=message;
		this.redirect=redirect;
	}
	
	public AjaxResult(int status,String message,String redirect){
		this(status,message);
		this.redirect=redirect;
	}
	
	public AjaxResult(int status,String message,String redirect,String data){
		this(status,message,redirect);
		this.data=data;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRedirect() {
		return redirect;
	}

	public void setRedirect(String redirect) {
		this.redirect = redirect;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
}
