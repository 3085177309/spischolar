package com.wd.front.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;

/**
 * Created by DimonHo on 2018/1/29.
 */
public interface TranslateServiceI {

    /**
     * 翻译文本
     * @param string
     * @return
     * @throws Exception
     */
    String translateString(String string)  throws Exception;

    /**
     * 翻译文件
     * @param file
     * @return
     */
    String translateFile(HttpSession session, File file);

}
