<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>找回密码</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script
	src="<cms:getProjectBasePath/>resources/xsfx/js/jquery-1.8.3.min.js"></script>
<link href="<cms:getProjectBasePath/>/resources/back/css/admin.css"
	rel="stylesheet" type="text/css">
<link href="<cms:getProjectBasePath/>/resources/back/css/adminpage.css"
	rel="stylesheet" type="text/css">
<link href="<cms:getProjectBasePath/>/resources/back/css/findwd.css"
	rel="stylesheet" type="text/css">
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>
<script src="<cms:getProjectBasePath/>/resources/back/js/layer/layer.js"></script>
</head>
<body style="background: #E3E8E2;">

	<div class="header" style="height: 70px;">
		<div class="headwrap">
			<a href="#" class="logo"></a>
			<div class="logotext">
				<span>|</span> 找回密码
			</div>
		</div>
	</div>
	<div id="content">
		<div class="register">
			<div class="main ">
				<div class="pwdCont">
					<form method="post"
						action="<cms:getProjectBasePath/>backend/member/list/findPwd"
						class="findpwd-form" novalidate="novalidate">
						<ul>
							<li><label><em>*</em>账号：</label> <input type="text"
								placeholder="" autocomplete="off" class="reg-put" id="username"
								name="username" value="" placeholder=""> <span
								class="item-tip">请输入您的邮箱账号或用户名</span></li>
							<li><label><em>*</em>验证码：</label> <input type="text"
								class="reg-put w" name="code" id="code" autocomplete="off">
								<img src="<cms:getProjectBasePath/>backend/img" width="100"
								height="40" id="valiycode"> <span><a
									href="javascript:changeValiyCode()">看不清?换一个</a></span> <script
									type="text/javascript">
                                    var aa = "${email }";
                                    if (aa != "") {
                                    	alert(aa);
                                    }
                                    	function changeValiyCode(){
                                    		$('#valiycode').attr('src','<cms:getProjectBasePath/>backend/img?__time='+(new Date()).getTime());
                                    	}
                                    	$(function(){
                                    		$('.findpwd-form').validate({
                                    			submitHandler:function(form){
                                    					form.submit();
                                    			},
                                    			errorPlacement:function(error, element){
                                    				var next=element.next();
                                    				if(next.hasClass('item-tip')){
                                    					next.removeClass('item-pass');
                                    					if(!next.hasClass('item-error')){
                                    						next.addClass('item-error');
                                    						next.css('color','red');
                                    					}
                                    					next.text(error.text());
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
                                    					next.css('color','green');
                                    				}
                                    			},
                                    			rules:{
                                    				username:{
                                    					required:true,
                                    					rangelength:[6,20],
                                    					remote: {
                                    					    url: "<cms:getProjectBasePath/>user/findPwdUser",     //后台处理程序
                                    					    type: "post",               //数据发送方式
                                    					    dataType: "json",           //接受数据格式   
                                    					    data: {                     //要传递的数据
                                    					        email: function() {
                                    					            return $("#username").val();
                                    					        }
                                    					    }
                                    					}
                                    				},
                                    				code:{
                                    					required:true
                                    				}
                                    			},
                                    			messages:{
                                    				username:{
                                    					required:'请输入您的注册账号,或者注册邮箱!',
                                    					rangelength:'登录账号长度为6-15个字符',
                                    					remote:'邮箱或用户名不存在'
                                    				},
                                    				code:{
                                    					required:'验证码不能为空!'
                                    				}
                                    			}
                                    		});
                                    	});
                                    </script></li>
							<li><input type="submit" class="reg-btn" value="找回密码">
							</li>
						</ul>

					</form>
				</div>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>


</body>
</html>