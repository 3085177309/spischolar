<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String projectRootPath = request.getContextPath();
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台登陆</title>
<link href="<%=path%>/resources/css/all-backend.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/resources/js/all-backend.js"></script>
<!--[if lte IE 6]>
<script src="<%=path%>/resources/js/ie6Png.js"></script>
<script>
DD_belatedPNG.fix('.png,img');
</script>
<![endif]-->
</head>

<body style="background:url(<%=path%>/resources/images/bg_dl.jpg) no-repeat center top #e3f2f7;">
<style>
#start_wk{}
.start_conter{width:600px;  margin:0 auto; position:relative;}
.start{position:absolute; height:393px;width:600px; top:50%; margin-top:-217px;}
.start1{ height:258px;/*width:571px;*/background:url('<%=path%>/resources/images/bg_dl1.png') no-repeat; width:330px; padding:135px 135px 0;}
.start1 ul li{ line-height:24px; float:left; width:100%; height:24px; padding-bottom:15px;}
.start1 ul li span{float:left; width:67px; height:30px;}
.start1 ul li.dl_ann{height:32px; padding-top:8px;}
.start1 ul li.dl_ann a{ border:0; width:auto; height:auto; line-height:32px; color:#333333;}
.start1 button{background:url('<%=path%>/resources/images/dl_sec.jpg') no-repeat; width:82px; height:32px; border:0; float:left;cursor:pointer; margin-left:5px;}
.text{width:245px; height:24px; background:#f5f5f5; padding:0 5px; color:#999; float:right; border:1px solid #d8d8d8;}
.text2{width:60px; height:24px; background:#f5f5f5; padding:0 5px; color:#999; float:left; border:1px solid #d8d8d8; margin-left:6px;}
.start1 ul li a{float:left; width:66px; height:24px; overflow:hidden; border:1px solid #d8d8d8; margin-left:20px;}
.textHover{ color:#b21500;}
.start1 p{color:#ff4e4a; padding-left:66px; float:left;}
.start_footer{ height:30px; line-height:30px; font-size:12px; color:#ababab; padding-top:10px; text-align:center;}
</style>

<div id="start_wk">
	<div class="start_conter" id="start_conter">
		<div class="start">
        	<div class="start1 png">
            <form action='<%=projectRootPath%>/backend/login' method="post">
            <ul>
            <li>
            	<span>用户名：</span>
            	<input class="text" type="text" id="q" name='email' autocomplete="off" value="${person.email }" onblur="if(this.value==''){this.value='请输入用户名';this.className='text';}" onfocus="if(this.value=='请输入用户名'){this.value='';this.className='text textHover';}" /></li>
             <li>
             	<span>密&#12288;码：</span>
             	<input class="text" type="text" id="q2" name='password' autocomplete="off" value="请输入密码" onblur="if(this.value==''){this.setAttribute('type','text');this.value='请输入密码';this.className='text';}" onfocus="if(this.value=='请输入密码'){this.setAttribute('type','password');this.value='';this.className='text textHover';}" />
             </li>
           	 <li><span>验证码：</span><input class="text2" type="text" name="valCode" /><a href="#" title="点击切换图片"><img src="<%=path%>/backend/img" width="66" height="24" id="valImg"/></a></li>
            <li class="dl_ann"><span></span>
            	<button class="png" type="submit"></button>
            	<input type="reset" value="重置" style="float:left;margin-left:20px;border: 0px;line-height: 30px;width:82px;"></input>
            </li>
            </ul>
            <c:if test="${not empty error }">
            <p>${error }</p>
            </c:if>
            </form>
            </div>
            <div class="start_footer">
        SpiScholar学术资源导航管理后台
        	</div>
        </div>
   		
    </div>
</div>
<script src="<%=path%>/resources/js/jquery-1.7.1.min.js"></script>  
<script type="text/javascript">
$(function(){
	$('#valImg').bind('click',function(){
		var src=$(this).attr('src');
		src+="?time="+new Date();
		$(this).attr('src',src);
	});
});
$(function(){
	if(self!=top){
		top.location.href=self.location.href;
	}
});
</script>
</body>
</html>