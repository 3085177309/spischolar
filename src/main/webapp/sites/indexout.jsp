<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>SpiScholar学术资源在线</title>
</head>
<body class="hd hdmodal-open ">
	<c:set scope="request" var="mindex" value="0"></c:set>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
					<div class="index-logo">
						<a href="#" class="large-logo">学术资源在线</a>
						<p class="fw f20 l-d">稳定、快速、丰富的学术资源检索服务</p>
						<p class="fw f12 l-d2">共收录了156,564本期刊。254,564本文章</p>
					</div>
					<div class="w-wrap">
						<div class="search-box" id="search-box">
							<div class="search-tab">
								<form method="get"
									action="<cms:getProjectBasePath/>journal/search/list">
									<div class="qk-search">
										<input type="text" class="textInput" name="value"
											placeholder="请输入刊名/ISSN/学科名" value="" autocomplete="off"
											type_index="0"> <input type="submit"
											class="journal_hide_btn"> <input type="hidden"
											name="batchId"> <i class="c-i"></i>
									</div>
								</form>
							</div>
							<div class="search-tab" style="display: none">
								<form method="get"
									action="<cms:getProjectBasePath/>scholar/list">
									<div class="article-search">
										<input type="text" class="textInput" value="" name="val"
											autocomplete="off" type_index="0"> <input
											type="submit" class="article_hide_btn"> <i
											class="c-i"></i>
									</div>
								</form>
							</div>
							<div class="search-btn">
								<button class="s-qk s-btn active journal_search_btn">搜期刊</button>
								<button class="s-ar s-btn article_search_btn">搜文章</button>
							</div>
							<div class="search-history"></div>
						</div>
					</div>
				</div>

				<div class="w-wrap">
					<div class="i-wrap clearfix">
						<div class="menus-index fw" id="menus-wraper">
							<%-- <cms:delivery top="1">
                        <c:if test="${not empty delivery.url }">
                            <a href="#" class="in" onclick="return false"><i class="i i-doc"></i>文献互助</a>
                        </c:if>
                        </cms:delivery>
                        <cms:history systemId="0" size="1" mobile="">
                            <a href="#" class="" onclick="return false"><i class="i i-history"></i>检索历史</a>
                        </cms:history>   
                        <cms:favorite top="1" type="0">
                        <c:if test="${not empty favorite }">
                            <a href="#" class="" onclick="return false"><i class="i i-collect"></i>我的收藏</a>
                        </c:if>
                        </cms:favorite> --%>
							<a href="#" class="in" onclick="return false"><i
								class="i i-doc"></i>文献互助</a> <a href="#" class=""
								onclick="return false"><i class="i i-history"></i>检索历史</a> <a
								href="#" class="" onclick="return false"><i
								class="i i-collect"></i>我的收藏</a>
						</div>
						<div class="i-content">
							<cms:delivery top="1">
								<c:choose>
									<c:when test="${not empty delivery }">
										<div class="i-content-tab">
											<div class="i-con-box">
												<ul class="doc-delivery">
													<cms:delivery top="4">
														<li>
															<p class="tit" style="width: 598px">
																<a target="_blank" href="${delivery.url }">${delivery.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
															</p>
															<p class="con">
																<span>时间：<fmt:formatDate
																		value="${delivery.addDate}" pattern="yyyy-MM-dd HH:mm" /></span>
																<span class="cdinc">进度: <c:choose>
																		<c:when
																			test="${delivery.processType ==0 || delivery.processType ==2 || delivery.processType ==4}">
																			<em class="i3">待传递</em>
																			<s>待传递</s>
																		</c:when>
																		<c:when
																			test="${delivery.processType ==1 || delivery.processType == 6}">
																			<em class="i1">传递成功</em>
																			<s>传递成功</s>
																		</c:when>
																		<%--  <c:when test="${delivery.processType ==3 || delivery.processType ==5}"><em class="i4">没有结果</em><s>没有结果</s></c:when> --%>
																		<c:otherwise>
																			<em class="i4">没有结果</em>
																			<s>没有结果</s>
																		</c:otherwise>
																	</c:choose>
																</span>
															</p>
														</li>
													</cms:delivery>
												</ul>
											</div>
											<div class="info-more">
												<a href="<cms:getProjectBasePath/>user/dilivery">查看更多<i
													class="i i-more"> </i></a>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="i-content-tab">
											<div class="i-con-box">
												<div class="nodelivery nomessage">
													<p>暂无您的文献互助记录</p>
												</div>
											</div>
											<div class="info-more">
												<a href="<cms:getProjectBasePath/>user/dilivery">查看更多<i
													class="i i-more"> </i></a>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</cms:delivery>

							<div class="i-content-tab">
								<div class="i-con-twrap">
									<cms:history systemId="0" size="1" mobile="">
										<div class="i-con-box">
											<c:choose>
												<c:when test="${not empty history}">
													<h3 class="history-day">
														今天 - <span class="time current-time"></span>
													</h3>
													<ul class="index-history-wrap">
														<cms:history systemId="0" size="7" mobile="">
															<li>
																<p>
																	<span class="fl"> <c:if
																			test="${history.systemType==1 }">
																			<c:if test="${history.systemId ==1 }">
																			搜索期刊:
	                                                                	</c:if>
																			<c:if test="${history.systemId ==2 }">
																			搜索文章:
	                                                                	</c:if>
																		</c:if> <c:choose>
																			<c:when test="${history.systemType==1 }">
																				<c:if test="${history.systemId ==1 }">
																					<a
																						href="<cms:getProjectBasePath/>journal/search/list?${history.url}"
																						title="${history.keyword }">
																				</c:if>
																				<c:if test="${history.systemId ==2 }">
																					<a
																						href="<cms:getProjectBasePath/>scholar/list?${history.url}"
																						title="${history.keyword }">
																				</c:if>
																				<%-- <c:choose>
																					<c:when test="${fn:length(history.keyword) < 40 }"> --%>
		                                                                            	${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }
		                                                                         <%--    </c:when>
																					<c:otherwise>
		                                                                                ${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,38) }...
		                                                                            </c:otherwise>
																				</c:choose> --%>
																				</a>
																			</c:when>
																			<c:otherwise>
																				<c:if test="${history.systemId ==1 }">
																					<a title="${history.keyword }"
																						href="<cms:getProjectBasePath/>journal/detail/${history.url}"
																						<c:if test="${not empty history.batchId }">style="padding-left:30px;" </c:if>>
																				</c:if>
																				<c:if test="${history.systemId ==2 }">
																					<a title="${history.keyword }"
																						href="${history.url}"
																						<c:if test="${not empty history.batchId }">style="padding-left:30px;" </c:if>>
																				</c:if>
																				<%-- <c:choose>
																					<c:when test="${fn:length(history.keyword) < 40 }"> --%>
		                                                                            	${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }
		                                                                         <%--    </c:when>
																					<c:otherwise>
		                                                                                ${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,38) }...
		                                                                            </c:otherwise>
																				</c:choose> --%>
																				</a>
																			</c:otherwise>
																		</c:choose>
																	</span>
																	 <span class="time fr"><fmt:formatDate
																			value="${history.time}" pattern="yyyy-MM-dd HH:mm" /></span>
																	<!-- <a href="#" class="url">www.360fm.com</a> -->
																</p>
															</li>
														</cms:history>
													</ul>
												</c:when>
												<c:otherwise>
													<div class="nohistory nomessage">
														<p>无检索历史</p>
													</div>
												</c:otherwise>
											</c:choose>
											<div class="info-more">
												<a href="<cms:getProjectBasePath/>user/history">查看更多<i
													class="i i-more"> </i></a>
											</div>
										</div>
									</cms:history>
								</div>
							</div>
							<div class="i-content-tab">
								<div class="i-con-intab">
									<a href="#" class="in">期刊收藏</a> <a href="#">文章收藏</a>
								</div>
								<%--  <cms:favorite top="1" type="0">
	                        <c:choose>
	                        	<c:when test="${not empty favorite }"> --%>
								<div class="i-con-twrap">
									<div class="i-con-box">
										<ul class="collection qkcollection">
											<cms:favorite top="5" type="2">
												<c:choose>
													<c:when test="${not empty favoriteIndex}">
														<c:set var="doc" value="${favoriteIndex.docJournal }"></c:set>
														<li>
															<div class="tit ovh">
																<a
																	href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
																	target="_blank" class="fl f14">${doc.docTitle }</a> <span
																	class="post-time fr">收藏时间：<fmt:formatDate
																		value="${favoriteIndex.time}" pattern="yyyy-MM-dd" />
																</span>
															</div>
															<div class="con">【ISSN】
																${doc['issn'].substring(0,9)}</div>
														</li>
													</c:when>
													<c:otherwise>
														<li class="nocolect nomessage">无期刊收藏</li>
													</c:otherwise>
												</c:choose>
											</cms:favorite>
										</ul>
										<div class="info-more">
											<a href="<cms:getProjectBasePath/>user/favorite?type=2">查看更多<i
												class="i i-more"> </i></a>
										</div>
									</div>
									<div class="i-con-box" style="display: none">
										<ul class="collection">
											<cms:favorite top="2" type="1">
												<c:choose>
													<c:when test="${not empty favoriteIndex}">
														<c:set var="doc" value="${favoriteIndex.doc }"></c:set>
														<li>
															<div class="tit ovh">
																<a href="${doc.href }" target="_blank" class="fl f14 fb">
																	<c:choose>
																		<c:when test="${fn:length(doc.title) < 80 }">
                                                                            	${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }
                                                                            </c:when>
																		<c:otherwise>
                                                                                ${doc.title.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,72) }...
                                                                            </c:otherwise>
																	</c:choose> <%--  ${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") } --%>
																</a> <span class="post-time fr">收藏时间：<fmt:formatDate
																		value="${favoriteIndex.time}" pattern="yyyy-MM-dd" />
																</span>
															</div>
															<div class="author">${doc.source.replaceAll("<b>", "").replaceAll("</b>", "") }</div>
															<div class="con">${doc.abstract_.replaceAll("<b>", "").replaceAll("</b>", "") }</div>
														</li>
													</c:when>
													<c:otherwise>
														<li class="nocolect nomessage">无文章收藏</li>
													</c:otherwise>
												</c:choose>
											</cms:favorite>
										</ul>
										<div class="info-more">
											<a href="<cms:getProjectBasePath/>user/favorite?type=1">查看更多<i
												class="i i-more"> </i></a>
										</div>
									</div>
								</div>
								<%-- 	</c:when>
	                        	<c:otherwise>
	                        	<div class="i-con-twrap">
	                        		<div class="">您还未收藏文献</div>
	                        	</div>
	                        	</c:otherwise>
	                        </c:choose>
	                        
	                        </cms:favorite> --%>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<div class="index-footer">
		<p>
			邮箱：<a href="mailto:spischolar@hnwdkj.com">spischolar@hnwdkj.com</a> </br>©2015
			湖南纬度信息科技有限公司 湘ICP备13003055号-3
		</p>
	</div>





	<jsp:include page="include/float.jsp"></jsp:include>
	<script type="text/javascript">

	 $(function(){
		 var hist = $('#menus-wraper a.v');
		 if(hist.length == 2) {
			 hist.get(1).remove();
		 }
		 
		 
		 var date=new Date();
		 var year=date.getFullYear(),month=date.getMonth()+1,day=date.getDate(),week=date.getDay(),dateStr='';
		 var weeks=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];
		 dateStr=year+'年'+month+'月'+day+'号 '+weeks[week];
		 $('span.current-time').text(dateStr);
	 });
</script>
	<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
</body>
</html>