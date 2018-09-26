<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>使用方法</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg">
		<div class="container">
			<div class="register border" id="qkminH">
				<div class="reg-hd bdbn">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>使用方法</span>
					</div>
				</div>
				<div class="single-bd">

					<div class="single-bd-con">
						<div class="single-bd-tit">1、 点击右侧"建议"图标,反馈框。</div>
						<div class="eassy">
							<img src="<cms:getProjectBasePath/>resources/images/u1.gif" />
						</div>
						<div class="single-bd-tit">2、点击截图，画选错误位置，填写错误描述，并填写联系方式。</div>
						<div class="eassy">
							<img src="<cms:getProjectBasePath/>resources/images/u2.gif" />
						</div>
						<div class="single-bd-tit">3、点击提交，反馈完成</div>
						<div class="eassy">
							<img src="<cms:getProjectBasePath/>resources/images/u3.gif" />
						</div>
						<div class="single-bd-tit">4、具体内容查看</div>
						<div class="eassy">添加图片</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>