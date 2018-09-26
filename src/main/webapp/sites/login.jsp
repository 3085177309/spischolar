<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp" />
<title>登录</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>登录</span>
					</div>
					<div class="fr lgbtn">
						我已注册，<a href="<cms:getProjectBasePath/>user/login">直接登录</a>
					</div>
				</div>
				<div class="reg-bd">
					<div class="loginbox-page">
						<div class="login-error-msg"></div>
						<form id="login_form" method="POST"
							action="<cms:getProjectBasePath/>user/login">
							<ul>
								<li><input type="text" class="login-input username"
									placeholder="昵称/邮箱" name="username" autocomplete="off"
									onfocus="this.style.color='#666'"></li>
								<li><input type="password" class="login-input password"
									placeholder="密码" name="password" autocomplete="off"
									onfocus="this.style.color='#666'"></li>
								<li class="login-bd"><a class="forget-pwd fr"
									href="<cms:getProjectBasePath/>user/findPwd">忘记密码?</a><input
									type="checkbox" name="rember" value="true" checked=""
									class="auto-login"><label for="iskeeppassword">下次自动登录</label></li>
								<li><button type="submit" class="login-btn"
										href="javascript:void(0);" onclick="" style="display: block">登陆</button></li>
							</ul>
						</form>
						<div class="social-login">
							<p>
								<span>可以使用以下方式登录</span><a href="javascript:void(0);" onclick=""></a>
							</p>
							<p class="tc">
								<a class="qq in">qq登陆</a><a class="weibo">微博登陆</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$('#login_form').submit(function(e){
				$(this).ajaxSubmit(function(data){
					if(data.status==1){
        				alert(data.message);
            			window.location.href="<cms:getProjectBasePath/>";
        			}else{
        				$('.login-error-msg').show();
        				$('.login-error-msg').text(data.message);
        			}
				});
				e.preventDefault();
			});
		});
</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
