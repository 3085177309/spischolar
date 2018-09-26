<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>验证码</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="<cms:getProjectBasePath/>resources/mobile/css/m.css" />
<script
	src="<cms:getProjectBasePath/>resources/mobile/js/lib/zepto.min.js"></script>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<a class="return-back" onclick="history.go(-1)"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<p class="section-tit">验证</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<section id="slider">
						<div class="delivery-tabbox">
							<ul class="delivery-box">
								<li class="mui-slider-item">
									<div class="deliver-boxC">
										<div class="noneContext">
											<p class="warmImg tan"></p>
											<p class="f16 c33">
												请输入验证码<br> 输入下图中的字符，不区分大小写！
											</p>
											<div class="deliverySearch">
												<form method="post" id="fb_form" action="">
													<input type="text" class="input-text verify"
														placeholder="请输入验证码" autocomplete="off" name="verify"
														id="jounal_kw"> <a title="点击切换图片"><img
														src="<cms:getProjectBasePath/>backend/img" id="valImg"
														class="vcode" /></a>
													<div class="register-submit m0 validatebtn">
														<input type="submit" name="" value="确认" class="">
													</div>

												</form>
												<script type="text/javascript">
            $(function(){
                $('#valImg').bind('click',function(){
                    var src=$(this).attr('src');
                    src+="?time="+new Date();
                    $(this).attr('src',src);
                });
            });
            
            $(function(){
                $('#fb_form').submit(function(e){
                	e.preventDefault();
                    if($('.verify').val() == "" || $('.verify').val() == null) {
                        alert("请输入正确的验证码！");
                        return false;
                    }
                    var verify = $('.verify').val();
                    $.ajax({
            			type:'post',
            			url:'<cms:getProjectBasePath/>user/img',
            			data:$('#fb_form').serialize(),
            			success:function(data){
            				data = eval('(' + data + ')');
            				if(data.message == "验证码错误!") {
                                alert(data.message);
                                location.reload();
                            } else {
                            	alert(data.message);
                                $('.Win-close').click();
                                location.reload();
                            }
            			}
            		})
                   
                    
                });
            });
            </script>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
</body>
</html>
