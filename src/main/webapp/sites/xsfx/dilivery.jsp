<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui"
	name="viewport" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="telephone=no" name="format-detection" />
<meta name="author" content="weidu.com">
<meta name="copyright" content="Copyright ©weidu.com 版权所有">
<!-- UC默认竖屏 ，UC强制全屏 -->
<meta name="full-screen" content="yes" />
<meta name="browsermode" content="application" />
<!-- QQ强制竖屏 QQ强制全屏 -->
<meta name="x5-orientation" content="portrait" />
<meta name="x5-fullscreen" content="true" />
<meta name="x5-page-mode" content="app" />
<!--<link rel="apple-touch-icon-precomposed" href=""/>桌面的图片 58*58-->
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/style/respond.css" />
<!--[if lt IE 9]>
            <script src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/shiv.js"></script>
            <link rel="stylesheet" href="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/style/style.css" />      
        <![endif]-->
<title>文献传递-中外文学术发现系统</title>
</head>
<body style="position: relative; overflow: hidden;">
	<header>
		<div class="top">
			<div class="login cf">
				<div class="fl">
					<a href="###">欢迎访问中南林业科技大学图书馆</a>
				</div>
				<div class="fr">
					<a href="<cms:getProjectBasePath/>docHis" id="papa">我的检索历史</a>&nbsp;|
					<a href="###" id="login-ck">登陆</a>
				</div>
			</div>
		</div>
	</header>
	<section class="Subject" id="Middle">
		<div class="Sub_seah">
			<div class="seah_auto cf">
				<form action="" name="Sub_fm">
					<input type="text" name="txt_cont" class="txt_cont" value="" /> <input
						type="submit" name="btn" class="txt_btn" value="" /> <a
						href="javascript:;;" id="p1">高级</a>
				</form>
			</div>
		</div>
		<script>
                var Sfm=document.forms["Sub_fm"];
                    Sfm.onsubmit=function(){
                       if(this.txt_cont.value==""){
                          return false;
                       }else{
                           this.submit();
                       }
                }
            </script>
		<div>
			<form method="post" action="<cms:getProjectBasePath/>docDilivery">
				<table>
					<tr>
						<td>标题</td>
						<td><input type="text" name="title" value="${title }" /></td>
					</tr>
					<tr>
						<td>URL</td>
						<td><input type="text" name="url" value="${url }" /></td>
					</tr>
					<tr>
						<td>请输入您的邮箱</td>
						<td><input type="text" name="email" />
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit" /></td>
					</tr>
				</table>
			</form>
		</div>
	</section>
	<footer>
		<div class="footer">
			<p class="links">
				<a href="">馆员园地</a>idnbsp;| <a href="">馆员园地</a>idnbsp;| <a href="">馆员园地</a>idnbsp;|
				<a href="">馆员园地</a>idnbsp;|idnbsp; TEL:0731-88888888
			</p>
			<p>中南林业科技大学图书馆版权所有(C) 中南林业科技大学图书馆数图建设部技术支持</p>
		</div>
	</footer>
</body>
</html>
