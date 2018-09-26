<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>404</title>
<link rel="stylesheet" type="text/css"
	href="<cms:getProjectBasePath/>resources/back/css/adminpage.css">
</head>
<body style="background: #f4f4f4">
	<div class="container-404">
		<div class="logo"></div>
		<p class="des-text">
			使用期已过！您想了解的<span>Spischolar学术资源在线</span>，已经去了另外一个地方，如果<br>想要追上页面君，请优先联系图书馆！
		</p>
		<div class="des-info">
			<a href="#" class="des-info-img"> <img
				src="<cms:getProjectBasePath/>resources/back/images/404_5.png"
				width="">
			</a>
			<div class="contact">
				<c:if
					test="${(login_org.contact != null && login_org.contact != '')&&(login_org.email != null && login_org.email != '') }">
					<p>
						<span class="fix-w">${login_org.name }图书馆 电话：</span>${login_org.contact }</p>
					<p>
						<span class="fix-w">邮箱：</span><a href="mailto:${login_org.email }">${login_org.email }</a>
					</p>
					<p>
						<span class="fix-w">Spischolar服务中心：</span><a
							href="mailto:1962740172@qq.com">1962740172@qq.com</a>
					</p>
				</c:if>
				<c:if
					test="${(login_org.contact != null && login_org.contact != '')&&(login_org.email == null || login_org.email == '') }">
					<p>
						<span class="fix-w">${login_org.name }图书馆 电话：</span>${login_org.contact }</p>
					<p>
						<span class="fix-w">Spischolar服务中心：</span><a
							href="mailto:1962740172@qq.com">1962740172@qq.com</a>
					</p>

				</c:if>
				<c:if
					test="${(login_org.contact == null || login_org.contact == '')&&(login_org.email != null && login_org.email != '') }">
					<p>
						<span class="fix-w">${login_org.name }图书馆 邮箱：</span><a
							href="mailto:${login_org.email }">${login_org.email }</a>
					</p>
					<p>
						<span class="fix-w">Spischolar服务中心：</span><a
							href="mailto:1962740172@qq.com">1962740172@qq.com</a>
					</p>
				</c:if>
				<c:if
					test="${(login_org.contact == null || login_org.contact == '')&&(login_org.email == null || login_org.email == '') }">
					<p style="text-indent: 0; text-align: center">
						<span class="fix-w" style="width: auto;">Spischolar服务中心：</span><a
							href="mailto:1962740172@qq.com">1962740172@qq.com</a>
					</p>
				</c:if>
			</div>
			<a href="" class="goback" onclick="history.go(-1)">返回上一页</a>
		</div>
	</div>
</body>
</html>