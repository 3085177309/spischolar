<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp" />
<title>账户安全</title>
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
				<div class="wraper bg">
					<div class="container">
						<div class="user-man-wraper">

							<jsp:include page="include/user-sider.jsp"></jsp:include>

							<div class="user-man-main border">
								<div class="user-man-hd">账户安全：</div>
								<div class="user-man-bd">
									<p class="p">密码由任意6-15个字符组成，注意区分大小写</p>
									<div class="modify-pwa">
										<form method="post"
											action="<cms:getProjectBasePath/>user/security"
											id="reset_pwd_form">
											<ul class="user-man-info">
												<li><label>原始密码<em>*</em>：
												</label> <input type="password" id="oldPwd" name="oldPwd"
													class="reg-put" autocomplete="off"></li>
												<li><label>新密码<em>*</em>：
												</label> <input type="password" id="newPwd" name="newPwd"
													class="reg-put" autocomplete="off"> <span
													class="item-tip"> </span></li>
												<li><label>确认密码<em>*</em>：
												</label> <input type="password" id="rePwd" name="rePwd"
													class="reg-put" autocomplete="off"> <span
													class="item-tip"> </span></li>
												<li><label>&nbsp;</label>
													<button type="submit" class="btn-ensave fl">保存</button></li>
											</ul>
										</form>

										<script type="text/javascript">
			                        $(function(){
			                        	$('#reset_pwd_form').validate({
			                        		submitHandler:function(form){
			                        		$(form).ajaxSubmit(function(data){
			                        			alert(data.message);
			                    				if(data.status==1){
			                    					window.location.href="<cms:getProjectBasePath/>"+data.redirect;
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
			                    					
			                    				}
			                    				
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
			                        
			                        
			                        
			                        var emailEle=$(".email span"),emailVal=emailEle.html();
			                        var fletter=emailVal.split("@")[0].substring(0,1).trim();
			                        var lletter=emailVal.split("@")[0].substring(emailVal.split("@")[0].length-1,emailVal.split("@")[0].length).trim();
			                        emailEle.html(fletter+'...'+lletter+'@'+emailVal.split("@")[1])
			                        </script>
									</div>
								</div>
							</div>
							<div class="clear"></div>
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