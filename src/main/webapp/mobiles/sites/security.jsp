<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>账户安全</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>
</head>
<body class="fix-pbhieght">
	<div class="section-page">
		<header>
			<div class="headwrap">
				<a class="return-back" onclick="history.go(-1)"> <i
					class="icon iconfont">&#xe610;</i> <span>返回</span>
				</a>
				<div class="head-search" onclick="$('#reset_pwd_form').submit()">
					确定</div>
				<!-- <div class="userbox">
				<div class="userSelect">
					<i class="icon iconfont iconfuzhi">&#xe600;</i>
				</div>
			</div> -->
				<p class="section-tit">账户安全</p>
				<div class="clear"></div>
			</div>
		</header>
		<div class="item-section">
			<form method="post" action="<cms:getProjectBasePath/>user/security"
				id="reset_pwd_form">
				<ul class="usersetting-list">
					<li><span class="acount-span">原始密码</span>
						<div class="user-info-input">
							<input type="password" id="oldPwd" name="oldPwd" class="reg-put"
								autocomplete="off" placeholder="请输入当前密码">
						</div>
						<div class="error-tips"></div></li>
					<li><span class="acount-span">新密码</span>
						<div class="user-info-input">
							<input type="password" id="newPwd" name="newPwd" class="reg-put"
								autocomplete="off" placeholder="请设置登录密码">
						</div>
						<div class="error-tips"></div></li>
					<li><span class="acount-span">确认新密码</span>
						<div class="user-info-input">
							<input type="password" id="rePwd" name="rePwd" class="reg-put"
								autocomplete="off" placeholder="请再次输入">
						</div>
						<div class="error-tips"></div></li>
				</ul>

			</form>
			<p class="pwd-tips">密码由任意6-15个字符组成，注意区分大小写</p>
		</div>
		<script type="text/javascript">
   $(function(){
   	$('#reset_pwd_form').validate({
   		submitHandler:function(form){
		
   		$(form).ajaxSubmit(function(data){
   			if(!$('#oldPwd').val()){
				alert('原始密码不能为空！');
				$('#oldPwd').focus();
				return false;
			};
   			alert(data.message);
			if(data.status==1){
				window.location.href="<cms:getProjectBasePath/>"+data.redirect;
			}
		});
   		},
   		errorPlacement:function(error, element){
	        var next=$(element).parents().siblings(".error-tips");
	           next.html(error.html());
	         //  alert(error.html());
	         setTimeout(function(){
	        	 next.html("");
   				
   			},2000);
	           $(element).attr("placeholder",error.html());
	    },
	    success:function(element,label){
	    	$(element).addClass('success');	
	    	$(".register-submit").addClass("sure");
	    },
   		/*errorPlacement:function(error, element){
			var next=element.next();
			if(next.hasClass('item-tip')){
				next.removeClass('item-pass');
				if(!next.hasClass('item-error')){
					next.addClass('item-error');
				}
				next.html(error.html());
			}else{
				//alert(error.text());
			}
			//element.focus();
		},
		success:function(element,label){
			var next=$(label).next();
			if(next.hasClass('item-tip')){
				next.text('输入正确!');
				next.removeClass('item-error');
				if(!next.hasClass('item-error')){
					next.addClass('item-pass');
				}
			}
		},*/
		rules:{
			/*oldPwd:{
				required:true,
				rangelength:[6,15]
			},*/
			newPwd:{
				required:true,
				rangelength:[6,15]
			},
			rePwd:{
				equalTo:"#newPwd"
			}
			
		},
		messages:{
			/*oldPwd:{
				required:'格式不正确！',
				rangelength:'格式不正确！'
			},*/
			newPwd:{
				required:'新密码不能为空！',
				rangelength:'格式不正确！'
			},
			rePwd:{
				required:'确认密码不能为空!',
				equalTo:"密码输入不一致！"
			}
		}
   	});
   });
   </script>
	</div>
</body>
</html>
