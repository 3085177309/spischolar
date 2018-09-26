<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--[if lt IE 7]><html class="ie6 "><![endif]-->
<!--[if IE 7]><html class="ie7 "><![endif]-->
<!--[if IE 8]><html class="ie8 "><![endif]-->
<!--[if IE 9]><html class="ie9 "><![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- <meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui" name="viewport" /> -->
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="telephone=no" name="format-detection" />
<meta name="author" content="weidu.com">
<meta name="copyright" content="Copyright ©weidu.com 版权所有">
<meta property="qc:admins" content="61575026576301330741263757" />
<% String version = "1.0.1"; %>
<link href="<cms:getProjectBasePath/>resources/images/favicon.ico"
	rel="SHORTCUT ICON" />
<link href="<cms:getProjectBasePath/>resources/css/index.css?v=<%=version %>"
	rel="stylesheet" />
<link href="<cms:getProjectBasePath/>resources/css/all.css?v=<%=version %>"
	rel="stylesheet" />
<link href="<cms:getProjectBasePath/>resources/css/navbar.css?v=<%=version %>"
	rel="stylesheet" />
<!-- 文献互助中心相关 样式 -->
<link href="<cms:getProjectBasePath/>resources/css/diliveryHelp.css?v=<%=version %>"
	rel="stylesheet" />
<!--[if lt IE 9]>
    <script src="<cms:getProjectBasePath/>resources/js/respond.min.js"></script>
<![endif]-->
<script type="text/javascript">
/*** 全局变量*/var SITE_URL  = '<cms:getProjectBasePath/>';
</script>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/all.js?v=<%=version %>"></script>
<script src="<cms:getProjectBasePath/>resources/js/index.js?v=<%=version %>"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/layer.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/pagination.js"></script>

<!-- <div style="text-align:center;     background: url(resources/images/index-bg.jpg) no-repeat top center; top:0px; width:100%;"><div style="margin:0 auto;color:white;font-size:14px; ">
通知：系统将于2018年08月16日-17日期间进行升级维护。届时将暂停服务，由此给您带来的不便深表歉意。
</div></div> -->