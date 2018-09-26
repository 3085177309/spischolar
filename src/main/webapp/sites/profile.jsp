<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp" />
<link href="<cms:getProjectBasePath/>resources/css/chosen.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/js/chosen.jquery.js"></script>
<title>基本信息</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="user-man-box">
					<a href="<cms:getProjectBasePath/>user/dilivery">文献互助</a> <a
						href="<cms:getProjectBasePath/>user/history">检索历史</a> <a
						href="<cms:getProjectBasePath/>user/favorite">我的收藏</a> <a
						href="javascript:void(0)" class="in">账户管理</a>
				</div>

				<!-- <div class="statistics-user-box"></div> -->
				<div class="wraper bg">
					<div class="container">
						<div class="user-man-wraper">

							<jsp:include page="include/user-sider.jsp"></jsp:include>

							<div class="user-man-main border">
								<div class="user-man-hd" id="nickname">基本信息</div>
								<p class="inftips" style="display: none;">请完善基本信息，保存后再提交申请</p>
								<form action="<cms:getProjectBasePath/>user/profile"
									method="post" id="profile_home">
									<ul class="user-man-info">
										<li class="email"><label>登录邮箱<em>*</em>：
										</label> <span class="text-box">${sessionScope.front_member.email }</span></li>
										<li class="outwarm">
											<div class="">
												<c:if
													test="${member.permission == 0 || member.permission == 5}">
													<i class="outimg-none"></i>
													<span>您无校外访问权限！<i>请点击</i></span>
													<a href="<cms:getProjectBasePath/>user/applyLogin"
														class="applybtn">立即申请</a>
													<!-- <p class="inftips status1">请完善基本信息，保存后再提交申请</p> -->
												</c:if>
												<c:if
													test="${member.permission == 1 || member.permission == 3}">
													<p class="inftips status2">您已经获得长期校外访问权限！</p>
												</c:if>
												<c:if test="${member.permission == 2 }">
													<p class="inftips status4">您提交的校外访问正在申请审核中，请耐心等待...</p>
												</c:if>
												<c:if test="${member.permission == 4 }">
													<p class="inftips status3">您已获得6个月的校外访问权限，上传本人教职工证或学生证图片，可获得长期校外访问权限！</p>
												</c:if>

												<%-- <c:if test="${member.permission ==0 }">
													<i class="outimg-none"></i>
													<span>您无校外访问权限！<i>请点击</i></span>
													<a href="<cms:getProjectBasePath/>user/applyLogin"
														class="applybtn">立即申请</a>
												</c:if>
												<c:if
													test="${member.permission ==1 || member.permission ==3}">
													<i class="outimg-success"></i>
													<span>您已经获得校外访问权限！</span>
												</c:if>
												<c:if test="${member.permission ==2 }">
													<i class="outimg-ing"></i>
													<span>正在审核您的校外访问申请，请耐心等待。</span>
												</c:if> --%>
											</div>
										</li>
										<li><label>用户名<em>*</em>：
										</label> <span class="text-box">${sessionScope.front_member.username }</span>
										</li>

										<input name="permission" type="hidden"
											value="${member.permission }">
										<input name="sex" type="hidden" value="${member.sex }">
										<input type="hidden"
											value="${empty member.education ? '' : member.education }"
											name="education">
										<input type="hidden"
											value="${empty member.entranceTime ? '': member.entranceTime }"
											name="entranceTime" id="entranceTime" />
										<input type="hidden" class="info-input" id="studentId"
											name="studentId" value="${member.studentId }" />
										<input type="hidden"
											value="${empty member.identity ? '': member.identity }"
											name="identity" id="identity" />
										<input type="hidden" name="department"
											value="${member.department }" class="info-input" />
										<input type="hidden" schoolId="" name="school"
											value="${member.school }" class="info-input" />
										<input type="hidden" name="nickname"
											value="${member.nickname }" class="info-input" />
										<input type="hidden" schoolId="" name="schoolFlag"
											value="${member.schoolFlag }" class="info-input" />


										<li><label><em>&nbsp;</em>QQ：</label> <span
											class="text-box"><input type="text" class="info-input"
												name="qq" value="${member.qq }" /></span> <span class="item-tip"></span>
										</li>
										<li><label><em>&nbsp;</em>手机号：</label> <span><input
												type="text" class="info-input" name="phone"
												value="${member.phone }" /></span> <span class="item-tip"></span></li>
										<li style="height: 180px;"><label
											style="vertical-align: top"><em>&nbsp;</em>个人简介：</label> <span>
												<textarea class="textarea" name="intro">${member.intro }</textarea>
										</span> <span class="item-tip"></span></li>
										<li><label><em>&nbsp;</em></label> <span>
												<button type="submit" id="a" class="btn-ensave">保存</button>
										</span></li>
									</ul>
								</form>
							</div>
						</div>
					</div>
				</div>

				<script
					src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
					type="text/javascript"></script>


				<script type="text/javascript">
					var success = '${success }';
					if (success != "") {
						alert(success);
					}
					var emailEle = $(".email span"), emailVal = emailEle.html();
					var fletter = $
							.trim(emailVal.split("@")[0].substring(0, 1));
					var lletter = $.trim(emailVal.split("@")[0].substring(
							emailVal.split("@")[0].length - 1, emailVal
									.split("@")[0].length));
					emailEle.html(fletter + '...' + lletter + '@'
							+ emailVal.split("@")[1])

					$.validator.setDefaults({
						ignore : ''
					});
					//表单验证
					$('#profile_home')
							.validate(
									{
										submitHandler : function(form) {
											$(form).Submit();
										},
										errorPlacement : function(error,
												element) {
											var next = element.parents()
													.siblings(".item-tip");
											//console.log(next)
											next.html(error.html());
										},
										success : function(element, label) {
										},
										rules : {

											qq : {
												required : "#qq:checked",
												number : true,
												rangelength : [ 6, 12 ]
											},
											phone : {
												required : "#phone:checked",
												number : true,
												rangelength : [ 11, 11 ]
											},
											intro : {
												required : "#intro:checked",
												rangelength : [ 0, 500 ]
											}
										//
										},
										messages : {

											qq : {
												number : '<span class="item-tip item-error">请输入正确的QQ号码！</span>',
												rangelength : '<span class="item-tip item-error">请输入正确长度的QQ号码！</span>'
											},
											phone : {
												number : '<span class="item-tip item-error">请输入11位的手机号码！</span>',
												rangelength : '<span class="item-tip item-error">请输入11位的手机号码！</span>'
											},
											intro : {
												required : '<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>',
												rangelength : '<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>'
											}
										}
									});
				</script>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
