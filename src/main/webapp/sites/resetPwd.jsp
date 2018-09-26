<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp" />
<title>重置密码</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="wraper bg">
					<div class="container">
						<div class="register border">
							<div class="reg-hd">
								<div class="logo fl">
									<span>重置密码</span>
								</div>
								<div class="fr lgbtn"></div>
							</div>
							<c:if test="${not empty message  }">
								<div class="reg-bd">
									<h1 style="font-size: medium;">${message }</h1>
								</div>
							</c:if>
							<c:if test="${empty message  }">
							<div class="reg-bd">
								<form method="post"
									action="<cms:getProjectBasePath/>user/resetPwdUL"
									class="resetpwd-form">
									<input type="hidden" name="id" value="${member.id }" />
									<ul>
										<li><label><em>*</em>新密码</label> <input type="password"
											placeholder="" id="newPwd" class="reg-put" name="newPwd" />
											<span class="item-tip"> </span></li>
										<li><label><em>*</em>请确认新密码</label> <input
											type="password" placeholder="" id="rePwd" class="reg-put"
											name="rePwd" /> <span class="item-tip"> </span></li>
									</ul>
									<button type="submit" class="reg-btn">重置密码</button>
								</form>
								<script type="text/javascript">
					            $(function(){
					            	$('.resetpwd-form').validate({
					            		submitHandler:function(form){
					            		$(form).ajaxSubmit(function(data){
					            			alert(data.message);
					            			if(data.status==1){
					            				 var username = '${member.username}';
					            				 $("#account_input").val(username);
					            				 $("#pwd_input").val('');
					            				 $("#login-btn").trigger("click");
					            				
					  //          				window.location="<cms:getProjectBasePath/>";//跳转到登录页面
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
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>