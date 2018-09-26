package com.wd.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ResponseUtil {
    public static Log log = LogFactory.getLog(ResponseUtil.class);
    
    /**
     * 发送json格式数据到页面
     * 
     * @param response
     * @param content
     */
    public static void send(HttpServletResponse response, String content) {
        
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = null;
        
        try {
            out = response.getWriter();
            //若发送数据为null 则默认为""
            if(content == null){
                content = "";
            }
            out.write(content);
        }
        catch (IOException e) {
            log.error(e.getLocalizedMessage(), e);
        }
        finally {
            if (out != null) {
                out.close();
            }
        }
    }
}
