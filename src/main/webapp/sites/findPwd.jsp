<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp" />
<title>找回密码</title>
</head>
<body>
	<c:if test="${status !=5 }">
		<div class="head sub-head">
			<jsp:include page="include/navbar.jsp"></jsp:include>
		</div>
	</c:if>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd">
					<div class="logo fl">
						<span>找回密码</span>
					</div>
					<div class="fr lgbtn"></div>
				</div>
				<div class="reg-bd">
					<form method="post" action="<cms:getProjectBasePath/>user/findPwd"
						class="findpwd-form">
						<ul>
							<li><label><em>*</em>账号</label> <input type="text"
								placeholder="" class="reg-put" id="username" name="username"
								value="${member.nickname }" /> <span class="item-tip">请输入您的邮箱账号或用户名</span>
							</li>
							<li><label><em>*</em>验证码</label> <input type="text"
								class="reg-put w" name="code" id="code" /> <img
								src="<cms:getProjectBasePath/>backend/img" width="80"
								height="24" id="valiycode"> <span><a
									href="javascript:changeValiyCode()" style="color: grey">看不清楚，换一个</a></span>
								<script type="text/javascript">
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
                        					required:'请输入您注册账号的邮箱或用户名!',
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

						</ul>
						<button type="submit" class="reg-btn">找回密码</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
