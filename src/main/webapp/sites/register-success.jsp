<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp" />
<title>注册</title>
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
						<span><em>|</em>欢迎加入</span>
					</div>
					<div class="fr lgbtn">
						我已注册，<a href="#">直接登录</a>
					</div>
				</div>
				<div class="reg-bd">
					<p class="tc reg-font">
						<img src="<cms:getProjectBasePath/>resources/images/chenggong.png" />还差一步即可完成注册
					</p>
					<p class="tc">我们已经向您的邮箱${sessionScope.register_email}发送了一封激活邮件，请点击邮件中的链接完成注册！</p>
					<p class="tc" style="margin-top: 20px;">
						<a href="" class="login-btn">立即进入邮箱</a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
