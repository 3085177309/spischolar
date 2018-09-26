<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我要反馈</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="section-page">
		<header>
			<div class="headwrap">
				<div class="return-back">
					<a class="return-back" onclick="history.go(-1)"> <i
						class="icon iconfont">&#xe610;</i> <span>返回</span>
					</a>
				</div>
				<!-- <div class="head-search">
				<i class="icon iconfont">&#xe604</i>
			</div> -->
				<!-- <div class="userbox">
				<div class="userSelect">
					<i class="icon iconfont iconfuzhi">&#xe600;</i>
				</div>
			</div> -->
				<p class="section-tit">我要反馈</p>
				<div class="clear"></div>
			</div>
		</header>
		<div class="item-section">
			<section id="tab">
				<form method="post" id="fb_form" onSubmit="return false;">
					<div class="delivery-tabbox ui-tab">
						<ul class="delivery-tab-nav delivery-tab ui-tab-nav">
							<li class="current">期刊指南</li>
							<li>学术搜索</li>
							<li>其他</li>
						</ul>
						<input type="hidden" id="value_fknr" name="systemName"
							value="学术期刊指南">
						<ul class="delivery-box ui-tab-content">
							<li>
								<div class="edit-fankui">
									<div class="fankui-box">
										<textarea name="question" id="textbox" cols="30" rows="10"
											placeholder="">您好，请描述您遇到的问题...</textarea>
										<div class="upload-box">
											<input type="file" class="uploadimage"
												accept="image/jpeg,image/png,image/gif,image/bmp" multiple>
										</div>
										<!-- <div class="add-images">
									<i class="icon iconfont">&#xe609;</i>
								</div> -->
										<span class="word-num"><em>0</em>/500</span>
									</div>
									<!-- <div class="cont-T">联系方法<em class="red">(必填*)</em></div> -->
									<div class="cont-B">
										<input type="email" id="phone" name="contact"
											placeholder="请留下您的联系方式,以便我们及时回复您."
											value='<c:if test="${not empty sessionScope.front_member}">${sessionScope.front_member.email }</c:if>'>
									</div>
								</div>
							</li>
						</ul>
					</div>

					<div class="fankui-submit">
						<input type="button" id="sub" value="提交" />
					</div>
				</form>
				<script class="demo-script">
				
		            
	        </script>
				<script type="text/javascript">
		        $('.ui-tab-nav li').bind('tap',function(){
	            	$(this).addClass('current').siblings().removeClass('current');
	            	$('#value_fknr').val($(this).text());
	            	
	            })
				var $counter=$(".word-num em");
				var val=$('#textbox').val();
				var cplock=false;
				$('#textbox').on('input', function() {
				    if(cplock){
				    	return;
				    }
				    $counter.text($(this).val().length);
				    if($(this).val().length!=0){
						$(".fankui-submit input").addClass("cksure");
					}else{
						$(".fankui-submit input").removeClass("cksure");
					}
				}).on('compositionstart',function(){
					cplock=true;
					
				}).on('compositionend',function(){
					cplock=false;
				}).on('focus',function(){
					if($(this).val()=="您好，请描述您遇到的问题..."){
						$(this).val("");
					} 
				}).on('blur',function(){
					if($(this).val()==""){
						$(this).val("您好，请描述您遇到的问题...");
					}
				});
				
				
		        	$('#sub').click(function(e){
		        		var tet = $('#textbox').val();
		        		if($('#textbox').val() == "" || $('#textbox').val() == null||$('#textbox').val()=="您好，请描述您遇到的问题...") {
		        			alert("反馈内容不能为空！");
		        			return false;
		        		}
		        		if(tet.length>500){
		        			alert("您的反馈内容过长，请控制在500个字符之内！");
		        			return false;
		        		}
		        		if($('#phone').val() != "" || $('#phone').val() != null) {
		         			 var email = $('#phone').val();
		         			var em = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
		         			 if(!em.test(email)) {
		         				alert("请填写您正确的邮箱！");
		             			return false;
		         			 }
		         		}
		        		//console.log($('#fb_form').serialize());
		         		 $.ajax({
		                     //提交数据的类型 POST GET
		                     type:"POST",
		                     //提交的网址
		                     url:"<cms:getProjectBasePath/>user/feedback",
		                     //提交的数据
		                     data:$('#fb_form').serialize(),
		                     //返回数据的格式
		                     datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
		                     //成功返回之后调用的函数             
		                     success:function(data){
		                    	 if(data.message == "验证码错误!") {
				        				alert(data.message);
				        			} else {
				        				alert('您的问题已经提交，谢谢您的参与!');
				        				window.location.href="<cms:getProjectBasePath/>user/feedbacks";
				        				
				        				//location.reload();
				        			}
		                     },
		                     //调用出错执行的函数
		                     error: function(){
		                    	 alert("系统出现了错误!");
		                     }         
		                  });
		        	});
			</script>


			</section>
		</div>
	</div>
</body>
</html>
