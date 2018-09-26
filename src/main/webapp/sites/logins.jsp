<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>登录</title>
</head>
<body>

	<c:if test="${not empty isImposedOuts }">
		<script type="text/javascript">
		alert("你的账号在其他地方登陆，如非本人操作，请修改密码！");
	</script>
	</c:if>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<div class="navbar clearfix">
						<div class="logo">
							<a href="<cms:getProjectBasePath/>" alt="Spischolar">Spischolar</a>
						</div>
					</div>
				</div>
				<div class="lgbg">
					<div class="lgcontain">
						<div class="bgtab">
							<div id="banner">
								<div class="PIC">
									<a href="javascript:void(0);"><img
										src="<cms:getProjectBasePath/>resources/images/login2.png"></a>
									<a href="javascript:void(0);"><img
										src="<cms:getProjectBasePath/>resources/images/login1.png"></a>
								</div>
								<div class="bj"></div>
								<div class="bannerlist">
									<span class="in"></span> <span class=""></span>
								</div>
							</div>
						</div>
						<div class="lgfixbox">
							<h3 class="loginTit">登录</h3>
							<div class="loginbox">
								<form id="login_form" method="POST"
									action="<cms:getProjectBasePath/>user/login">
									<ul>
										<li><input type="text" class="login-input username"
											placeholder="用户名/邮箱" id="account_input" name="username"
											autocomplete="off" onfocus="this.style.color='#666'"></li>
										<li><input type="password" class="login-input password"
											placeholder="密码" id="pwd_input" name="password"
											autocomplete="off" onfocus="this.style.color='#666'"></li>
										<li class="login-bd"><a class="forget-pwd fr"
											href="<cms:getProjectBasePath/>user/findPwd">忘记密码?</a><input
											type="checkbox" name="rember" id="iskeeppassword"
											value="true" checked="" class="auto-login"><label
											for="iskeeppassword">下次自动登录</label></li>
										<li><button type="submit" class="login-btn"
												style="display: block">登录</button></li>
									</ul>
									<div id="ipnone" style="display: none">
										<script type="text/javascript"
											src="http://ip.chinaz.com/getip.aspx"></script>
									</div>

								</form>
								<div class="login-error-msg" style="visible: hidden">
									友情提示：请于校园网内访问，注册并成功申请校外登录后方可在外网访问。</div>
								<div id="ip" class="ipInfo">当前IP：${visitIP }</div>
								<script type="text/javascript">
        		$(function(){

        			$('#login_form').submit(function(e){
        				var username = $('#account_input').val() || $('#account_input').attr('value');
        				var pwd = $('#pwd_input').val();
        				if(username == '' || pwd == '' || username.trim().length == 0) {
        					alert("用户名或密码不能为空");
        					return false;
        				}
        				$(this).ajaxSubmit(function(data){
        					if(data.status==1){
                				/* alert(data.message); */
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

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
