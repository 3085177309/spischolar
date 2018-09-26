<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>检索历史</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>resources/mobile/js/mui.min.js"></script>
</head>
<body>
	<div class="section-page">
		<div class="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<a class="return-back"
							href="<cms:getProjectBasePath/>user/personal"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<div class="head-search">
							<a href="" id="clear">清空</a>
						</div>
						<!-- <div class="userbox">
						<div class="userSelect">
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
						<p class="section-tit">检索历史</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section" id="slider">
					<div class="tabbox mui-slider">
						<%-- <div class="user-history-tab"><!--  mui-slider-indicator mui-segmented-control mui-segmented-control-inverted -->
						<a href="<cms:getProjectBasePath/>user/history?type=2"  <c:if test="${type ==2 }">class="mui-active"</c:if>>文章检索历史</a>
                    	<a href="<cms:getProjectBasePath/>user/history?type=1"  <c:if test="${type ==1 }">class="mui-active"</c:if>>期刊检索历史</a>
					</div> --%>
						<div class="user-history-box mui-slider-group">
							<div class="mui-slider-item ovh mui-control-content"
								id="history-tab1">
								<div class="uese-history-boxC">
									<p class="del-date">
										今天 - <span class="current-time"></span>
									</p>
									<c:if test="${empty data.rows }">
										<div class="nohistory nomessage">
											<p>无检索历史</p>
										</div>
									</c:if>
									<ul class="mui-table-view">

										<c:forEach var="history" items="${data.rows }">
											<li class="list-li mui-table-view-cell"
												value="${historys.id}">
												<div class="mui-slider-right mui-disabled">
													<a class="mui-btn mui-btn-red" value="${history.id}">删除</a>
												</div>
												<div class="mui-slider-handle">
													<c:set var="fido" value="${history.batchId}"></c:set>
													<input type="hidden" name="title" value="${history.id}" />
													<span>搜索：</span>
													<c:choose>
														<c:when test="${history.systemId==2 }">
															<a
																href="<cms:getProjectBasePath/>scholar/list?${history.url}"
																title="${history.keyword }">
														</c:when>
														<c:otherwise>
															<a
																href="<cms:getProjectBasePath/>journal/search/list?${history.url}"
																title="${history.keyword }">
														</c:otherwise>
													</c:choose>
													<c:choose>
														<c:when test="${fn:length(history.keyword) < 30 }">
		                                					${history.keyword }
		                                				</c:when>
														<c:otherwise>
		                                					${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,28) }...
		                                				</c:otherwise>
													</c:choose>
													</a> <span class="time"><fmt:formatDate
															value="${historys.time}" pattern="yyyy-MM-dd HH:mm" /></span>
												</div> <!-- <div class="delbtn">删除</div>  -->
											</li>
											<c:forEach var="historys" items="${dataTwo.rows }">
												<c:if test="${historys.batchId==fido }">
													<li class="list-li subli mui-table-view-cell"
														value="${historys.id}">
														<div class="mui-slider-right mui-disabled">
															<a class="mui-btn mui-btn-red" value="${historys.id}">删除</a>
														</div>
														<div class="mui-slider-handle">
															<input type="hidden" class="" name="title"
																value="${historys.id}" />
															<c:choose>
																<c:when test="${history.systemId==2 }">
																	<a href="${historys.url}"
																		title='${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }'>
																</c:when>
																<c:otherwise>
																	<a
																		href="<cms:getProjectBasePath/>journal/detail/${historys.url}"
																		title="${history.keyword }">
																</c:otherwise>
															</c:choose>

															<c:choose>
																<c:when test="${fn:length(historys.keyword) < 40 }">
					                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }
					                                				</c:when>
																<c:otherwise>
					                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,38) }...
					                                				</c:otherwise>
															</c:choose>
															</a> <span class="time"><fmt:formatDate
																	value="${historys.time}" pattern="yyyy-MM-dd HH:mm" /></span>
														</div>
													</li>
												</c:if>
											</c:forEach>
										</c:forEach>
									</ul>
								</div>
								<c:if test="${data.total gt 10 }">
									<div class="paginatin" id="nextPage"
										style="margin-right: -0.36rem; margin-left: -0.36rem;">
										<span>下一页</span>
									</div>
								</c:if>
								<div class="clear10"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
$('.mui-slider-handle a').click(function(){
	window.location=$(this).attr('href')
	//$(window).href($(this).attr('href'))
})
//加载下一页
var size = 10;
$("#nextPage").click(function(){
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
			$(".mui-table-view").append(loading);
		},
		success:function(data){
			$(".loading").remove();
			//console.log(data.length)
			$(".uese-history-boxC").append('<li class="pagenav" style="margin-top: 0.36rem;margin-left: -0.36rem;width: 100%">'+(size+1)+'-'+(size+10)+'条</li>');
			$(".uese-history-boxC").append(data);
			size += 10;
			var allSize = '${data.total}';
			if(allSize < (size+10)) {
				$('#nextPage').hide();
			}
			scroll.refresh();
		}
	})
});


var date=new Date();
var year=date.getFullYear(),month=date.getMonth()+1,day=date.getDate(),week=date.getDay(),dateStr='';
var weeks=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];
dateStr=year+'年'+month+'月'+day+'号 '+weeks[week];
$('span.current-time').text(dateStr);
//清空
$('#clear').click(function(){
	$.ajax({
        url: '<cms:getProjectBasePath/>user/deleteHistory',
        type: 'POST',
        data: { deleteType: "0", title: history },
        success: function () {
        	$('.mui-table-view').html('');
        	window.location.reload();
        }
    });
});
	mui.init();
	(function($){
		$(".mui-table-view").on('tap','.mui-btn',function(event){
			var elem = this;
			var li = elem.parentNode.parentNode;
			var history = elem.getAttribute("value");
			console.log(li);
		    var layindex=layer.open({
			    content: '<p style="line-height:1.253333rem">确认删除该条记录？</p>',
			     btn: ['确认', '取消'],
			    shadeClose: false,
			    yes: function(){
					li.parentNode.removeChild(li);
			        layer.close(layindex);
			        
			        $.ajax({
			            url: '<cms:getProjectBasePath/>user/deleteHistory',
			            type: 'POST',
			            data: { deleteType: "1", title: history },
			            success: function () {
			            	window.location.reload();
			            }
			        });
			    }, no: function(){
			    	setTimeout(function() {
						$.swipeoutClose(li);
					}, 0);
			        layer.close(layindex)
			    }
			});
		})
	})(mui)
	document.getElementById('slider').addEventListener('slide', function(event) {
		$("#sliderSegmentedControl li").removeClass("current");
		$("#sliderSegmentedControl li").eq(event.detail.slideNumber).addClass("current");
	});
</script>
</body>
</html>
