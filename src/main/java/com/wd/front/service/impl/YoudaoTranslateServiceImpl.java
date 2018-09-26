package com.wd.front.service.impl;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import java.io.File;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.TransCountDaoI;
import com.wd.backend.service.MailService;
import com.wd.comm.Comm;
import com.wd.front.service.TranslateServiceI;
import com.wd.util.FileUtil;
import com.wd.util.MD5Util;
import com.wd.util.PDFUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.encryption.InvalidPasswordException;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;


/**
 * Created by DimonHo on 2018/1/29.
 */
@Service("youdaoTranslateService")
public class YoudaoTranslateServiceImpl implements TranslateServiceI {

    @Autowired
    TransCountDaoI transCountDao;
    @Autowired
    private MailService mailService;

    @Value("${translate_appKey}")
    private String appKey = "5718b90512bb1b3b";
    @Value("${translate_appSecret}")
    private String appSecret = "l2ZUcRz9C7XFZKqwSVptudWmoJtFCyy1";
    @Value("${translate_from}")
    private String from = "auto";
    @Value("${translate_to}")
    private String to = "zh-CHS";
    @Value("${translate_url}")
    private String url = "http://openapi.youdao.com/api";

    @Override
    public String translateString(String journalTitle) throws Exception {
        Map params = buildTranslateParams(journalTitle);
        return requestForHttp(url, params);
    }

    private Map buildTranslateParams(String journalTitle) {
        String salt = String.valueOf(System.currentTimeMillis());
        String sign = MD5Util.getMD5(appKey + journalTitle + salt + appSecret);
        Map params = new HashMap();
        params.put("q", journalTitle);
        params.put("from", from);
        params.put("to", to);
        params.put("sign", sign);
        params.put("salt", salt);
        params.put("appKey", appKey);
        return params;
    }


    private String requestForHttp(String url, Map requestParams) throws Exception {
        String result = null;
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        List params = new ArrayList();
        Iterator<Entry> it = requestParams.entrySet().iterator();
        while (it.hasNext()) {
            Entry<String, String> en = it.next();
            String key = en.getKey();
            String value = en.getValue();
            if (value != null) {
                params.add(new BasicNameValuePair(key, value));
            }
        }
        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        try {
            HttpEntity httpEntity = httpResponse.getEntity();
            result = EntityUtils.toString(httpEntity, "utf-8");
            EntityUtils.consume(httpEntity);
        } finally {
            try {
                if (httpResponse != null) {
                    httpResponse.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    @Override
    public String translateFile(HttpSession session, File file) {
        OrgBO orgBO = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
        Integer nowDayCount = transCountDao.getNowDayCount(orgBO.getFlag());
        Integer nowMonthCount = transCountDao.getNowMonthCount(orgBO.getFlag());
        //超出当日使用字符字数
        if (nowDayCount != null && nowDayCount >= 200000) {
            return "error_02.pdf";
        }
        //超出当月使用字符总数
        if (nowMonthCount != null && nowMonthCount >= 5000000) {
            return "error_03.pdf";
        }
        String suffix = file.getName().substring(file.getName().indexOf("."));
        if (".pdf".equals(suffix)) {//如果是PDF直接按页读取
            return readPdf(session, file); //返回文件路径
        } else {//如果不是PDF，先转换成PDF，再按页读取
//            try {//调用liboffice转换word到PDF
//                String shpath = "/home/web/trans.sh";
//                Process process = Runtime.getRuntime().exec(new String[]{shpath, file.getAbsolutePath()});
//                process.waitFor();
//            } catch (Exception e) {
//                return "不支持的文件格式";
//            }
            return "error_01.pdf";
        }
    }


    /**
     * 翻译PDF
     *
     * @param file
     * @return
     */
    private String readPdf(HttpSession session, File file) {
        boolean fileEnpty = true;
        OrgBO orgBO = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
        PDFUtil pdfUtil = new PDFUtil();
        String font = session.getServletContext().getRealPath("/") + "/resources/font/simhei.ttf";
        //设置PDF字体
        Font textFont = PDFUtil.createCHineseFont(10, Font.NORMAL, new BaseColor(0, 0, 0), font);
        //翻译文件名以前缀zh_开头
        String transFile = "/zh_" + file.getName();
        pdfUtil.createDocument(file.getParent() + transFile);
        try {
            //加载待翻译PDF文件
            PDDocument document = PDDocument.load(file);
            int pages = document.getNumberOfPages();
            //按页读取text内容
            for (int i = 1; i <= pages; i++) {
                // 读文本内容
                PDFTextStripper stripper = new PDFTextStripper();
                // 设置按顺序输出
                stripper.setSortByPosition(true);
                stripper.setStartPage(i);
                stripper.setEndPage(i);
                String content = stripper.getText(document);

                if (content.length() > 5000) {
                    content = content.substring(0, 5000);
                }
                Map param = new HashMap();
                param.put("orgFlag", orgBO.getFlag());
                param.put("transCount", content.length());
                transCountDao.setNowDayCount(param);
                //调用有道翻译，得到翻译结果
                if (content.length()>0){
                    JSONObject translateResult = JSON.parseObject(translateString(content));

                    if ("302".equals(translateResult.getString("errorCode"))) {
                        transFile = "error_04.pdf";
                    }else if ("113".equals(translateResult.getString("errorCode"))){
                        continue;
                    }else if(!"0".equals(translateResult.getString("errorCode"))){
                        transFile = "error_01.pdf";
                    }
                    fileEnpty = false;
                    String translation = translateResult.getString("translation");
                    String[] lines = null;

                    lines = translation.substring(2, translation.length() - 2).split("\\\\n");
                    for (String line : lines) { //按行写入PDF
                        Phrase text = PDFUtil.createPhrase(line, textFont);
                        pdfUtil.writeChapterToDoc(text, false);
                    }
                }
                //新的一页
                pdfUtil.document.newPage();
            }
        } catch (InvalidPasswordException e) {
            e.printStackTrace();
            transFile = "error_06.pdf";
        } catch (IOException e) {
            e.printStackTrace();
            transFile = "error_01.pdf";
        } catch (Exception e) {
            e.printStackTrace();
            transFile = "error_01.pdf";
        }finally {
            try{
                pdfUtil.closeDocument();
            }catch (Exception e){
                if (transFile.startsWith("error_")){
                    return transFile;
                }else if (fileEnpty){
                    transFile = "error_05.pdf";
                } else{
                    transFile = "error_01.pdf";
                }
            }
        }
        return transFile;
    }
}