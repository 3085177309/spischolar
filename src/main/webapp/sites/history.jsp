<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="pg"
	uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp" />
<title>检索历史</title>
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
						href="javascript:void(0)" class="in">检索历史</a> <a
						href="<cms:getProjectBasePath/>user/favorite">我的收藏</a>
					<c:if test="${not empty front_member }">
						<a href="<cms:getProjectBasePath/>user/profile">账户管理</a>
					</c:if>
				</div>
				<div class="statistics-user-box"></div>
				<div class="wraper bg">
					<div class="container">
						<div class="user-man-wraper border">
							<c:if test="${not empty data.rows}">
								<div class="user-man-hd">
									<div class="delete">
										<span id="d1" class="deleteHistory" value="1">删除所选</span> <span
											id="d2" class="deleteHistory" value="0">清空全部</span>
									</div>
								</div>

								<div class="">
									<script type="text/javascript">
							         $(function(){
							        	 $('.deleteHistory').click(function(){
							        		 var id = $(this).attr("value");
							        		 document.getElementById("deleteType").value=id;
							        			$('#history_delete').ajaxSubmit(function(data){
							        				if(data.status==1){
							        					window.location.reload();
							        				}
							        			});
							        		});
							        	 var date=new Date();
							    		 var year=date.getFullYear(),month=date.getMonth()+1,day=date.getDate(),week=date.getDay(),dateStr='';
							    		 var weeks=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];
							    		 dateStr=year+'年'+month+'月'+day+'号 '+weeks[week];
							    		 $('span.current-time').text(dateStr);
							         });
				            	</script>
									<div class="history-box" style="display: block">
										<h3>
											今天 - <span class="current-time"></span>
										</h3>
										<ul class="history">
											<form method="POST"
												action="<cms:getProjectBasePath/>user/deleteHistory"
												id="history_delete">
												<input type="hidden" id="deleteType" name="deleteType">
												<c:forEach var="history" items="${data.rows }">
													<li class="tit1 clearfix">
														<div class="tit">
															<c:if test="${history.systemId ==1 }">
		                                                   		搜索期刊:
		                                                   	</c:if>
															<c:if test="${history.systemId ==2 }">
		                                                   		搜索文章:
		                                                   	</c:if>
														</div>
														<div class="input-ww">
															<c:set var="fido" value="${history.batchId}"></c:set>
															<input type="checkbox" name="title" value="${history.id}" />
														</div> <c:choose>
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
														</c:choose> <c:choose>
															<c:when test="${fn:length(history.keyword) < 50 }">
			                                					${history.keyword }
			                                				</c:when>
															<c:otherwise>
			                                					${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,48) }...
			                                				</c:otherwise>
														</c:choose> </a> <span class="time fr"><fmt:formatDate
																value="${history.time}" pattern="yyyy-MM-dd HH:mm" /></span> <c:forEach
															var="historys" items="${dataTwo.rows }">
															<c:if
																test="${historys.batchId==fido && history.systemId == historys.systemId}">
																<li>
																	<p class="clearfix">
																		<!--<span class="fl">-->
																		<span class="input-wi"> <input type="checkbox"
																			name="title" value="${historys.id}" />
																		</span>
																		<c:choose>
																			<c:when test="${history.systemId==2 }">
																				<a href="${historys.url}"
																					title='${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }'>
																			</c:when>
																			<c:otherwise>
																				<a
																					href="<cms:getProjectBasePath/>journal/detail/${historys.url}"
																					title="${historys.keyword }">
																			</c:otherwise>
																		</c:choose>
																		<c:choose>
																			<c:when test="${fn:length(historys.keyword) < 50 }">
						                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }
						                                				</c:when>
																			<c:otherwise>
						                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }...
						                                				</c:otherwise>
																		</c:choose>
																		</a>
																		<!--</span>-->
																		<span class="time fr"> <fmt:formatDate
																				value="${historys.time}" pattern="yyyy-MM-dd HH:mm" />
																		</span>
																	</p>
																</li>
															</c:if>
														</c:forEach>
													</li>
												</c:forEach>
											</form>
										</ul>
									</div>
								</div>
								<div class="paginatin">
									<c:if test="${data.total gt 10 }">
										<ul>
											<pg:pager items="${data.total }" url="history"
												export="cp=pageNumber" maxPageItems="10" maxIndexPages="10"
												idOffsetParam="offset">
												<pg:param name="type" />
												<pg:first>
													<li><a href="${pageUrl }">首页</a></li>
												</pg:first>
												<pg:prev>
													<li><a href="${pageUrl}">上一页</a></li>
												</pg:prev>
												<pg:pages>
													<c:choose>
														<c:when test="${cp eq pageNumber }">
															<li class="current"><a
																href="javascript:return false ;">${pageNumber}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="${pageUrl}">${pageNumber}</a></li>
														</c:otherwise>
													</c:choose>
												</pg:pages>
												<pg:next>
													<li><a id="next_page" href="${pageUrl}">下一页</a></li>
												</pg:next>
												<pg:last>
													<li><a id="last_page" href="${pageUrl}">尾页</a></li>
												</pg:last>
											</pg:pager>
										</ul>
									</c:if>
								</div>
							</c:if>
							<c:if test="${empty data.rows}">
								<!--没有检索历史提示-->
								<div class="unretrieval-box"></div>
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
