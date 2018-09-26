<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我的收藏</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="">
				<header>
					<div class="headwrap">
						<a class="return-back"
							href="<cms:getProjectBasePath/>user/personal"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<p class="section-tit">我的收藏</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section ovh">
					<div class="user-history-tab">
						<a href="<cms:getProjectBasePath/>user/favorite?type=1"
							class="mui-control-item <c:if test="${type ==1 }">mui-active</c:if>">文章收藏</a>
						<a href="<cms:getProjectBasePath/>user/favorite?type=2"
							class="mui-control-item <c:if test="${type ==2 }">mui-active</c:if>">期刊收藏</a>
					</div>
					<c:if test="${type == 2 }">
						<c:choose>
							<c:when test="${empty data.rows }">
								<div class="nocolect nomessage">
									<div class="text-center"
										style="text-align: center; padding-top: 10em">您还未收藏期刊</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="artlist-bd-list" id="mycolect">
									<ul class="colect qkcolect">
										<c:forEach var="c" items="${data.rows }">
											<c:set var="doc" value="${c.docJournal }"></c:set>
											<li>
												<h2 class="tit">
													<a
														href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
														class="link">${doc.docTitle }</a>
												</h2> <c:choose>
													<c:when test="${not empty doc.jImage }">
														<a
															href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
															class="img"> <img
															src="<cms:getProjectBasePath/>journal/image/${doc._id}" />
														</a>
													</c:when>
													<c:otherwise>
														<a
															href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
															class="img"> <img
															src="<cms:getProjectBasePath/>resources/images/qk_default1.png" />
														</a>
													</c:otherwise>
												</c:choose>

												<h3 class="issn-block issn">
													<span>ISSN：</span>${doc['issn'].substring(0,9)}
												</h3>
												<p class="issn-block ">
													<c:forEach var="item" items="${c.shoulu }" varStatus="idx">
														<c:if
															test="${item.key != '中科院JCR分区(大类)' && item.key != '中科院JCR分区(小类)' && item.key != 'Eigenfactor'}">
															<span class=""> ${item.key } </span>
														</c:if>
													</c:forEach>

												</p>
												<p class="post-time issn-block">
													收藏时间：
													<fmt:formatDate value="${c.time }" type="date"
														pattern="yyyy-MM-dd" />
													</span>
												</p>
												<p class="is-favrite">
													<a id="${c.docId}f"
														href="javascript:unfavorite('${c.docId}');"
														class="favorite favorited">取消收藏</a> <a id="${c.docId}t"
														href="javascript:favorite('${c.docId}');"
														class="favorite " style="display: none;">收藏</a>
												</p>
											</li>
										</c:forEach>
									</ul>
								</div>
							</c:otherwise>
						</c:choose>
						<script>
				function unfavorite(id){
            		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
            			var data=eval("("+data+")");
            			if(data.status==1){
            			}
            		});
            		$("#"+id+"f").hide();
    				$("#"+id+"t").show();
            	}
            	function favorite(id){
               	 $.get('<cms:getProjectBasePath/>user/favorite/'+id,function(data){
               		var data=eval("("+data+")");
               		if(data.status==1){
           			}
               	 });
               	$("#"+id+"t").hide();
				$("#"+id+"f").show();
                }
				</script>
					</c:if>
					<c:if test="${type == 1 }">
						<c:choose>
							<c:when test="${empty data.rows }">
								<div class="nocolect nomessage">
									<div class="text-center"
										style="text-align: center; padding-top: 10em">您还未收藏文献</div>
								</div>
							</c:when>
							<c:otherwise>
								<div id="mycolect" class="artlist-bd-list">
									<ul class="colect ">
										<c:forEach var="c" items="${data.rows }" varStatus="index">
											<c:set var="doc" value="${c.doc }"></c:set>
											<li>
												<p class="post-time">
													收藏时间：
													<fmt:formatDate value="${c.time }" type="date"
														pattern="yyyy-MM-dd" />
												</p>
												<h2 class="tit">
													<div>
														<c:if test="${doc.href.contains('/academic/profile') }">
															<a href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id }" target="_blank" class="link fl">${index.index+1 }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
														</c:if>
														<c:if test="${!doc.href.contains('/academic/profile') }">
															<a href="${doc.href }" target="_blank" class="link fl">${index.index+1 }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
														</c:if>
														<%-- <a href="${doc.href }" target="_blank" class="link fl">${index.index+1 }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a> --%>
													</div>
												</h2>
												<h5 class="author">${doc.source.replaceAll("<b>", "").replaceAll("</b>", "") }</h5>
												<div class="abstract" onclick="javascript:abstract(this)">
													<p>
														<span>查看摘要</span><i class="icon iconfont fr">&#xe60e;</i>
													</p>
													<div class="abstract-text">${doc.abstract_.replaceAll("<br />", "")}</div>
												</div>
												<h6>
													<c:if test="${not empty doc.quoteText}">
														<a>${doc.quoteText }</a>
														<%-- <a href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20'>${doc.quoteText }</a> --%>
													</c:if>
													<c:if test="${!doc.isOpen && !doc.hasLocal}">
														<a class="docdelivery" href="#" docId="${c.docId}"
															d-title="<c:out value=" ${doc.title }" />">文献互助</a>
													</c:if>
													<c:if test="${not empty doc.openUri}">
														<c:if test="${!doc.href.contains('/academic/profile') }">
															<a href="${doc.openUri }" target="_blank">下载</a>
														</c:if>
														<c:if test="${doc.href.contains('/academic/profile') }">
															<a url_data="${doc.openUri }" class="exportdownload down" 
																docId="${doc.id }" docTitle="${doc.title }" docHref="${doc.href }">下载</a> 
														</c:if>
													<%-- 	<a href="${doc.openUri }" target="_blank">下载</a> --%>
													</c:if>
													<a id="${c.docId}f"
														href="javascript:unfavorite('${c.docId}');"
														class="favorite favorited">取消收藏</a> <a id="${c.docId}t"
														href="javascript:favorite('${c.docId}');"
														class="favorite " style="display: none;">收藏</a>

												</h6>
											</li>
										</c:forEach>
									</ul>
									<script type="text/javascript">
							$(".docdelivery").click(function(e){
								//e.stopPropagation();
							    var title=$(this).attr("d-title");
							    var chooesId = $(this).attr("docId");
							    layer.open({
							        btn: ['提交'],
							        content:'<p class="deltitle">'+title+'</p><div class="docdelbox"><label>邮箱:<input type="text" id="email" /></label></div><p id="err" style="margin:6px 0 4px 40px">&nbsp;</p>',
							        yes: function(index){
							        	var email = $("#email").val();
							        	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
							        	 if(!em.test(email)) {
							        		 $('p#err').html("邮箱格式不正确").css("color","red");
							        		 return false;
							        	 }
							        	 $.get('<cms:getProjectBasePath/>user/dilivery/'+chooesId+'/?email='+email,function(data){
							       		 	data = eval("("+data+")");
							          		alert(data.message); 
							          		if(data.message == "请不要重复提交！") {
							          			layer.close(index);
							          		} else {
							          			layer.close(index);
							          			
							          		}
							          	 });
							        	layer.close(index);
							        }
							    })
							  })
							  $(".exportdownload").click(function(e){
								var quote= $(this).attr("url_data");
								var appendFlag=true;
								$.get('<cms:getProjectBasePath/>scholar/quoteList?url='+quote+"&type=download", function(data){
							  		var result = eval("("+data+")");
							  		result = result.message; 
							  		result = eval("("+result+")");
							  		str='<div class="export-item-box">';
							  		var size = result.length;
							  		if(size > 2) {
							  			size = 2;
							  		}
							  		if(size == 0) {
							  			str+='抱歉，全文资源暂不可用!';
							  			/* str+='抱歉，全文资源暂不可用，申请'
							  			str+='<a style="color: blue;" href="javascript:deliver(\'' + docId + '\',\''+docTitle+'\');"'
							  	      		+' d-title="'+docTitle+'" d-url="'+docHref+'">'
							  	      		+'文献互助 </a>' */
							  		}
							  		for(var i=0;i<size;i++) {
							  			str+='<div class="export-item-name">'+result[i].source+'</div>'
											+'<div class="export-item-content-download" >'+'<a style="color: blue;" href="'+result[i].link+'" download>下载</a>'+'</div>'
											+'</div>'
							  		}
							  		str+='</div>';
									if(appendFlag){
										layer.open({
									        content:'<div class="docdelbox">'+str+'</div>',
									       
									    })
									}
									appendFlag=true;
							  	 });
								
							    })
	
				            	function unfavorite(id){
				            		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
				            			if(data.status==1){
				            			}
				            		});
				            		$("#"+id+"f").hide();
		            				$("#"+id+"t").show();
				            	}
				            	function favorite(id){
				               	 $.get('<cms:getProjectBasePath/>user/favorite/'+id,function(data){
				               		if(data.status==1){
				           			}
				               	 });
				               	$("#"+id+"t").hide();
		        				$("#"+id+"f").show();
				                }
				            </script>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>

				</div>
				<c:if test="${data.total gt 10 }">
					<div class="paginatin" id="nextPage">
						<span>下一页</span>
					</div>
				</c:if>
				<div class="clear10"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
	//加载下一页
	var size = 10;
	$("#nextPage").tap(function(){
		var url = window.location.href;
			url = url+"&offset=" + size;
		var that=$(this);
		var loading='<li class="loading"><i></i><i class="laymloadtwo"></i><i></i></li>'
		$.ajax({
			type:'get',
			url:url,
			beforeSend:function(){
				$(".colect").append(loading);
			},
			success:function(data){
				$(".loading").remove();
				$("#mycolect").append('<li class="pagenav">'+(size+1)+'-'+(size+10)+'条</li>');
				$("#mycolect").append(data);
				size += 10;
				var allSize = '${data.total}';
				if(allSize < (size+10)) {
					$('#nextPage').hide();
				}
				myScroll.refresh();
			}
		})
	});
	
	$(".head-search .iconfont").bind("touchend",function(){
		$(".return-back,.head-search,.section-tit,.clear").css("display","none");
		$(".headwrap").append("<p class='header-cancel'>取消</p><div class='input-div'><input/><i></i></div>");
		$(".input-div i").on("touchend",function(){
			$(this).siblings("input").val("");
		})
	});
	$("body").on("touchend",".header-cancel",function(){
		$(".header-cancel,.input-div").remove();
		$(".return-back,.head-search,.section-tit,.clear").css("display","block");
	})
</script>
</body>
</html>
