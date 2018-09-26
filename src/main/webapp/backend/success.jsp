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
<style>
 html,body{
 	padding:30px;
 	margin: 0 auto;
 	text-align: center;
 	background-color: white;
 }
 h4{
 	color:green;
 }
</style>
</head>

<body>
<h4>${msg },3秒后会进行跳转!</h4>
<script type="text/javascript">
window.onload=function(){
	setTimeout(function(){
		top.location.href='<%=path%>/${location}';
	},3000);
}
</script>
</body>

</html>