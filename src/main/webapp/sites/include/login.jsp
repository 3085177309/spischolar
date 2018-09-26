<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>




<!-- 登陆弹窗 -->
<div class="showWin-new showWin lgWin" id="lgWin">
	<div class="Win-bj">
		<div class="Win-cont">
			<h3 id="Win-T">
				<div class="loginTab">
					<a class="log" href="javascript:;">登录</a> <a class="re"
						href="javascript:;">注册</a> <i class="line"></i>
				</div>
				<span class="Win-close"></span>
			</h3>
			<div class="Win-pannel">
				<div class="modaltab active loginTabbox">
					<div class="loginbox">
						<form id="ajax_login_form" method="POST"
							action="<cms:getProjectBasePath/>user/login" autocomplete="off">
							<ul>
								<li style="*z-index: 5"><label for="username"
									class="login-icon icon-username"></label> <input type="text"
									class="login-input username" placeholder="用户名/邮箱"
									id="account_input" name="username" autocomplete="off">
									<span class="placeholder-poill" style="display: none">用户名/邮箱</span>
								</li>
								<li style="*z-index: 4"><label
									class="login-icon icon-password"></label> <input
									type="password" class="login-input password" placeholder="密码"
									id="pwd_input" name="password" autocomplete="off"> <span
									class="placeholder-poill" style="display: none">密码</span></li>
								<li class="login-bd"><a class="forget-pwd fr"
									href="<cms:getProjectBasePath/>user/findPwd" tabindex="-1">忘记密码?</a><input
									type="checkbox" name="rember" id="iskeeppassword" value="true"
									checked="" class="auto-login"><label
									for="iskeeppassword">下次自动登录</label></li>
								<li class="mb0"><label class="login-submit-label"><button
											id="login_btn" class="login-btn" style="display: block">登录</button></label></li>
							</ul>
						</form>

						<div class="login-error-box" style="display: none">我是错误提示信息</div>
					</div>
					<hr class="loginhr">
					<div class="login-fd">
						<a class="register-btn">立即注册</a>还没有账户？
					</div>
				</div>

				<div class="modaltab regTabbox">
					<div class="loginbox registerbox">
						<form method="post"
							action="<cms:getProjectBasePath/>user/register"
							class="register-form">
							<ul>
								<li style="*z-index: 6"><label><em>*</em>登录邮箱</label> <input
									type="text" id="email" name="email" placeholder="请输入邮箱"
									class="login-input" value="${member.email }" /> <span
									class="item-tip"> 请输入您的登录邮箱</span> <span
									class="placeholder-poill" style="display: none">请输入邮箱</span></li>
								<li style="*z-index: 5"><label><em>*</em>用户名</label> <input
									type="text" placeholder="请输入用户名" class="login-input"
									id="username" name="username" value="${member.username }"
									autocomplete="off" /> <span class="item-tip" id="usernames">用户名长度为6-15个字符，仅支持英文、数字、下划线、不允许重名。一经设置，无法更改</span>
									<span class="placeholder-poill" style="display: none">请输入用户名</span>
								</li>
								<li style="*z-index: 4"><label><em>*</em>登录密码</label> <input
									type="password" class="login-input" id="pwd" name="pwd"
									value="${member.pwd }" placeholder="请输入密码" /> <span
									class="item-tip"> 密码由任意6-15个字符组成，注意区分大小写</span> <span
									class="placeholder-poill" style="display: none">请输入密码</span></li>
								<li style="*z-index: 3"><label><em>*</em>确认密码</label> <input
									type="password" class="login-input" id="repwd" name="repwd"
									value="${repwd }" placeholder="确认密码" /> <span class="item-tip">密码由任意6-15个字符组成，注意区分大小写</span>
									<span class="placeholder-poill" style="display: none">确认密码</span>
								</li>
								<li style="*z-index: 2"><label><em>*</em>验证码</label> <!-- <input type="text" class="login-input w" name="code" > -->
									<input type="text" class="login-input reg-put w valid"
									name="code" placeholder="请输入验证码"> <span
									class="item-tip ValiyCode"></span> <span
									class="placeholder-poill" style="display: none">请输入验证码</span> <img
									src="<cms:getProjectBasePath/>backend/img" width="80"
									height="38" id="valiycode"
									onclick="javascript:changeValiyCode()"> <script
										type="text/javascript">
		                        	function changeValiyCode(){
		                        		$('#valiycode').attr('src','<cms:getProjectBasePath/>backend/img?__time='+(new Date()).getTime());
		                        	}
		                        </script></li>
								<li style="*z-index: 1"><label>&nbsp;</label> <input
									type="checkbox" class="checkedbox" checked />&nbsp;&nbsp;我已经阅读并同意
									<a href="<cms:getProjectBasePath/>sites/server.jsp"
									class="fwLink" target="_blank">《用户服务条款》</a></li>

							</ul>
							<button class="login-btn" id="reg-btn" type="button">立即注册</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>











