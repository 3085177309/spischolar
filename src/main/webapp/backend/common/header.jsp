<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="<%=path%>/resources/css/all-backend.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/resources/js/all-backend.js"></script>
<!--[if lte IE 6]>
<script src="<%=path%>/resources/js/ie6Png.js"></script>
<script>
DD_belatedPNG.fix('.png,img');
</script>
<![endif]-->
</head>
<body>
<div class="header"> <a href="#" class="png"></a> </div>