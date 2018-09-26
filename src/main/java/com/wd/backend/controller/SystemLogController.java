package com.wd.backend.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.UpdateLog;
import com.wd.backend.service.UpdateLogManagerI;
import com.wd.util.FileUtil;

@Controller
@RequestMapping("/backend/systemLog")
public class SystemLogController {
	
	@Autowired
	private UpdateLogManagerI updateLogService;
	
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String key,HttpServletRequest request){
		request.setAttribute("show",7);
		Pager pager=updateLogService.search(key,1);
		setUpdateLog(key, pager);
		request.setAttribute("data", pager);
		return "back/systemLog/list";
	}

	private void setUpdateLog(String key, Pager pager) {
		if(key != null && pager.getRows() !=null) {
			for(int i=0;i < pager.getRows().size(); i++) {
				UpdateLog log = (UpdateLog) pager.getRows().get(i);
				log.setTitle(log.getTitle().replaceAll(key, "<b>"+key+"</b>"));
				log.setLogAbstract(log.getLogAbstract().replaceAll(key, "<b>"+key+"</b>"));
				log.setPerson(log.getPerson().replaceAll(key, "<b>"+key+"</b>"));
				log.setLable(log.getLable().replaceAll(key, "<b>"+key+"</b>"));
			}
		}
	}

	@RequestMapping(value = { "/newLog" }, method = { RequestMethod.GET })
	public String newLog(String id,HttpServletRequest request){
		request.setAttribute("show",7);
		List<Map<Object, Object>> map = updateLogService.getLable();
		request.setAttribute("map", map);
		if(id != null) {
			UpdateLog log = updateLogService.detail(Integer.parseInt(id));
			String lable = log.getLable();
			if(lable != null) {
				String[] lables = lable.split(" ");
				ArrayList list = new ArrayList(Arrays.asList(lables));
				log.setLables(list);
			}
			request.setAttribute("log", log);
			request.setAttribute("method", "updateLog");
			return "back/systemLog/editLog";
		}else {
			request.setAttribute("method", "addNewLog");
			return "back/systemLog/newLog";
		}
		
	}
	@RequestMapping(value = { "/newLog/addNewLog" }, method = { RequestMethod.POST })
	public String editLog(@RequestParam(value = "file", required = false) MultipartFile file,UpdateLog updateLog,HttpServletRequest request){
		setPath(file, updateLog);
		updateLogService.add(updateLog);
		String[] lables = request.getParameterValues("lables");
		updateLogService.insertLable(lables);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/systemLog/list";
	//	return "back/systemLog/newLog";
	}

	private void setPath(@RequestParam(value = "file", required = false) MultipartFile file, UpdateLog updateLog) {
		if(!file.isEmpty()) {
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			//创建目录
			FileUtil.createDir(new File(realPath));
			//创建一个新文件
			File attachFile=FileUtil.createNewFile(realPath, file.getOriginalFilename());
			try {
				FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
			updateLog.setPath(dailyPath+attachFile.getName());
		}
	}

	@RequestMapping(value = { "/newLog/updateLog" }, method = { RequestMethod.POST })
	public String edit(@RequestParam(value = "file", required = false) MultipartFile file,UpdateLog log,HttpServletRequest request){
		setPath(file, log);
		updateLogService.edit(log);
		String[] lables = request.getParameterValues("lables");
		updateLogService.insertLable(lables);
		request.setAttribute("msg", "编辑系统更新日志成功");
		request.setAttribute("location", "backend/updatelog/list");
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/systemLog/list";
	}
	/**
	 * 编辑插件图片上传
	 * @param file
	 * @param request
	 * @param response
	 * @throws FileUploadException
	 * @throws IOException
	 */
	@RequestMapping(value = { "/newLog/img" }, method = { RequestMethod.POST })
	public void img(@RequestParam(value = "imgFile", required = false) MultipartFile file,HttpServletRequest request,HttpServletResponse response) throws FileUploadException, IOException{
		//文件保存目录路径
		String savePath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
		savePath+=dailyPath;
		//创建目录
		FileUtil.createDir(new File(savePath));
		String fileName = file.getOriginalFilename();
		savePath = savePath + fileName;
		byte[] aa = file.getBytes();
		File savefile = new File(savePath);
		List results = new ArrayList();
		 try {
             FileCopyUtils.copy(file.getBytes(), savefile);
         } catch (IOException e) {
             e.printStackTrace();
         }
        results.add(savePath);
        String url=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"+"upload/" +dailyPath+"/"+ fileName;
        JSONObject obj = new JSONObject();
        obj.put("error", 0);
        obj.put("url", url);
        response.getWriter().write(obj.toString());
	}
	
	



	/**
	 * 草稿箱
	 * @param key
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/drafts" }, method = { RequestMethod.GET })
	public String drafts(String key,HttpServletRequest request){
		request.setAttribute("show",7);
		Pager pager=updateLogService.search(key,0);
		if(key != null && pager.getRows() !=null) {
			for(int i=0;i < pager.getRows().size(); i++) {
				UpdateLog log = (UpdateLog) pager.getRows().get(i);
				log.setTitle(log.getTitle().replaceAll(key, "<b>"+key+"</b>"));
				log.setLogAbstract(log.getLogAbstract().replaceAll(key, "<b>"+key+"</b>"));
				log.setPerson(log.getPerson().replaceAll(key, "<b>"+key+"</b>"));
				log.setLable(log.getLable().replaceAll(key, "<b>"+key+"</b>"));
			}
		}
		request.setAttribute("data", pager);
		return "back/systemLog/drafts";
	}
	
	/**
	 * 下载附件
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/list/download" }, method = { RequestMethod.GET })
	public void downLoad(HttpServletRequest request ,HttpServletResponse response){
		String path = request.getParameter("path");
		String basePath=request.getSession().getServletContext().getRealPath("/");
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
		try{
			response.setContentType("application/octet-stream"); 
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", path.substring(path.lastIndexOf("/")+1, path.length())));
	    	File file = new File(basePath+path);
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	e.printStackTrace();
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
	/**
	 * 下载附件
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/drafts/download" }, method = { RequestMethod.GET })
	public void ddownLoad(HttpServletRequest request ,HttpServletResponse response){
		String path = request.getParameter("path");
		String basePath=request.getSession().getServletContext().getRealPath("/");
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
		try{
			response.setContentType("application/octet-stream"); 
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", path.substring(path.lastIndexOf("/")+1, path.length())));
	    	File file = new File(basePath+path);
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	e.printStackTrace();
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
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.GET })
	public String add(){
		return "backend/updatelog/add";
	}
	
	@RequestMapping(value = { "/varify" }, method = { RequestMethod.GET })
	public String varify(UpdateLog log,HttpServletRequest request){
		updateLogService.updateView(log);
		//return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/updatelog/list";
		request.setAttribute("msg", "设置成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(UpdateLog log,HttpServletRequest request){
		updateLogService.add(log);
		request.setAttribute("msg", "机构系统公告成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/edit/{logId}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer logId,HttpServletRequest request){
		UpdateLog log=updateLogService.detail(logId);
		request.setAttribute("log", log);
		return "backend/updatelog/edit";
	}
	

	
	@RequestMapping(value = { "/delete/{logId}" }, method = { RequestMethod.GET })
	public String delete(@PathVariable Integer logId,HttpServletRequest request){
		updateLogService.delete(logId);
		request.setAttribute("msg", "删除成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
		//return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/updatelog/list";
	}



}
