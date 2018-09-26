package com.wd.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class HttpUtil extends Thread{
	private String jsonUrl;
	
	public HttpUtil(String jsonUrl) {
		super();
		this.jsonUrl = jsonUrl;
	}

	public String getJsonUrl() {
		return jsonUrl;
	}

	public void setJsonUrl(String jsonUrl) {
		this.jsonUrl = jsonUrl;
	}
	
	 @Override  
	 public void run() { 
		 URL url;
		try {
			url = new URL(jsonUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();  
	        connection.connect(); 
		} catch (Exception e) {
			e.printStackTrace();
		}  
	 }
	 
	public static String getZkySubjectXml(String  jsonUrl) throws Exception{
    	URL url = new URL(jsonUrl);  
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();  
        connection.connect(); 
        //只是向中科院发送请求，并不使用返回的结果
        /*InputStream inputStream = connection.getInputStream();  
        //对应的字符编码转换  
        Reader reader = new InputStreamReader(inputStream, "UTF-8");  
        BufferedReader bufferedReader = new BufferedReader(reader);  
        String str = null;  
        StringBuffer sb = new StringBuffer();  
        while ((str = bufferedReader.readLine()) != null) {  
            sb.append(str);  
        }  
        reader.close();  
        connection.disconnect(); 
        return sb.toString();*/
        return "";
	}
	
	public static void main(String[] args) throws Exception {
		String subject=URLEncoder.encode("地学天文", "utf-8");
		String jsonUrl = "http://api.fenqubiao.com/api/journal/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/2012/%E5%A4%A7%E7%B1%BB/"+subject+"/desc/0/25";
		//String jsonUrl = "http://api.fenqubiao.com/api/journal/327b1ee1-6299-4528-abff-c82209276820/dzdxwh_spi/dzdxwh_spi/2014/%E5%A4%A7%E7%B1%BB/%E5%9C%B0%E5%AD%A6%E5%A4%A9%E6%96%87/desc/0/25";
		String ss =getZkySubjectXml(jsonUrl);
		System.out.println(ss);
		JSONArray myJsonArray = JSONArray.fromObject(ss);
		System.out.println(myJsonArray.size());
//		if(myJsonArray.size()>0){
//			  for(int i=0;i<myJsonArray.size();i++){
//			    JSONObject job = myJsonArray.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
//			    System.out.println(job.get("Name")) ;  // 得到 每个对象中的属性值
//			  }
//		}
	}
}
