<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>登录</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<div class="return-back" onclick="history.go(-1)">
							<i class="icon iconfont">&#xe610;</i> <span>返回</span>
						</div>
						<%-- <div class="head-search">
						<a href="<cms:getProjectBasePath/>user/register" class="register">立即注册</a>
					</div> --%>
						<p class="section-tit">登录</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<div class="lg" style="margin: 1rem 0;">
						<img
							src="<cms:getProjectBasePath/>/resources/mobiles/images/logo22.png">
					</div>
					<form id="login_form" method="POST">
						<ul class="loginbox loginboxmargin">
							<li class="username-login"><i class="icon iconfont">&#xe60b;</i>
								<div class="register-inputbox">
									<input id="username" class="inputstyle" name="username"
										autocomplete="off" placeholder="用户名/邮箱">
								</div>
								<div class="error-tips"></div>
								<div class="del-touch"></div></li>
							<li class="username-login"><i class="icon iconfont">&#xe60a;</i>
								<div class="register-inputbox">
									<input id="password" class="inputstyle" name="password"
										type="password" autocomplete="off" placeholder="密码">
								</div>
								<div class="error-tips"></div>
								<div class="del-touch"></div></li>
						</ul>
						<div class="register-submit pb0">
							<input type="submit" value="登录">
						</div>
					</form>
					<p class="pwd-tips">
						<a href="<cms:getProjectBasePath/>user/findPwd" class="fr">忘记密码？</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script type="text/javascript">
$(function(){
	if(!document.referrer){
		$('.return-back').hide();
	}
	var userchk=false,paschk=false,
		userInput=$("#username"),
		passInput=$("#password");
	
	userInput.on("input",function(){
		if(userInput.val()!=""){
			userchk=true;
		}
		if(userchk&&paschk){
			$('.register-submit input').addClass('cksure');
		}
	})
	passInput.on("input",function(){
		if(passInput.val()!=""){
			paschk=true;
		}
		if(userchk&&paschk){
			$('.register-submit input').addClass('cksure');
		}
	})
	
	$('.register-submit input').click(function(e){
		if($.trim(userInput.val())==""){
			layer.open({
				content:'请输入用户名或邮箱!',
				time:1.5,
			})
			userInput.val('');
			//userInput.focus();
			userchk=false;
			return false;
		}else{
			userchk=true;
		}

		if($.trim(passInput.val())==""){
			layer.open({
				content:'请输入密码!',
				time:1.5,
			})
			passInput.val('');
			paschk=false;
			return false;
		}else{
			paschk=true;
		}
		if(userchk&&paschk){
			$.ajax({
				type:'POST',
				data:$('#login_form').serialize(),
				url:'<cms:getProjectBasePath/>user/login',
				success:function(data){
					if(data.status==1){
						if(data.message == "您提交的校外访问申请已经审核通过！") {
	                    	var index=layer.open({
	                    		content:data.message,
	                    		time:2000,
	                    		yes: function(index, layero){
                    		    //layer.close(index);
                    		    window.location="<cms:getProjectBasePath/>";
                    		  }
	                    	});
	                    	 setTimeout(function(){
	 	                        window.location="<cms:getProjectBasePath/>";
	 	                    },2000)
	                    } else {
		                    setTimeout(function(){
		                        window.location="<cms:getProjectBasePath/>";
		                    },200)
	                    }
	     			}else{
	     				layer.open({
							content:data.message,
							time:2000,
						})
	     			}
				},
				error:function(data){
					
				}
			})
		}
		e.preventDefault();
	});
});
</script>
</body>
</html>