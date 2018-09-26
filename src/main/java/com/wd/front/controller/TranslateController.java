package com.wd.front.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wd.front.service.TranslateServiceI;
import com.wd.util.AjaxResult;
import com.wd.util.FileUtil;
import com.wd.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Iterator;

/**
 * Created by DimonHo on 2018/2/6.
 */
@Controller
@RequestMapping("/translate")
public class TranslateController {
    @Autowired
    TranslateServiceI youdaoTranslateService;

    /**
     * 文章标题翻译
     *
     * @return
     */
    @RequestMapping(value = {"/title"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult translateJournalTitle(String title) {
        try {
            String docTitleZh = youdaoTranslateService.translateString(title);
            String translation = JSON.parseObject(docTitleZh).getString("translation");
            return AjaxResult.dataResult("ok", translation.substring(2, translation.length() - 2).replace("\\n", ""));
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.dataResult("fail", title);
        }
    }

    @RequestMapping(value = {"/file"}, method = {RequestMethod.GET})
    public String translateFile() {
        return "/sites/translate";
    }

    @RequestMapping(value = {"/view"}, method = {RequestMethod.GET})
    public String translateFileView() {
        return "/sites/translateSuccess";
    }

    /**
     * 文献上传
     *
     * @param request
     * @param file
     * @return
     */
    @RequestMapping(value = {"/upload"}, method = {RequestMethod.POST})
    @ResponseBody
    public String upload(HttpServletRequest request, MultipartFile file) {
    	AjaxResult ajaxResult = new AjaxResult("fail", null);
    	File attachFile = null;
        String fileMd5 = null;
        try {
            fileMd5 = MD5Util.getMD5(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
            return ajaxResult.toString();
        }
        String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        if (file != null) {
            String realPath = FileUtil.getTranslatePath(request);
            FileUtil.createDir(new File(realPath));// 创建目录
            attachFile = FileUtil.createFile(realPath, fileMd5 + ext);// 用MD5值作为文件名，防止重复存储
            try {
                if (!attachFile.exists()) {
                    file.transferTo(attachFile);
                }
            } catch (IOException e) {
                e.printStackTrace();
                return ajaxResult.toString();
            }
        }
        ajaxResult.setMessage("ok");
        ajaxResult.setData(attachFile.getName());
        return ajaxResult.toString();
    }

    /**
     * 文件翻译
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/trans"}, method = {RequestMethod.GET})
    public String translateFile(HttpServletRequest request, String fileName, HttpSession session)
            throws IOException {
        String realPath = FileUtil.getTranslatePath(request);
        File file = new File(realPath, fileName);
        if (!FileUtil.isPdf(file)){
            request.setAttribute("sourceFile", fileName);
            request.setAttribute("transFile", "error_07.pdf");
            return "/sites/translateSuccess";
        }
        request.setAttribute("sourceFile", fileName);
        File transFile = new File(realPath, "zh_" + fileName);
        String transFileName = null;
        //如果翻译文件不存在就翻译，否则就是已经翻译过了的，直接返回文件。
        if (!transFile.exists()) {
            transFileName = youdaoTranslateService.translateFile(session, file);
            if (transFileName.startsWith("error_")) {
                FileUtil.deleteFile(transFile);
            }
            request.setAttribute("transFile", transFileName);
        } else {
            request.setAttribute("transFile", transFile.getName());
        }
        return "/sites/translateSuccess";
    }
}
