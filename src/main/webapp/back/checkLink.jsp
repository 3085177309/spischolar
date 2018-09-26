<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>重置密码</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script
	src="http://spischolar.com:80/resources/xsfx/js/jquery-1.8.3.min.js"></script>
<link href="<cms:getProjectBasePath/>/resources/back/css/admin.css"
	rel="stylesheet" type="text/css">
<link href="<cms:getProjectBasePath/>/resources/back/css/adminpage.css"
	rel="stylesheet" type="text/css">
<link href="<cms:getProjectBasePath/>/resources/back/css/findwd.css"
	rel="stylesheet" type="text/css">
<script src="http://spischolar.com:80/resources/js/jquery.form.js"></script>
<script src="http://spischolar.com:80/resources/js/jquery.validate.js"></script>
</head>
<body style="background: #E3E8E2;">
	<div class="header" style="height: 70px;">
		<div class="headwrap">
			<a href="#" class="logo"></a>
			<div class="logotext">
				<span>|</span> 重置密码
			</div>
		</div>
	</div>
	<div id="content">
		<div class="register">
			<div class="main ">
				<div class="pwdCont">
					<form method="post"
						action="http://spischolar.com:80/user/resetPwdUL"
						class="resetpwd-form" novalidate="novalidate">
						<input type="hidden" name="id" value="12958">
						<ul>
							<li><label><em>*</em>新密码</label> <input type="password"
								placeholder="" autocomplete="off" id="newPwd" class="reg-put"
								name="newPwd"> <span class="item-tip"> </span></li>
							<li><label><em>*</em>请确认新密码</label> <input type="password"
								placeholder="" autocomplete="off" id="rePwd" class="reg-put"
								name="rePwd"> <span class="item-tip"> </span></li>
							<li><button type="submit" class="reg-btn">重置密码</button></li>
						</ul>

					</form>
					<script type="text/javascript">
                              $(function(){
                                    $('.resetpwd-form').validate({
                                          submitHandler:function(form){
                                          $(form).ajaxSubmit(function(data){
                                                alert(data.message);
                                                if(data.status==1){
                                                       var username = '123465';
                                                       $("#account_input").val(username);
                                                       $("#pwd_input").val('');
                                                       $("#login-btn").trigger("click");
                                                      
                    //                                window.location="http://spischolar.com:80/";//跳转到登录页面
                                                }
                                          });
                                          },
                                          
                                          errorPlacement:function(error, element){
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
                                          },
                                          rules:{
                                                newPwd:{
                                                      required:true,
                                                      rangelength:[6,15]
                                                },
                                                rePwd:{
                                                      equalTo:"#newPwd"
                                                }
                                                
                                          },
                                          messages:{
                                                newPwd:{
                                                      required:'密码由任意6-15个字符组成，注意区分大小写!',
                                                      rangelength:'密码由任意6-15个字符组成，注意区分大小写!'
                                                },
                                                rePwd:{
                                                       equalTo:"两次密码输入不一致"
                                                }
                                          }
                                    });
                              });
                        </script>
				</div>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>
</body>
</html>