<script type="text/javascript">
$(".showWin-new .regTabbox input").each(function(){
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
	$(function(){
	    var $acount=$('#account_input'),
	        $pwd=$('#pwd_input');       
	    $('#login_btn').bind('click',function(e){
	        var user = $acount.val();
	        var psd=$pwd.val();
	        if(user==""||user==null){
	            $acount.addClass("error").focus();
	            return false;
	        }else{
	            $acount.removeClass("error");
	        }
	        if(psd==""||psd==null){
	            $pwd.addClass("error").focus();
	            return false;
	        }
	     
            $('#ajax_login_form').ajaxSubmit(function(data){
                if(data.status==1){
                    $("#lgWin .Win-close").click();
                    if(data.message == "您提交的校外访问申请已经审核通过！") {
                    	var index=layer.open({
                    		content:data.message,
                    		time:2000,
                    		yes: function(index, layero){

                    			location.reload();
                   		  }
                    	});
                    	 setTimeout(function(){

                    		 location.reload();
 	                    },2000)
                    } else {
	                    setTimeout(function(){

	                    	location.reload();
	                    },200)
                    }
                }else{
                    $('.login-error-box').show();
                    $('.login-error-box').text(data.message);
                }
            });
            e.preventDefault();
	        
	    })
	    $acount.bind('input',function(){
	        if($(this).val().length){
	        	$pwd.removeClass("error");
	            $(this).removeClass("error");
	        }
	    }).bind('foucs',function(){
	    	$pwd.removeClass("error");
	    })
	    $pwd.bind('input',function(){
	        if($(this).val().length){
	        	$acount.removeClass("error");
	            $(this).removeClass("error");
	        }
	    }).bind('focus',function(){
	    	$acount.removeClass("error");
	    })

		 $acount.bind('focus',function(){
			 $pwd.val("");
	    })


	});
</script>
<script type="text/javascript">

            $(function(){
            	 $(".checkedbox").on("click",function(){
                     if($(this).attr('checked')=="checked"){
                           $(".reg-btn").attr('class', 'reg-btn');
                     }else{
                         $(".reg-btn").attr('class', 'reg-btn gray-btn');
                     }
                 });
                 $('#reg-btn').on('click',function(e){
                 	if( $(".checkedbox").is(':checked')){
                 		$(".register-form").submit();
            			e.preventDefault();
                 	}else{
                 		return false;
                 	}
                 });
                 
               
                 jQuery.validator.addMethod("byteRangeLength", function (value, element, param) {
                	    var length = value.length;
                	    for (var i = 0; i < value.length; i++) {
                	        if (value.charCodeAt(i) > 127) {
                	            length++;
                	        }
                	    }
                	    return this.optional(element) || (length >= param[0] && length <= param[1]);
                	}, $.validator.format("请确保输入的值在{0}-{1}个字节之间(一个中文字算2个字节)"));
                 
            	$('.register-form').validate({
        			submitHandler:function(form){
        				 $(form).ajaxSubmit(function(data){
                            if(data.message == "验证码错误!") {
                                alert(data.message);
                            } else {

                                //注册等待状态
                                $("#reg-btn").text("正在注册中...").addClass("reg-btn-lodding");
                                $("#reg-btn").attr("disabled");

                                
                                alert(data.message);
                                $('.Win-close').click();
                                location.reload();
                            }
                            //注册失败
                            if(data.status==-1){
                        		$("#reg-btn").text("立即注册").removeAttr("disabled");
                    		}

                    		//注册成功
                     		if(data.status==1){
	                     		layer.msg("<br>欢迎您注册为Spischolar学术资源在线用户！<br>正在为您跳转到个人中心完善您的基本信息！<br>...<br><br>" , {time:0, area: ['500px']});
                        		window.location.href="<cms:getProjectBasePath/>user/profile";
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
							setTimeout(function(){
								next.removeClass('item-error');
							},2000)
        				}else{
        					//alert(error.text());
        				}
        				//element.focus();
        			},
        			success:function(element,label){
        				var next=$(label).next();
        				if(next.hasClass('item-tip')){
        					next.text('');
        					next.removeClass('item-error');
        					if(!next.hasClass('item-error')){
        						next.addClass('item-pass');
        					}
        				}
        			},
        			rules:{
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
        				},
        				username:{
        					required:true,
        					//rangelength:[6,15],
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
        				code:{
        					required:true
        				}
        			},
        			messages:{
        				email:{
        					required:'请输入您的邮箱!',
        					email:'邮箱格式不能使用!',
        					remote:'该邮箱已注册，如<a href="<cms:getProjectBasePath/>user/findPwd">忘记密码</a>点此找回'
        				},
        				username:{
        					required:'用户名长度为6-15个字符，仅支持中文、英文、数字、下划线、不允许重名。一经设置，无法更改!',
        					byteRangeLength:'用户名长度为6-15个字符',
        					//rangelength:'登录账号长度为6-15个字符',
        					remote:'该用户名已注册，如<a href="<cms:getProjectBasePath/>user/findPwd">忘记密码</a>点此找回'
        				},
        				pwd:{
        					required:'密码由任意6-15个字符组成，注意区分大小写!',
        					rangelength:'密码由任意6-15个字符组成'
        				},
        				repwd:{
        					required:'密码由任意6-15个字符组成，注意区分大小写!',
        					equalTo:"两次密码输入不一致"
        				},
        				code:{
        					required:'请输入验证码!'
        				}
        			}
        		});
            });
            </script>
