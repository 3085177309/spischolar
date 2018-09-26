package com.wd.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;

import com.wd.backend.bo.TemplateFileInfo;
import com.wd.exeception.SystemException;

public class FileUtil {

	private static byte[] templateFileHeadContent = "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\" %><%@ taglib prefix=\"cms\" uri=\"http://org.pzy.cms\"%><%@ taglib prefix=\"fn\" uri=\"http://java.sun.com/jsp/jstl/functions\"%><%@ taglib prefix=\"pg\" uri=\"http://jsptags.com/tags/navigation/pager\"%>"
			.getBytes();

	/**
	 * 复制文件
	 * 
	 * @param sourceFile
	 *            源文件
	 * @param targetFile
	 *            目标文件
	 * @throws IOException
	 */
	public static void copyFile(File sourceFile, File targetFile) throws IOException {
		// 新建文件输入流并对它进行缓冲
		FileInputStream input = new FileInputStream(sourceFile);
		BufferedInputStream inBuff = new BufferedInputStream(input);

		// 新建文件输出流并对它进行缓冲
		FileOutputStream output = new FileOutputStream(targetFile);
		BufferedOutputStream outBuff = new BufferedOutputStream(output);

		// 缓冲数组
		byte[] b = new byte[1024 * 5];
		int len;
		int pos = sourceFile.getName().lastIndexOf('.');
		if (-1 != pos) {
			// 获取文件后缀
			String hz = sourceFile.getName().substring(pos + 1);
			if ("jsp".equals(hz)) {
				// 是jsp文件，自动添加统一文件头内容
				outBuff.write(templateFileHeadContent);
			}
		}
		while ((len = inBuff.read(b)) != -1) {
			outBuff.write(b, 0, len);
		}
		// 刷新此缓冲的输出流
		outBuff.flush();

		// 关闭流
		inBuff.close();
		outBuff.close();
		output.close();
		input.close();
	}

	/**
	 * 复制目录
	 * 
	 * @param sourceDir
	 *            源目录
	 * @param targetDir
	 *            目标目录
	 * @throws IOException
	 */
	public static void copyDirectiory(String sourceDir, String targetDir) throws IOException {
		// 新建目标目录
		File tmp = new File(targetDir);
		if (tmp.exists()) {
		}
		tmp.mkdirs();
		// 获取源文件夹当前下的文件或目录
		File[] file = (new File(sourceDir)).listFiles();
		for (int i = 0; i < file.length; i++) {
			if (file[i].isFile()) {
				// 源文件
				File sourceFile = file[i];
				// 目标文件
				File targetFile = new File(new File(targetDir).getAbsolutePath() + File.separator + file[i].getName());
				copyFile(sourceFile, targetFile);
			}
			if (file[i].isDirectory()) {
				// 准备复制的源文件夹
				String dir1 = sourceDir + "/" + file[i].getName();
				// 准备复制的目标文件夹
				String dir2 = targetDir + "/" + file[i].getName();
				copyDirectiory(dir1, dir2);
			}
		}
	}

	/**
	 * 删除目录
	 * 
	 * @param dir
	 * @return
	 */
	public static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			// 递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}

	public static boolean deleteFile(File file){
		if (file.isFile()){
			file.delete();
			return true;
		}
		return false;
	}

	private static Properties prop = System.getProperties();

	public static String getUploadRootPath() {
		String os = prop.getProperty("os.name");
		if (os.toLowerCase().startsWith("win")) {
			// 是windows操作系统
			return "D:" + File.separator + "org_sites" + File.separator;
		} else {
			// 非win操作系统
			return "/" + File.separator + "org_sites" + File.separator;
		}
	}
		
	public static String getSysUserHome(){
		return System.getProperty("user.home");
		//return request.getSession().getServletContext().getRealPath("/upload");
	}

	public static String getTranslatePath(HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath("/translate");
	}
	
	/**
	 * 每天在upload目录下生产一个路径
	 * @return
	 */
	public static String getDailyPath(){
		Calendar cal=Calendar.getInstance();
		return String.format("/upload/%04d%02d%02d/", cal.get(Calendar.YEAR),cal.get(Calendar.MONTH)+1,cal.get(Calendar.DATE));
	}
	
	public static void createDir(File path){
		//如果路径已经存在
		if(path.exists()){
			return ;
		}
		File parent=path.getParentFile();
		//如果上级路径是存在的，直接创建
		if(parent.exists()){
			//创建目录
			path.mkdir();
		}else{
			createDir(parent);
		}
	}
	
