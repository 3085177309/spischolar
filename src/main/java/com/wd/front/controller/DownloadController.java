package com.wd.front.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wd.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wd.backend.model.DocDelivery;
import com.wd.front.service.DocDiliveryServiceI;

/**
 * 通网下载链接（不限）
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/download")
public class DownloadController {
	
	/**
	 * 文献传递
	 */
	@Autowired
	private DocDiliveryServiceI docDiliveryService;
	
	/**
	 * 文献传递超链接（有效期30天）
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/delivery" }, method = { RequestMethod.GET })
	public void downLoad(HttpServletRequest request ,HttpServletResponse response){
		BufferedInputStream bis = null;  
		BufferedOutputStream bos = null;
	    String id = request.getParameter("id");
	    DocDelivery del=docDiliveryService.get(Long.parseLong(id));
    	String path=del.getPath(),basePath= FileUtil.getSysUserHome();
    	Date date = del.getProcessDate();
    	Date now = new Date();
    	long l=now.getTime()-date.getTime();
		int day=(int) (l/(24*60*60*1000));
		if(day > 15) {
			try {
				response.sendRedirect("/sites/404FileNotFind.jsp");
			} catch (IOException e) {
				e.printStackTrace();
				return;
			}
		}
    	File file=new File(basePath+path);  
		try{
			response.setContentType("application/octet-stream"); 
			String fileName=getName(file,request.getHeader("User-Agent"));
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", fileName));
	    	
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	
	    }finally{
	    	if(bis!=null){
	    		try{
	    			bis.close();
	    			bis=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	if(bos!=null){
	    		try{
	    			bos.close();
	    			bos=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    }
	}
	
	private String getName(File file,String userAgent) throws UnsupportedEncodingException{
		String fileName=file.getName(),ext,name;
		ext=fileName.substring(fileName.lastIndexOf(".")+1);
		name=fileName.substring(0,fileName.lastIndexOf("."));
		name=name+"."+ext;
		byte[] bytes = userAgent.contains("MSIE") ? name.getBytes()
		        : name.getBytes("UTF-8"); // fileName.getBytes("UTF-8")处理safari的乱码问题
		return  new String(bytes, "ISO-8859-1"); 
	}

}
