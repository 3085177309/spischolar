<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>找回密码</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<div class="return-back">
							<a class="return-back" onclick="history.go(-1)"> <i
								class="icon iconfont">&#xe610;</i> <span>返回</span>
							</a>
						</div>
						<!-- <div class="head-search">
						<a href="#" class="register">立即注册</a>
					</div> -->
						<!-- <div class="userbox">
						<div class="userSelect">
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
						<p class="section-tit">找回密码</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<form method="post" action="<cms:getProjectBasePath/>user/findPwd"
						class="findpwd-form">
						<h3 class="passboxnav">请在下面输入您要找回的帐号：</h3>
						<ul class="loginbox">
							<li class="username-login"><i class="icon iconfont">&#xe60b;</i>
								<div class="register-inputbox">
									<input id="username" class="inputstyle" name="username"
										autocomplete="off" placeholder="用户名/邮箱">
								</div>
								<div class="del-touch"></div></li>
							<li class="username-login"><i class="icon iconfont">&#xe60a;</i>
								<div class="register-inputbox">
									<input id="code" class="inputstyle" name="code"
										autocomplete="off" placeholder="验证码"> <img
										src="<cms:getProjectBasePath/>backend/img" class="valiycode"
										id="valiycode" onclick="javascript:changeValiyCode()">
								</div>
								<div class="del-touch"></div></li>
						</ul>
						<div class="register-submit">
							<input type="submit" value="下一步">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
var email = "${email }";
if (email != "") {
	alert(email);
}
function changeValiyCode(){
	$('#valiycode').attr('src','<cms:getProjectBasePath/>backend/img?__time='+(new Date()).getTime());
}

</script>
</body>
</html>
