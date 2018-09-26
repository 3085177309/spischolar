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
						<p class="section-tit">重置</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<h3 class="passboxnav">请在下面输入您的新密码：</h3>
					<ul class="loginbox">
						<li class="username-login"><i class="icon iconfont">&#xe60a;</i>
							<div class="register-inputbox">
								<input type="password" class="inputstyle" name="u"
									autocomplete="off" placeholder="新密码">
							</div>
							<div class="del-touch"></div></li>
						<li class="username-login"><i class="icon iconfont">&#xe60a;</i>
							<div class="register-inputbox">
								<input type="password" class="inputstyle" name="u"
									autocomplete="off" placeholder="请确认新密码">
							</div>
							<div class="del-touch"></div></li>
					</ul>
					<div class="register-submit">
						<input type="submit" value="提交">
					</div>

				</div>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
	function changeValiyCode(){
		$('#valiycode').attr('src','http://spischolar.com:80/backend/img?__time='+(new Date()).getTime());
	}

</script>
</body>
</html>
