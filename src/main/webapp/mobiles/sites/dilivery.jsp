<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>文献互助</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<style>
.deliverySearch .input-submit {
	right: 0.36rem;
}
</style>
</head>
<body>
	<div class="page-view">
		<div class="mui-content">
			<div class="scroller-container pb0">
				<header>
					<form method="get" action="<cms:getProjectBasePath/>user/dilivery">
						<input type="hidden" name="email" value="${email }">
						<div class="headwrap">
							<a class="return-back"
								href="<cms:getProjectBasePath/>user/personal"> <i
								class="icon iconfont">&#xe610;</i> <span>返回</span>
							</a>
							<div class="head-search">
								<i class="icon iconfont">&#xe604</i>
							</div>
							<p class="section-tit">文献互助</p>
							<div class="clear"></div>
						</div>
					</form>
				</header>

				<div class="item-section">
					<section id="slider">
						<div class="delivery-tabbox mui-slider">
							<div class="delivery-tab-nav delivery-tab ">
								<!-- mui-slider-indicator mui-segmented-control mui-segmented-control-inverted -->
								<a class="<c:if test="${processType==-1 }"> mui-active</c:if>"
									href="<cms:getProjectBasePath/>user/dilivery?emali=${email}">全部</a>
								<a class="<c:if test="${processType==3 }"> mui-active</c:if>"
									href="<cms:getProjectBasePath/>user/dilivery?processType=3&emali=${email}">待传递</a>
								<a class="<c:if test="${processType==0 }"> mui-active</c:if>"
									href="<cms:getProjectBasePath/>user/dilivery?processType=0&emali=${email}">传递中</a>
								<a class="<c:if test="${processType==2 }"> mui-active</c:if>"
									href="<cms:getProjectBasePath/>user/dilivery?processType=2&emali=${email}">无结果</a>
								<a class="<c:if test="${processType==1 }"> mui-active</c:if>"
									href="<cms:getProjectBasePath/>user/dilivery?processType=1&emali=${email}">完成</a>
							</div>
							<ul class="delivery-box mui-slider-group">
								<li class="mui-slider-item ovh mui-control-content"
									id="item1mobile">
									<div class="mui-scroll-wrapper">
										<div class="mui-scroll">
											<c:choose>

												<c:when test="${empty data.rows }">
													<c:if test="${processType==-1 }">
														<div class="nodelivery nomessage">
															<p class="f16 c33">
																对不起，找不到您的文献互助记录，<br>请输入提交的邮箱查询！
															</p>
															<div class="deliverySearch">
																<form method="get"
																	action="<cms:getProjectBasePath/>user/dilivery">
																	<input type="hidden" name="processType"
																		value="${processType }"> <input type="text"
																		class="input-text" placeholder="请输入Email检索" value=""
																		autocomplete="off" name="email" id="jounal_kw">
																	<input type="submit" class="input-submit"
																		id="quick_search_btn" value="检索">
																</form>
															</div>
														</div>
													</c:if>
													<c:if test="${processType ==3}">
														<div class="nodelivery nomessage">
															<p class="f16 c33">找不到您待传递的文献请求</p>
														</div>
													</c:if>
													<c:if test="${processType ==0}">
														<div class="nodelivery nomessage">
															<p class="f16 c33">找不到您传递中的文献请求</p>
														</div>
													</c:if>
													<c:if test="${processType ==2}">
														<div class="nodelivery nomessage">
															<p class="f16 c33">找不到您无结果的文献请求</p>
														</div>
													</c:if>
													<c:if test="${processType ==1}">
														<div class="nodelivery nomessage">
															<p class="f16 c33">找不到您传递成功的文献请求</p>
														</div>
													</c:if>
												</c:when>

												<c:otherwise>
													<div class="deliver-boxC">
														<c:if test="${not empty data.rows }">
															<ul class="delivery">
																<c:forEach var="d" items="${data.rows }"
																	varStatus="index">
																	<li>
																		<%-- <a href="${d.url }" title="${d.title }" class="del-title">  --%>
																		<c:if test="${d.url.contains('/academic/profile') }">
																			<a href="<cms:getProjectBasePath/>scholar/bingRedirect/${d.id }" title="${d.title }" target="_blank">
																		</c:if>
																		<c:if test="${!d.url.contains('/academic/profile') }">
																			<a href="${d.url }" title="${d.title }" target="_blank">
																		</c:if>
																		<c:choose>
																			<c:when test="${fn:length(d.title) > 100 }">
											                        			${index.index+1 }、${d.title.replaceAll("<b>", "").replaceAll("</b>", "").substring(0, 98) }...
											                        		</c:when>
																			<c:otherwise>
											                        			${index.index+1 }、${d.title.replaceAll("<b>", "").replaceAll("</b>", "") }
											                        		</c:otherwise>
																		</c:choose>
																		</a>
																		<div class="delist-detail">
																			<p>
																				时间：
																				<fmt:formatDate value="${d.addDate}"
																					pattern="yyyy-MM-dd HH:mm" />
																			</p>

																			<c:choose>
																				<c:when test="${d.processType ==0 }">
																					<p>
																						进度：<span class="cking img"></span><span><em
																							class="i3">待传递</em>
																				</c:when>
																				<c:when
																					test="${d.processType ==1 || d.processType ==7 || d.processType ==6 }">
																					<p>
																						进度：<span class="cdok img"></span><span><em
																							class="i1">传递成功</em>
																				</c:when>
																				<c:when
																					test="${d.processType ==2 || d.processType ==4}">
																					<p>
																						进度：<span class="cking img"></span><span><em
																							class="i3">传递中</em>
																				</c:when>
																				<c:otherwise>
																					<p>
																						进度：<span class="ckfd img"></span><span><em
																							class="i4">没有结果</em>
																				</c:otherwise>
																			</c:choose>
																			</span>
																			</p>
																			<%--	<c:choose>
								                        	<c:when test="${d.processType ==1 || d.processType ==7 || d.processType ==6 }">
								                        		<a href="<cms:getProjectBasePath/>user/dilivery/download/${d.id}" class="art-download download">点击下载</a>
								                        	</c:when>
								                        	<c:otherwise>
								                        		<a  class="art-download download-disable download">点击下载</a>
								                        	</c:otherwise>
								                        </c:choose> --%>

																		</div></li>
																</c:forEach>
															</ul>
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>

											<c:if test="${data.total gt 20 }">
												<div class="paginatin" id="nextPage">
													<span>下一页</span>
												</div>
											</c:if>
											<div class="clear10"></div>
										</div>
									</div>
								</li>
							</ul>
							<script class="demo-script">
						/*(function (){
				            var tab = new fz.Scroll('.ui-tab', {
						        role: 'tab',
						        autoplay: false,
						        interval: 3000,
						        currentPage:1
						    });
						})();*/
							
						/* mui.init({
							swipeBack: false
						});
						$(document.body).height($(window).height());
						$('.mui-scroll-wrapper').height($(window).height()-$(".headwrap").height()-$(".delivery-tab").height());

						//(function($) {
						(function($) {
							$('.mui-scroll-wrapper').scroll({
								indicators: false //是否显示滚动条
							});
							document.getElementById('slider').addEventListener('slide', function(event) {
								console.log(event.detail.slideNumber)
										$("#sliderSegmentedControl li").removeClass("current");
										$("#sliderSegmentedControl li").eq(event.detail.slideNumber).addClass("current");
							});
						})(mui) */

						//})
			        </script>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<!-- <div class="fix-nav _nav-show" id="jNav" data-animate="_nav-show">
	<div class="nav-list">
		<a class="active" href="#">
			<i class="icon iconfont iconfuzhi">&#xe603;</i>
			<p>首页</p>
		</a>
		<a href="#"><i class="icon iconfont">&#xe602;</i><p>期刊</p></a>
		<a href="#"><i class="icon iconfont">&#xe601;</i><p>文章</p></a>
		<a href="#"><i class="icon iconfont">&#xe600;</i><p>我的</p></a>
	</div>