	public static  File createNewFile(String path,String name){
		File file=new File(path,name);
		if(!file.exists()){
			return file;
		}else{
			String ext=name.substring(name.lastIndexOf(".")+1),fileName=name.substring(0, name.lastIndexOf(".")),newName;
			int index=1;
			while(file.exists()){
				newName=fileName+"("+index+")"+"."+ext;
				file=new File(path,newName);
				index++;
			}
		}
		return file;
	};

	public static  File createFile(String path,String name){
		File file=new File(path,name);
		if(!file.exists()){
			return file;
		}
		return file;
	};
	
	public static  File createTimeNewFile(String path,String name){
		String ext=name.substring(name.lastIndexOf(".")+1),fileName=""+(new Date()).getTime(),newName;
		File file=new File(path,fileName+"."+ext);
		if(!file.exists()){
			return file;
		}
		int index=1;
		while(file.exists()){
			newName=fileName+"("+index+")"+"."+ext;
			file=new File(path,newName);
			index++;
		}
		return file;
	};

	/**
	 * 判断解压目录是否存在
	 * 
	 * @param
	 * @return
	 */
	public static boolean unzipDirExists(String dirPath) {
		String path = getUploadRootPath() + File.separator + dirPath;
		File dir = new File(path);
		return dir.exists();
	}

	/**
	 * 获取文件内容
	 * 
	 * @param filePath
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	public static String loadFileContent(String filePath) throws FileNotFoundException, IOException {
		String content = "";
		FileInputStream fileInputStream = null;
		try {
			fileInputStream = new FileInputStream(new File(getUploadRootPath() + File.separator + filePath));
			content = IOUtils.toString(fileInputStream, "UTF-8");
		} catch (Exception e) {
			throw e;
		} finally {
			if (null != fileInputStream) {
				fileInputStream.close();
			}
		}
		return content;
	}

	/**
	 * 将文件内容以覆盖的方式写入文件
	 * 
	 * @param fileInfo
	 * @throws SystemException
	 */
	public static void writeContent(TemplateFileInfo fileInfo) throws SystemException {
		PrintWriter printWriter = null;
		try {
			String filePath = getUploadRootPath() + File.separator + fileInfo.getOrgFlag() + File.separator + fileInfo.getSiteFlag() + File.separator + fileInfo.getTemplateFlag() + File.separator
					+ fileInfo.getFileName();
			printWriter = new PrintWriter(new OutputStreamWriter(new FileOutputStream(new File(filePath), false), "UTF-8"));
			String content = fileInfo.getContent();
			content = content.replaceAll("<%=", "--}(--(}}");
			content = content.replaceAll("<%@", "-}{)---(}}");
			content = content.replaceAll("<%", "");
			content = content.replaceAll("--\\}\\(--\\(\\}\\}", "<%=");
			content = content.replaceAll("-\\}\\{\\)---\\(\\}\\}", "<%@");
			fileInfo.setContent(content);
			printWriter.println(fileInfo.getContent().trim());
		} catch (FileNotFoundException e) {
			throw new SystemException("文件[" + fileInfo.getFileName() + "]未找到！请尝试刷新文件列表!");
		} catch (UnsupportedEncodingException e) {
			throw new SystemException("指定的编码格式异常！");
		} finally {
			if (null != printWriter) {
                printWriter.close();
            }
		}
	}


	/**
	 * 得到上传文件的文件头
	 * @param src
	 * @return
	 */
	private static String bytesToHexString(byte[] src){
		StringBuilder stringBuilder = new StringBuilder();
		if(null==src || src.length <= 0){
			return null;
		}
		for(int i = 0; i < src.length; i++){
			int v = src[i] & 0xFF;
			String hv = Integer.toHexString(v);
			if(hv.length() < 2){
				stringBuilder.append(0);
			}
			stringBuilder.append(hv);
		}
		return stringBuilder.toString();
	}

	/**
	 * 获取文件类型
	 * @param file
	 * @return
	 */
	public static boolean isPdf(File file){
		boolean flag = false;
		String res = null;
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			//获取文件头的前六位
			byte[] b = new byte[3];
			fis.read(b, 0, b.length);
			String fileCode = bytesToHexString(b);
			if ("255044462d312e360d25".startsWith(fileCode)){
				flag = true;
			}
			fis.close();
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch (IOException e){
			e.printStackTrace();
		}finally {
			try {
				fis.close();
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
}
