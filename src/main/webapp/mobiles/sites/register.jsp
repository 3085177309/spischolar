<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>spischolar注册</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="mui-scroll">
				<header>
					<div class="headwrap">
						<div class="return-back" onclick="history.go(-1)">
							<i class="icon iconfont">&#xe610;</i> <span><a>返回</a></span>
						</div>
						<p class="section-tit">注册</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<form id="profile_home" method="post"
						action="<cms:getProjectBasePath/>user/register" data-ajax="false"
						enctype="multipart/form-data">
						<div class="loginbox registerbox">
							<ul class="usersetting-list mt0">
								<li><span class="acount-span">登录邮箱</span>
									<div class="user-info-input">
										<input type="text" id="email" name="email" placeholder="请输入邮箱">
									</div>
									<div class="error-tips"></div></li>
								<li><span class="acount-span">用户名</span>
									<div class="user-info-input">
										<input type="text" id="username" name="username"
											placeholder="请输入用户名">
									</div>
									<div class="error-tips"></div></li>
								<li><span class="acount-span">登录密码</span>
									<div class="user-info-input">
										<input type="password" id="pwd" name="pwd" placeholder="请输入密码">
									</div>
									<div class="error-tips"></div></li>
								<li><span class="acount-span">确认密码</span>
									<div class="user-info-input">
										<input type="password" id="repwd" name="repwd"
											placeholder="请再次输入密码">
									</div>
									<div class="error-tips"></div></li>
							</ul>
						</div>

						<p class="service-tips mb0">
							<label> <input class="service-checkbox" type="checkbox"
								checked />
							</label> <a href="<cms:getProjectBasePath/>/mobiles/sites/service2.jsp">我已阅读并同意条款《用户服务条款》</a>

						</p>
						<input type="hidden" name="isMobile" value="yes" />
						<div class="register-submit">
							<input type="submit" value="注册">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
	$(".registerbox .usersetting-list input").each(function(){
		$(this).on({
			keydown:function(){
				if(event.keyCode == 32){
					return false;
				}
			},
			keyup:function(){
				var va =$(this).val().replace(/[\s]/g,"");
				$(this).val(va);
			},
			blur:function(){
				var va =$(this).val().replace(/[\s]/g,"");
				$(this).val(va);
			}
		})
	})
$.validator.setDefaults({ ignore: '' });
jQuery.validator.addMethod("byteRangeLength", function (value, element, param) {
    var length = value.length;
    for (var i = 0; i < value.length; i++) {
        if (value.charCodeAt(i) > 127) {
            length++;
        }
    }
    return this.optional(element) || (length >= param[0] && length <= param[1]);
}, $.validator.format("6-15个字符!"));
//表单验证
jQuery(function(){
	$('.register-submit input').click(function(e){
		if($('#email').val()==''){
			layer.open({
    			content:'请输入您的邮箱！',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}
		else if($('#username').val()==''){
			layer.open({
    			content:'请输入用户名！',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($('#pwd').val()==''){
			layer.open({
    			content:'请输入密码！',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}
		else if($('#repwd').val()==''){
			layer.open({
    			content:'请再次输入密码！',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}
		else{
			$('#profile_home').validate({
				onkeyup:false,
				onfocusout:false,
			    submitHandler:function(form){
			       $(form).ajaxSubmit(function(data){
			    		if(data.status==1){
			    			alert(data.message);
				       		window.location.href="<cms:getProjectBasePath/>";
				   		}
			    	});
			    },
			    errorPlacement:function(error, element){
			    	if(error.text()){
		        		layer.open({
		        			content:error.text(),
		        			time:2
		        		})
		        		console.log(error.text());
		        		return false;
		        	}
			    },
			    success:function(element,label){

			    	$(element).addClass('success');
			    	$(".register-submit").addClass("sure");
			    },
			    rules:{
			    	
					username:{
						required:true,
						byteRangeLength:[6,15],
						remote: {
						    url: "<cms:getProjectBasePath/>user/checkUsername",     //后台处理程序
						    type: "get",               //数据发送方式
						    dataType: "json",           //接受数据格式   
						    data: {                     //要传递的数据
						    	username: function() {
						            return $("#username").val();
						        }
						    }
						}
					},
					pwd:{
						required:true,
						rangelength:[6,15]
					},
					repwd:{
						required:true,
						equalTo:"#pwd"
					},
					email:{
						required:true,
						email:true,
						remote: {
						    url: "<cms:getProjectBasePath/>user/checkEmail",     //后台处理程序
						    type: "get",               //数据发送方式
						    dataType: "json",           //接受数据格式   
						    data: {                     //要传递的数据
						        email: function() {
						            return $("#email").val();
						        }
						    }
						}
					}
			    },
			    messages:{
					username:{
						required:'请输入用户名！',
						rangelength:'用户名6-15个字符!',
						remote:'该用户名已注册!'
					},
					pwd:{
						required:'请输入密码！',
						rangelength:'密码6-15个字符组成'
					},
					repwd:{
						required:'请再次输入密码！',
						 equalTo:"两次密码输入不一致"
					},
					email:{
						required:'请输入您的邮箱!',
						email:'邮箱格式不能使用!',
						remote:'该邮箱已注册!'
					}
			    }
			});
		}
		
	})
	
});
</script>

</body>
</html>