</div> -->
	<script>
//加载下一页
var size = 20;
$("#nextPage").tap(function(){
	var url = window.location.href;
	if(url.indexOf('?')!=-1) {
		url = url+"&offset=" + size;
	} else {
		url = url+"?offset=" + size;
	}
	var that=$(this);
	var loading='<li class="loading"><i></i><i class="laymloadtwo"></i><i></i></li>'
	$.ajax({
		type:'get',
		url:url,
		beforeSend:function(){
			$(".delivery").append(loading);
		},
		success:function(data){
			
			$(".loading").remove();
			//console.log(data.length)
			$(".deliver-boxC").append('<li class="pagenav">'+(size+1)+'-'+(size+20)+'条</li>');
			$(".deliver-boxC").append(data);
			size += 20;
			var allSize = '${data.total}';
			if(allSize < (size+20)) {
				$('#nextPage').hide();
			}
			scroll.refresh();
		}
	})
});
	$(".head-search .iconfont").bind("touchend",function(){
		$(".return-back,.head-search,.section-tit,.clear").css("display","none");
		$(".headwrap").append("<p class='header-cancel'>取消</p><div class='input-div'><input type='text' name='title'/><button type='submit' id='quick_search_btn' value='检索'><i class='icon iconfont'>&#xe604</i></button><span class='after'></span></div>");
		$('.input-div .after').bind('touchend',function(){
			  $(this).parents('.input-div').find('input').val('');
			})
		$(".input-div input").on("input",function(){
			$('#quick_search_btn').hide();
		}).on('blur',function(){
			$('#quick_search_btn').show();
		})
	});

	$("body").on("touchend",".header-cancel",function(){
		$(".header-cancel,.input-div").remove();
		$(".return-back,.head-search,.section-tit,.clear").css("display","block");
	})
	
</script>
</body>
</html>