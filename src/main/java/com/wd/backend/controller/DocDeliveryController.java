package com.wd.backend.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.wd.util.AjaxResult;
import com.wd.util.FileUtil;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.ProductEnum;
import com.wd.backend.model.DocDelivery;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.service.DocDeliveryManagerI;
import com.wd.backend.service.MailService;
import com.wd.comm.Comm;
import com.wd.front.service.DocDiliveryServiceI;
import com.wd.util.DateUtil;

/**
 * 文献传递管理
 * @author Shenfu
 *
 */
@Controller
@RequestMapping("/backend/delivery")
public class DocDeliveryController {
	
	private static final Logger log=Logger.getLogger(DocDeliveryController.class);
	
	@Autowired
	private DocDeliveryManagerI docDeliveryService;
	
	/**
	 * 文献传递
	 */
	@Autowired
	private DocDiliveryServiceI docDiliveryService;
	
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String keyword,Short type, HttpServletRequest request){
		Org org =(Org)request.getSession().getAttribute("org");
		String school= request.getParameter("school");
		String offset= request.getParameter("offset");
		if(StringUtils.isEmpty(school)) {
			school= org.getFlag();
			if("wdkj".equals(school) || "ls".equals(school)) {
                school=null;
            }
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		Date date = new Date();
		SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isEmpty(beginTime)) {
            beginTime = sp.format(org.getRegisterDate());
        }
		if(StringUtils.isEmpty(endTime)) {
            endTime = sp.format(date);
        }
		if(StringUtils.isEmpty(keyword)) {
            keyword = null;
        }
		request.setAttribute("school", school);
		request.setAttribute("show",6);
		request.setAttribute("keyword", keyword);
		request.setAttribute("type", type);
		request.setAttribute("endTime", endTime);
		request.setAttribute("beginTime", beginTime);
		if(StringUtils.isEmpty(offset)) {
			offset = "0";
		}
		request.setAttribute("offset", offset);
		if(null == type || type == -1) {
            type = null;
        }
		request.setAttribute("datas", docDeliveryService.findPager(null, null, type, keyword,school,beginTime,endTime));
		return "back/delivery/list";
	}
	
	@RequestMapping(value = { "/reuse/list" }, method = { RequestMethod.GET })
	public String reuseList(String keyword,Short type, HttpServletRequest request){
		return "back/delivery/reuseList";
	}
	
	@RequestMapping(value = { "/list/${orgId}" }, method = { RequestMethod.GET })
	public String list(@PathVariable Integer orgId,String keyword,Short type, HttpServletRequest request){
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		Date date = new Date();
		SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isEmpty(beginTime)) {
            beginTime = null;
        }
		if(StringUtils.isEmpty(endTime)) {
            endTime = sp.format(date);
        }
		request.setAttribute("endTime", endTime);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("org", docDeliveryService.findPager(orgId, null, type, keyword,null,beginTime,endTime));
		return "backend/delivery/list";
	}
	
	private static String title="[文献互助]——%s";
	
	private static final String TITLE_CRS="[crscholar文献传递]——%s";
	
	private static final String TITLE_CRS_SUCCESS="[crscholar文献传递•成功]——%s";
	
	private static String title_success="[文献互助•成功]——%s";
	
	private static String title_other="[文献互助•疑难文献]——%s";
	
//	private static String template="您好！您查找的文件  %s 已经替您查找到，具体内容请查看附件。";
	private static String template="您好！您查找的文件  %s 已应助成功。";
	
	//文献传递改为超链接形式传递文件
//	private static String templateName="您好！您查找的文件  %s 已经替您查找到。";
//	private static String templateUrl ="<br>请点击以下链接下载全文  %s （临时链接，有效期30天，请及时下载）。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	private static String templateName="您好！您求助的文献  %s 已应助成功。";
	private static String templateUrl ="<br>请点击以下链接下载全文  %s <br>注意：该链接有效期为15天（  %s 止），请及时下载。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	
//	private static String templateNull="您好！非常抱歉，我们已经尽力查找还是没有找到您请求传递的文献%s。";
	private static String templateNull="您好！非常抱歉，您求助的文献 %s 应助失败。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	
//	private static String templateOther="您好！您查找的文件%s已受理请求，正在查找中，请耐心等待。";
	private static String templateOther="您好！您求助的文献 %s 为疑难文献，我们已为您邮件通知更多用户应助该文献，并将在7天内通过邮件通知您应助结果。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	
