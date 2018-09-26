<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>账户信息</title>
<jsp:include page="include/meta.jsp"></jsp:include>

<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>

</head>
<body>
	<div class="page" id="pageHome" style="overflow: auto;">
		<!--<div class="section-page" >-->
		<div class="mui-content mui-scroll-wrapper">
			<div class="mui-scroll">
				<header>
					<div class="headwrap">
						<a class="return-back" onclick="history.go(-1)"<%-- href="<cms:getProjectBasePath/>user/account" --%>>
							<i class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<!-- <div class="head-search">
						<i class="icon iconfont">&#xe604</i>
					</div> -->
						<!-- <div class="userbox">
						<div class="userSelect">
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
						<p class="section-tit">基本信息</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<div class="loginbox registerbox">
						<ul class="usersetting-list mt0">
							<li><span class="acount-span">登录邮箱</span>
								<div class="user-info-input">
									<!-- <input type="text" placeholder="请输入邮箱" value="wangxinmin@hnwdkj.com" readonly="readonly" tabindex="-1"> -->
									<span>${front_member.email }</span>
								</div></li>
							<li><span class="acount-span">用户名</span>
								<div class="user-info-input">
									<!-- <input type="text" placeholder="" value="Miss.W" tabindex="-1" readonly="readonly"> -->
									<span>${front_member.username }</span>
								</div></li>
						</ul>
					</div>

					<form action="<cms:getProjectBasePath/>user/profile" method="post"
						id="profile_home">
						<p class="list-top-info">选填项</p>
						<div class="loginbox registerbox mt0">
							<ul class="usersetting-list mt0">
								<li><span class="acount-span">QQ</span>
									<div class="user-info-input">
										<input type="number" name="qq" placeholder="请填写"
											value="${member.qq }"
											<c:if test="${not empty member.qq  }">class="c33"</c:if>>
									</div>
									<div class="error-tips"></div></li>
								<li><span class="acount-span">手机号</span>
									<div class="user-info-input">
										<input type="text" placeholder="请填写" name="phone"
											value="${member.phone }"
											<c:if test="${not empty member.phone  }">class="c33"</c:if>>
									</div>
									<div class="error-tips"></div> <!-- 手机号
							<i class="icon iconfont fxj">&#xe60e;</i>
							<a href="#" class="userinfo-value">请填写</a> --></li>
								<li class="border-none"><a class="profileclick"> <span
										class="acount-span">简介</span> <i class="icon iconfont fxj">&#xe60e;</i>
										<div class="user-info-input">
											<c:choose>
												<c:when test="${not empty member.intro  }">
													<c:choose>
														<c:when test="${member.intro.length()>6 }">
															<span class="userinfo-value">${member.intro.substring(0,6) }...</span>
														</c:when>
														<c:otherwise>
															<span class="userinfo-value">${member.intro }</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="userinfo-value">请填写</span>
												</c:otherwise>
											</c:choose>
										</div>
								</a></li>
								<li class="profilebox"><textarea id="intro"
										class="profilearea" name="intro" cols="30" rows="10"
										placeholder="请输入简介..." value="${member.intro }">${member.intro }</textarea>
								</li>
							</ul>
						</div>
						<div class="register-submit">
							<input type="submit" value="确认修改">
						</div>
					</form>
				</div>
			</div>
		</div>
		<!--</div>-->
	</div>

	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>

</script>
	<script>

$('.profileclick').click(function(){
	if($(this).hasClass('active')){
		$(this).removeClass('active');
		$('.profilebox').hide();
		myScroll.refresh(); 
	}else{
		$(this).addClass('active')
		$('.profilebox').show();
		myScroll.refresh(); 
	}
	
})
	
	$.validator.setDefaults({ ignore: '' });
	//表单验证
	$('#profile_home').validate({
		onkeyup:false,
		onfocusout:false,
        submitHandler:function(form){
        	 form.submit();
        },
        errorLabelContainer:".layermcont",
        errorPlacement:function(error, element){
        	if(error.text()){
        		layer.open({
        			content:error.text(),
        			time:2
        		})
        	}
	    },
	    success:function(element,label){
	    	$(element).addClass('success');	
	    	$(".register-submit").addClass("sure");
	    },

        rules:{
            qq:{
            	required:"#qq:checked",
                number:true,
                rangelength:[6,12],
            },
            phone:{
            	required:"#phone:checked",
                number:true,
                rangelength:[11,11]
            },
            intro:{
            	required:"#intro:checked",
                rangelength:[0,500]
            }
        },
        messages:{
            qq:{
                number:'<span class="item-tip item-error">请输入正确的QQ号码！</span>',
                rangelength:'<span class="item-tip item-error">请输入正确长度的QQ号码！</span>',
            },
            phone:{
                number:'<span class="item-tip item-error">请输入11位的手机号码！</span>',
                rangelength:'<span class="item-tip item-error">请输入11位的手机号码！</span>',
            },
            intro:{
                required:'<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>',
                rangelength:'<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>',
            }
        }
	});
	var success = '${success }';
	if(success != "") {
		layer.open({
			content:success,
			time:2
		});
	}
</script>
</body>
</html>
