<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">

<title>spis后台login</title>
</head>
<link href="<cms:getProjectBasePath/>resources/images/favicon.ico"
	rel="SHORTCUT ICON">
<link href="<cms:getProjectBasePath/>resources/back/css/login.css"
	rel="stylesheet" type="text/css" />
<body>
	<div id="bg">
		<img src="<cms:getProjectBasePath/>resources/back/images/logo_01.jpg" />
	</div>

	<div id="blue">
		<div class="bg">
			<div class="earth">

				<%--<img src="<cms:getProjectBasePath/>resources/back/images/earth_02.jpg" class="bg"/> --%>
				<div class="login">
					<div class="icon">
						<img
							src="<cms:getProjectBasePath/>resources/back/images/tb_03.jpg" />
						<p>
							后台登录&nbsp<a>Login</a>
						</p>
					</div>
					<form action='<cms:getProjectBasePath/>/backend/login'
						method="post" autocomplete="off">
						<div class="loginbox">
							<div class="text">
								<label for="email"> <span>账&nbsp;号：</span> <input
									type="text" name='email' autocomplete="off"
									value="${loginperson.email }" placeholder="请输入用户名或邮箱...">
								</label>
							</div>
							<div class="text pass">
								<label for="password"> <span>密&nbsp;码：</span> <input
									type="password" name='password' autocomplete="off"
									placeholder="请输入密码...">
								</label>
							</div>
							<div class="text code">
								<label for="valCode"> <span>验证码：</span> <input
									type="text" name="valCode"> <img
									src="<cms:getProjectBasePath/>/backend/img" width="66"
									height="24" id="valImg" />
								</label>
							</div>
							<!-- <div class="ewm">
		                	
		                </div> -->
							<c:if test="${not empty error }">
								<p class="errorText">${error }</p>
							</c:if>
							<div class="botton">
								<input type="submit" value="" /> <input class="botton1"
									type="reset" value="" /> <a
									href="<cms:getProjectBasePath/>backend/member/list/findPwd"
									class="forgetpwd">忘记密码?</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<div id="foot">
		地址：长沙高新开发区麓谷大道662号软件中心大楼667号 传真：0731-82656399 电话：0731-82655788<br>
		版权所有：湖南纬度信息技术有限公司 Copyright<span> ©</span> 2015-2017 All rights
		reserved.
	</div>
	</div>

	<script
		src="<cms:getProjectBasePath/>/resources/js/jquery-1.7.1.min.js"></script>
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
		$(window).resize(function(){
			console.log(parseFloat($(window).height()))
			if($(window).height()<700){
				$("#foot").css({
					"position":"relative",
					"margin-top":"60px"
					})
			}else{
				$("#foot").css({"position":"absolute"})
			}
		})
		//$(document.body).css({"max-height":$(window).height()});
	});
	</script>
</body>
</html>