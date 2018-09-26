<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp" />
<style>
#fwWin {
	display: none;
}

#fwWin .Win-cont {
	width: 720px;
	height: 410px;
	left: 50%;
	top: 50%;
	margin-left: -360px;
	margin-top: -205px;
}

#fwWin .Win-pannel {
	height: 390px;
}
</style>
<title>注册</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>欢迎加入</span>
					</div>

					<div class="fr lgbtn"></div>
				</div>
				<div class="reg-bd">
					<form method="post" action="<cms:getProjectBasePath/>user/register"
						class="register-form">
						<ul>
							<li><label><em>*</em>登录邮箱</label> <input type="text"
								id="email" name="email" placeholder="请输入邮箱" class="reg-put"
								value="${member.email }" /> <span class="item-tip">请输入您的登录邮箱


							</span></li>
							<li><label><em>*</em>用户名</label> <input type="text"
								placeholder="请输入用户名" class="reg-put" id="username"
								name="username" value="${member.username }" /> <span
								class="item-tip" id="usernames">登录账号长度为6-15个字符，仅支持中文、英文、数字、下划线、不允许重名。一经设置，无法更改!
							</span></li>
							<li><label><em>*</em>登录密码</label> <input type="password"
								class="reg-put" id="pwd" name="pwd" value="${member.pwd }" /> <span
								class="item-tip"> 密码由任意6-15个字符组成，注意区分大小写</span></li>
							<li><label><em>*</em>确认密码</label> <input type="password"
								class="reg-put" id="repwd" name="repwd" value="${repwd }" /> <span
								class="item-tip">密码由任意6-15个字符组成，注意区分大小写</span></li>
							<li><label><em>*</em>验证码</label> <input type="text"
								class="reg-put w" name="code" /> <img
								src="<cms:getProjectBasePath/>backend/img" width="80"
								height="24" id="valiycode"> <span class="item-tip"><a
									href="javascript:changeValiyCode()">看不清楚，换一个</a></span> <script
									type="text/javascript">
                        	function changeValiyCode(){
                        		$('#valiycode').attr('src','<cms:getProjectBasePath/>backend/img?__time='+(new Date()).getTime());
                        	}
                        </script></li>
							<li><label>&nbsp;</label> <input type="checkbox"
								class="checkedbox" /> <a href="javascript:void(0);"
								class="blue fwLink">我已经阅读并同意《用户服务条款》</a></li>

						</ul>
						<a href="" class="reg-btn gray-btn">立即注册</a>

					</form>
					<script type="text/javascript">
            $(function(){
            	
            	 $(".checkedbox").bind("click",function(){
                     if($(this).attr('checked')=="checked"){
                           $(".reg-btn").attr('class', 'reg-btn');
                     }else{
                         $(".reg-btn").attr('class', 'reg-btn gray-btn');
                     }
                 });
                 $('.reg-btn').bind('click',function(e){
                 	if( $(".checkedbox").is(':checked')){
                 		$(".register-form").submit();
            			e.preventDefault();
                 	}else{
                 		return false;
                 	}
                 });
               	//表单提交
               /*  $('.register-form').submit(function(e){
                 	$(this).ajaxSubmit(function(data){
                 		
                 	});
                 	e.preventDefault();
                 });*/
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
                     		alert(data.message);
                     		if(data.status==1){
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
        					remote:'该邮箱已注册，如<a href="<cms:getProjectBasePath/>user/findPwd" class="red">忘记密码</a>点此找回'
        				},
        				username:{
        					required:'登录账号长度为6-15个字符，仅支持中文、英文、数字、下划线、不允许重名。一经设置，无法更改!',
        					byteRangeLength:'登录账号长度为6-15个字符',
        					//rangelength:'登录账号长度为6-15个字符',
        					remote:'该用户名已注册，如<a href="<cms:getProjectBasePath/>user/findPwd" class="red">忘记密码</a>点此找回'
        				},
        				pwd:{
        					required:'密码由任意6-15个字符组成，注意区分大小写!',
        					rangelength:'密码由任意6-15个字符组成'
        				},
        				repwd:{
        					 equalTo:"两次密码输入不一致"
        				},
        				code:{
        					required:'请输入验证码!'
        				}
        			}
        		});
            });
            </script>
				</div>
			</div>
		</div>
	</div>

	<div class="showWin fwWin" id="fwWin">
		<div class="Win-bj"></div>
		<div class="Win-cont">
			<div class="Win-pannel">
				<h3 id="Win-T">
					<span class="Win-close"></span>
				</h3>
				<div class="loginbox" style="overflow: scroll;">
					<h3>服务条款</h3>
					<div class="Section0" style="layout-grid: 15.6000pt;">
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">欢迎您注册成为<font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航用户！</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">请仔细阅读下面的协议，只有接受协议才能继续进行注册。&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;1<font
								face="宋体">．服务条款的确认和接纳</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								<font face="Calibri">Spischolar</font><font face="宋体">学术资源导航系统用户服务的所有权和运作权归湖南纬度信息科技有限公司所有。</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航所提供的服务将按照有关章程、服务条款和操作规则严格执行。用户通过注册程序勾选&#8220;我已经阅读并同意《用户服务条款》&#8221;，即表示用户与</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航达成协议并接受所有的服务条款。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;2<font
								face="宋体">．&nbsp;服务内容</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">要成为系统服务用户必须：</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">1</font><font face="宋体">）自行配备上网的所需设备，&nbsp;包括个人电脑、调制解调器或其他必备上网装置。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">2</font><font face="宋体">）自行负担个人上网所支付的与此服务有关的电话费用、&nbsp;网络费用。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">为提高系统服务信息服务的准确性，用户应同意：</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">1</font><font face="宋体">）提供详尽、准确的公司或个人资料。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">2</font><font face="宋体">）不断更新注册资料，符合及时、详尽、准确的要求。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">本服务不公开用户的电子邮箱和笔名，&nbsp;除以下情况外：</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">1</font><font face="宋体">）用户授权透露这些信息。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">2</font><font face="宋体">）相应的法律及程序要求提供用户的个人资料。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">如果用户提供的资料包含有不正确的信息，本服务系统保留结束用户使用网络服务资格的权利。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;3<font
								face="宋体">．&nbsp;服务条款的修改和服务修订</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">Spischolar<font
								face="宋体">学术资源导航</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">有权在必要时修改服务条款，服务条款一旦发生变动，将会在</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">相关</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的网络服务。&nbsp;如果用户继续享用网络服务，则视为接受服务条款的变动。本服务系统保留随时修改或中断服务而不需知照用户的权利。本服务系统行使修改或中断服务的权利，不需对用户或第三方负责。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;4<font
								face="宋体">．用户隐私制度</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								尊重用户个人隐私是<font face="Calibri">Spischolar</font><font face="宋体">学术资源导航的&nbsp;基本政策。</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航不会公开、编辑或透露用户的邮件内容，除非有法律许可要求，或</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航在诚信的基础上认为透露这些信件在以下三种情况是必要的：&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">1</font><font face="宋体">）遵守有关法律规定，遵从合法服务程序。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">2</font><font face="宋体">）保持维护</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航的商标所有权。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">3</font><font face="宋体">）在紧急情况下竭力维护用户个人和社会大众的隐私安全。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">（<font
								face="Calibri">4</font><font face="宋体">）符合其他相关的要求。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 20.2500pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;5<font
								face="宋体">．用户的帐号，密码和安全性</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								用户一旦注册成功，成为本服务系统的合法用户，将得到一个用户名和密码。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">用户将对用户名和密码安全负全部责任。另外，每个用户都要对以其帐号进行的所有活动和事件负全责。您可随时根据指示改变您的密码。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本服务系统。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;6<font
								face="宋体">．拒绝提供担保</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">用户对网络服务的使用承担风险。本服务系统对此不作任何类型的担保，不论是明确的或隐含的。本服务系统不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保。本服务系统对用户得到的任何信息、商品购物服务或交易进程，不作担保。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal
							style="text-indent: 21.0000pt; mso-char-indent-count: 2.0000;">
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">7<font
								face="宋体">．有限责任</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								<font face="Calibri">Spischolar</font><font face="宋体">学术资源导航对任何直接、间接、偶然、特殊及继起的损害不负责任，这些损害来自：不正当使用邮件服务，在网上购买商品或服务，在网上进行交易，非法使用邮件服务或用户传送的信息所变动。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;8<font
								face="宋体">．</font></span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">用户责任&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								用户单独承担传输内容的责任。用户必须遵循：&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">1</font><font face="宋体">）从中国境内向外传输技术性资料时必须符合中国有关法规。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">2</font><font face="宋体">）使用邮件服务不作非法用途。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">3</font><font face="宋体">）不干扰或混乱网络服务。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">4</font><font face="宋体">）不在建议反馈及管理后台中发表任何与政治相关的信息。&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">5</font><font face="宋体">）遵守所有使用邮件服务的网络协议、规定、程序和惯例。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">6</font><font face="宋体">）不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								（<font face="Calibri">7</font><font face="宋体">）不得利用本站制作、复制和传播下列信息：&nbsp;</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9312;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">煽动抗拒、破坏宪法和法律、行政法规实施的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9313;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">煽动颠覆国家政权，推翻社会主义制度的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9314;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">煽动分裂国家、破坏国家统一的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9315;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">煽动民族仇恨、民族歧视，破坏民族团结的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9316;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">捏造或者歪曲事实，散布谣言，扰乱社会秩序的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9317;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9318;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9319;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">损害国家机关信誉的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9320;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">其他违反宪法和法律行政法规的；</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
							</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&#9321;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">进行商业广告行为的。</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;9<font
								face="宋体">．发送通告</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								所有发给用户的通告都可通过电子邮件或常规的信件传送。<font face="Calibri">Spischolar</font><font
								face="宋体">学术资源导航会通过邮件服务发报消息给用户，告诉他们服务条款的修改、服务变更、或其它重要事情。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;10<font
								face="宋体">．网站内容的所有权</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 21.0000pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">Spischolar<font
								face="宋体">学术资源导航定义的内容包括：文字、数据、图表、软件；在广告中全部内容；电子邮件的全部内容；所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航和广告商授权下才能使用这些内容，而不能擅自复制、篡改这些内容、或创造与内容有关的派生产品。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 21.0000pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;</span><span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">11<font
								face="宋体">．附加信息服务</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 21.0000pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">用户在享用<font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航提供的免费服务的同时，同意接受</font><font
								face="Calibri">Spischolar</font><font face="宋体">学术资源导航提供的各类附加信息服务。</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal style="text-indent: 21.0000pt;">
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">&nbsp;12<font
								face="宋体">．解释权</font></span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-weight: bold; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: 宋体; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;">
								本注册协议的解释权归<font face="Calibri">Spischolar</font><font face="宋体">学术资源导航所有。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。</font>
							</span><span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p></o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
						<p class=MsoNormal>
							<span
								style="mso-spacerun: 'yes'; font-family: Calibri; mso-fareast-font-family: 宋体; font-size: 10.5000pt; mso-font-kerning: 1.0000pt;"><o:p>&nbsp;</o:p></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