//	private static String templateBook="您好！非常抱歉，您查找的 %s属于外文电子图书，暂时无法为您提供全文。";
	private static String templateBook="您好！非常抱歉，您求助的文献 %s 应助失败。<br><br>欢迎您使用Spischolar学术资源在线<br><a href='http://www.spischolar.com/' target='blank'>http://www.spischolar.com/</a>";
	


	

	
	@RequestMapping(value = { "/list/process" }, method = { RequestMethod.POST })
    @ResponseBody
	public AjaxResult process(Long id, Integer processType, HttpServletRequest request, HttpSession session){
		DocDelivery delivery=docDeliveryService.get(id);
		try{
			Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
			String result = docDiliveryService.check(id.intValue(),-1);
			if(Integer.parseInt(result) == 900 || Integer.parseInt(result) <= 0) {
			} else {
				return AjaxResult.successResult("success");
			}
			delivery.setProcesorName(p.getUsername());
			delivery.setProcessDate(new Date());
			delivery.setProcesorId(p.getId());
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			String subject = null;
			if(processType==1){
				log.info("进了process方法!processType==1");
				CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(session.getServletContext());
				if(multipartResolver.isMultipart(request)){
					MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
					Iterator<String> iter = multiRequest.getFileNames();
					while (iter.hasNext()) {
						// 由CommonsMultipartFile继承而来,拥有上面的方法.
						MultipartFile file = multiRequest.getFile(iter.next());
						//查找到文件
						if (file != null) {
							realPath+=dailyPath;
							//创建目录
							FileUtil.createDir(new File(realPath));
							//创建一个新文件
							File attachFile=FileUtil.createNewFile(realPath, file.getOriginalFilename());
							FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
							delivery.setPath(dailyPath+attachFile.getName());
							delivery.setProcessType((short)1);
							if(delivery.getProductId() == ProductEnum.CSR.value()){
								subject = String.format(TITLE_CRS_SUCCESS, delivery.getTitle());
							}else{
								subject  =String.format(title_success, delivery.getTitle());
							}
							String url = request.getRequestURL() + "/download/delivery?id="+delivery.getId()+"&time=" + System.currentTimeMillis();;
							url = url.replace("/backend/delivery/list/process", "");
							//到期时间
							String time = DateUtil.getEndTime(DateUtil.format(new Date()), 16*24*60*60).substring(0,10);
							String content = String.format(templateName, delivery.getTitle()) + String.format(templateUrl, "<a href='"+url+"' target='blank'>"+url+"</a>",time);
							if (delivery.getPath() != null){
								mailService.send(delivery.getProductId(),delivery.getEmail(), subject, content, null);
							}else{
								mailService.send(delivery.getProductId(),"hezhigang@hnwdkj.com","文献传递直接处理错误",delivery.toString(),null);
								return AjaxResult.errorResult("failed");
							}
							break;
						}
					}
				}
			//提交第三方处理
			}else if(processType==2||processType==4){
				log.info("进了process方法!processType==2||processType==4");
				delivery.setProcessType((short)processType.intValue());
				if(delivery.getProductId() == ProductEnum.CSR.value()){
					subject = String.format(TITLE_CRS, delivery.getTitle());
				}else{
					subject  =String.format(title_other, delivery.getTitle());
				}
				mailService.send(delivery.getProductId(),delivery.getEmail(), subject, String.format(templateOther, delivery.getTitle()), null);
			//没有找到结果
			}else if(processType==3){
				log.info("进了process方法!processType==3");
				delivery.setProcessType((short)3);
				if(delivery.getProductId() == ProductEnum.CSR.value()){
					subject = String.format(TITLE_CRS, delivery.getTitle());
				}else{
					subject  =String.format(title, delivery.getTitle());
				}
				mailService.send(delivery.getProductId(),delivery.getEmail(), subject, String.format(templateNull, delivery.getTitle()), null);
			//图书
			} else if(processType==5) {
				delivery.setProcessType((short)5);
				if(delivery.getProductId() == ProductEnum.CSR.value()){
					subject = String.format(TITLE_CRS, delivery.getTitle());
				}else{
					subject  =String.format(title, delivery.getTitle());
				}
				mailService.send(delivery.getProductId(),delivery.getEmail(), subject, String.format(templateBook, delivery.getTitle()), null);
			} else if(processType==6 && delivery.getProcessType() == 1) {
				delivery.setProcessType((short)6);
			} else if(processType==7 && delivery.getProcessType() == 6) {
				delivery.setProcessType((short)1);
			} else if (processType==6 && delivery.getProcessType() != 1){
				log.error("文献复用出错:"+delivery.toString());
				mailService.send(delivery.getProductId(),"hezhigang@hnwdkj.com","文献传递复用错误",delivery.toString(),null);
				return AjaxResult.errorResult("failed");
			} else if (processType==7 && delivery.getProcessType() != 6){
				log.error("文献取消复用出错:"+delivery.toString());
				mailService.send(delivery.getProductId(),"hezhigang@hnwdkj.com","文献传递取消复用错误",delivery.toString(),null);
				return AjaxResult.errorResult("failed");
			}
			docDeliveryService.edit(delivery);
		}catch(Exception e){
			log.error("文献传递处理出错!",e);
			return AjaxResult.errorResult("failed");
		}
        return AjaxResult.successResult("success");
	}
	/**
	 * 应助审核
	 * @param id
	 * @return
	 */
	@RequestMapping(value = { "/list/diliverHelp" }, method = { RequestMethod.POST })
	public String diliverHelp(HttpServletRequest request,long id,int helpId) {
		Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		docDeliveryService.diliverHelp(id, helpId,p.getId(),p.getUsername());
		DocDelivery delivery = docDeliveryService.get(id);
		String url = request.getRequestURL() + "/download/delivery?id="+delivery.getId()+"&time=" + System.currentTimeMillis();;
		url = url.replace("/backend/delivery/list/diliverHelp", "");
		if(helpId == 3) {
			String subject = String.format(title_success, delivery.getTitle());
			String time = DateUtil.getEndTime(DateUtil.format(new Date()), 16*24*60*60).substring(0,10);//到期时间
			String content = String.format(templateName, delivery.getTitle()) + String.format(templateUrl, "<a href='"+url+"' target='blank'>"+url+"</a>",time);
			if (delivery.getPath() != null){
				mailService.send(delivery.getProductId(),delivery.getEmail(), subject, content, null);
			} else {
				mailService.send(delivery.getProductId(),"hezhigang@hnwdkj.com","文献传递审核错误",delivery.toString(),null);
			}
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String school= request.getParameter("school");
		String type= request.getParameter("type");
		String keyword= request.getParameter("keyword");
		String offset= request.getParameter("offset");
		return  UrlBasedViewResolver.REDIRECT_URL_PREFIX + "/backend/delivery/list?school="+school+"&type="+type+"&beginTime="+beginTime+"&endTime=" + endTime +"&keyword=" +keyword+"&offset=" +offset;
	}

}
