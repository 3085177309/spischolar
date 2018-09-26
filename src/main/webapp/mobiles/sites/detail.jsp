<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>${doc.docTitle }</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<link href="<cms:getProjectBasePath/>resources/mobile/js/need/layer.css"
	type="text/css" rel="styleSheet" id="layermcss">
<script src="<cms:getProjectBasePath/>resources/js/wdEcharts.js?v=1.0.1"></script>
<script src="<cms:getProjectBasePath/>resources/js/echartsDataModel.js?v=1.0.1"></script>
<script>
	divIds = [];
</script>
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
					</div>
				</header>
				<div class="common-search">
					<dd class="stab" style="display: block;">
						<form method="get"
							action="<cms:getProjectBasePath/>journal/search/list"
							id="journal_search_form">
							<div class="search-inputwrap">
								<input type="hidden" name="batchId" value="<cms:batchId />" />
								<input type="text" class="input-text" value=""
									autocomplete="off" name="value" id="jounal_kw"
									placeholder="请输入刊名/ISSN">
								<button type="submit" class="input-submit search"
									id="quick_search_btn" value="检索">
									<i class="icon iconfont">&#xe604;</i>
								</button>
								<input type="button" class="searchCancle" value="取消">
							</div>
							<div class="radio_js" id="lan_panel">
								<label class="ui-radio" for="radio"><input type="radio"
									value="0" name="lan" checked>全部</label> <label class="ui-radio"
									for="radio"><input type="radio" value="1" name="lan">中文</label>
								<label class="ui-radio" for="radio"><input type="radio"
									value="2" name="lan">外文</label>
							</div>
						</form>
					</dd>
				</div>
				<div class="qk-detail">
					<c:choose>
						<c:when test="${not empty doc.jImage }">
							<div class="inqk-detail"
								style="background-image:url(<cms:getProjectBasePath/>journal/image/${doc._id})"></div>
						</c:when>
						<c:otherwise>
							<div class="inqk-detail"
								style="background-image:url(<cms:getProjectBasePath/>resources/images/qk_default1.png)"></div>
						</c:otherwise>
					</c:choose>
					<h2>
						<span>${doc.docTitle }</span> <i id="favorites" title="收藏"
							class="icon iconfont fr" docId="${doc._id}"
							docTitle="${doc.docTitle }" data-toggle="favorite"
							<c:if test="${isFavorie }">style="display: none;"</c:if>>&#xe611;</i>
						<i id="unfavorites" title="已收藏" class="icon iconfont fr active"
							docId="${doc._id}" docTitle="${doc.docTitle }"
							<c:if test="${!isFavorie }">style="display: none;"</c:if>>&#xe611;</i>
					</h2>
					<div class="qk-info">
						<div class="qkfm">
							<c:if test="${doc['isOpen']==1}">
								<span class="oa">OA刊</span>
							</c:if>
							<c:choose>
								<c:when test="${not empty doc.jImage }">
									<a href="<cms:journalHomePageUrl doc="${doc }"/>"> <img
										src="<cms:getProjectBasePath/>journal/image/${doc._id}" />
									</a>
								</c:when>
								<c:otherwise>
									<a href="<cms:journalHomePageUrl doc="${doc }"/>"> <img
										src="<cms:getProjectBasePath/>resources/images/qk_default1.png" />
									</a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="qk-descrip">
							<ul>
								<c:if test="${not empty doc['issn'] }">
									<li><strong>ISSN：</strong>${doc['issn'].substring(0,9)}</li>
								</c:if>
								<c:if test="${not empty doc['editor'] }">
									<li><strong>主编：</strong>${doc['editor']} <!-- <c:if test="${doc['editor'].length()>14}">
					                 	 ${doc['editor'].substring(0,12)}...
					                 </c:if>
					                 <c:if test="${doc['editor'].length()<14}">
					                 	 ${doc['editor']}
					                 </c:if> --></li>
								</c:if>
								<c:if test="${not empty doc['country'] }">
									<li><strong>国家：</strong> <c:if
											test="${doc['country'].length()>14}">
					                 	 ${doc['country'].substring(0,12)}...
					                 </c:if> <c:if test="${doc['country'].length()<14}">
					                 	 ${doc['country']}
					                 </c:if></li>
								</c:if>
								<c:if test="${not empty doc['docLan'] }">
									<li><strong>语种：</strong> <c:if
											test="${doc['docLan'].length()>14}">
					                 	 ${doc['docLan'].substring(0,12)}...
					                 </c:if> <c:if test="${doc['docLan'].length()<14}">
					                 	 ${doc['docLan']}
					                 </c:if></li>
								</c:if>
								<c:if test="${not empty doc['publishCycle'] }">
									<li><strong>出版频次：</strong>${doc['publishCycle']}</li>
								</c:if>
								<c:if test="${not empty doc['year'] }">
									<li><strong>创刊年：</strong>${doc['year']}年</li>
								</c:if>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
					<div class="qk-link">
						<c:if test="${not empty doc.mainLink }">
							<div
								class="qk-flex<c:if test="${empty doc.dbLinks }"> qk-flex-lg</c:if>">
								<a href="${doc.mainLink.titleUrl }" class="btn-grey"><i
									class="icon iconfont">&#xe616;</i><span>期刊官网</span></a>
							</div>
						</c:if>
						<c:if test="${not empty doc.dbLinks }">
							<div
								class="qk-flex <c:if test="${empty doc.mainLink }"> qk-flex-lg</c:if>">
								<c:forEach var="dbLink" items="${doc.dbLinks }" varStatus="idx"
									begin="0" end="0">
									<a href="${dbLink.titleUrl }" class="btn-grey" target="_blank"><i
										class="icon iconfont">&#xe617;</i><span>数据库地址</span></a>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</div>

				<div class="qk-chart">
					<div class="echart-nav">
						<div class="echart-tab-nav-w">
							<div class="posire">
								<c:if test="${ not empty shoulu and fn:length(shoulu) > 0 }">
									<ul class="echart-tab-nav ui-tab-nav"
										id="sliderSegmentedControl">
										<c:forEach var="item" items="${shoulu }" varStatus="idx">
											<a
												class="<c:if test="${item.key eq db}"> mui-active current</c:if>"<%-- href="#dbs${idx.index}" --%>>
												${item.key } </a>
										</c:forEach>
									</ul>
								</c:if>
							</div>
						</div>
					</div>
					<div class="qk-chart-tab" id="slider">
						<section>

							<div class="ui-tab">

								<c:if test="${ not empty shoulu and fn:length(shoulu) > 0 }">
									<div class="mui-slider-group">
										<c:forEach var="item" items="${shoulu }" varStatus="idx">
											<div class="mui-slider-item mui-control-content"
												data-first="${item.key}" id="dbs${idx.index}">
												<c:if test="${item.value.hasImpact }">
													<c:choose>
														<c:when
															test="${(item.key eq '中科院JCR分区(大类)'||item.key eq '中科院JCR分区(小类)')&&zky!=1}">
															<div id="${item.key }" class="echart-box">
															<script type="text/javascript">
                                                                    var mychart = {divId: '${item.key }',
                                                                        legend:["影响因子"],
                                                                        xAxis: ${item.value.zkyNewYear},
                                                                        series: ${item.value.zkyNewDate}
                                                                    }
                                                                    divIds.push(mychart);
					                        				</script>
															</div>
														</c:when>
														<c:when test="${item.key eq 'Eigenfactor'}">
															<div id="${item.key }" class="echart-box"
																 <c:if test='${ empty item.value.dataM }'>style="width:100%"</c:if>></div>
															<script type="text/javascript">
                                                                var mychart = {divId: '${item.key }',
                                                                    legend:["特征因子"],
                                                                    xAxis:${item.value.xAxisM},
                                                                    series:${item.value.dataM}
                                                                }
                                                                divIds.push(mychart);
															</script>
														</c:when>
														<c:otherwise>
															<div class="echart-box" id="${item.key }"
																<c:if test='${ empty item.value.dataM }'>style="width:100%"</c:if>></div>
															<script type="text/javascript">
                                                                var mychart = {divId: '${item.key }',
                                                                    legend:["影响因子"],
                                                                    xAxis:${item.value.xAxisM},
                                                                    series:${item.value.dataM}
                                                                }
                                                                divIds.push(mychart);
				                        				</script>
														</c:otherwise>
													</c:choose>
												</c:if>

												<div class="factors">
													<div class="factors-head">
														<span><c:forEach var="year"
																items="${item.value.yearsM }"
																begin="${item.value.yearsM.size()-1 }"
																end="${item.value.yearsM.size()-1 }">
				                        				
			                        						${year }
			                        					</c:forEach></span><i class="icon iconfont fr">&#xe610;</i>
														<div class="inchosen">
															<ul>
																<c:forEach var="year" items="${item.value.yearsM }" varStatus="years">
																	<c:choose>
																		<c:when test="${item.key eq 'CSSCI'}">
																			<th>${year-1 }-${year}</th>
																		</c:when>
																		<c:when
																			test="${(item.key eq '中科院JCR分区(大类)'||item.key eq '中科院JCR分区(小类)')&&!years.last&&zky!=1}">
																		</c:when>
																		<c:otherwise>
																			<li>${year }</li>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</ul>
														</div>
													</div>
													<div class="factors-body">
														<c:forEach var="year" items="${item.value.yearsM }">
															<div class="factors-con">
																<c:forEach var="subject" items="${item.value.subjects }">
																	<c:choose>
																		<c:when test="${subject eq '无'}">
																			<!-- <h3>EI</h3> -->
																		</c:when>
																		<c:otherwise>
																			<c:if
																				test="${item.value.yearSubject.get(subject).contains(year) }">
																				<h3>${subject }</h3>
																			</c:if>
																		</c:otherwise>
																	</c:choose>
																	<p>
																		<c:choose>
																			<c:when test="${!item.value.hasPartition }">
																				<c:forEach var="y" items="${item.value.yearsM }"
																					varStatus="idx">
																					<c:if
																						test="${(item.value.yearsM[idx.index] == year)}">
																						<%-- <div class="s${y }"> --%>
																						<c:choose>
																							<c:when
																								test="${(item.key eq '中科院JCR分区(大类)'||item.key eq '中科院JCR分区(小类)')&&!idx.last&&zky!=1}"></c:when>
																							<c:otherwise>
																								<c:if
																									test="${item.value.yearSubject.get(subject).contains(y) }">
																									<c:choose>
																										<c:when test="${subject eq '无'}"> EI源刊 </c:when>
																										<c:otherwise>
																											<a
																												href="<cms:getProjectBasePath/>journal/search/list?&authorityDb=${item.key }&subject=${subject.replaceAll('&','%26')}&queryCdt=shouLuSubjects_3_1_${item.key }^${y }^${subject.replaceAll(',','%25320').replaceAll('&','%26')}&sort=11&viewStyle=list&detailYear=${y }">√</a>
																										</c:otherwise>
																									</c:choose>
																								</c:if>
																							</c:otherwise>
																						</c:choose>
																					</c:if>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<c:forEach var="p"
																					items="${item.value.partitions2M.get(subject) }"
																					varStatus="idx">
																					<c:if
																						test="${(item.value.yearsM[idx.index] == year)}">
																						<%-- <div class="s${item.value.yearsM[idx.index] }"> --%>
																						<c:choose>
																							<c:when
																								test="${(item.key eq '中科院JCR分区(大类)'||item.key eq '中科院JCR分区(小类)')&&!idx.last&&zky!=1}"></c:when>
																							<c:otherwise> 分区： <a
																									href="<cms:getProjectBasePath/>journal/search/list?&authorityDb=${item.key }&subject=${subject.replaceAll('&','%26')}&queryCdt=partition_3_1_${item.key }^${item.value.yearsM[idx.index] }^${subject.replaceAll(',','%25320').replaceAll('&','%26')}^${p }&partition=${p }&sort=11&viewStyle=list&detailYear=${item.value.yearsM[idx.index] }"><c:if
																										test="${not empty item.value.stuffix && p!='' }">${p }${item.value.stuffix }</c:if>
																									<c:if
																										test="${not empty item.value.prefix && p!='' }">${item.value.prefix}${p }</c:if></a>
																							</c:otherwise>
																						</c:choose>
																					</c:if>
																				</c:forEach>
																			</c:otherwise>
																		</c:choose>
																	</p>
																</c:forEach>
															</div>
														</c:forEach>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:if>
							</div>
						</section>
						<div></div>

					</div>

				</div>
				<div class="item-section">
					<h2 class="qk-article">
						<i class="icon iconfont">&#xe615;</i><span>文章列表</span>
					</h2>
					<div id="all-data" style="display: none">
						<ul class="artlist-bd-list arttop"></ul>
					</div>
					<div class="paginatin" id="nextPage">
						<span>下一页</span>
					</div>
					<div class="clear10"></div>
					<script type="text/javascript">
			            	var today=new Date();
			           		var year = today.getFullYear();
			           		var db='${db}';
			           		var size = 20,ajaxflag=true
			            	$(function(){

                                for (var i=0;i<divIds.length;i++){
                                    var myChart = echarts.init(document.getElementById(divIds[i].divId));
                                    var lineData = $.extend(true, {}, detailOption);
                                    lineData.legend.data = divIds[i].legend;
                                    lineData.xAxis[0].data = divIds[i].xAxis;
                                    lineData.series[0].name = divIds[i].legend[0];
                                    lineData.series[0].data = divIds[i].series;
                                    myChart.setOption(lineData,true);
                                }
			            		//$("#data-tab a").eq(0).addClass("active");
			           			//$("#chart-box .chart-box-s").eq(0).show().siblings().hide();
			           			if(db!=''){
			           				$("#slider .mui-control-content").hide();
			           				$("#slider .echart-table-response").hide();
			           				$("#slider .mui-control-content[data-first='"+db+"']").show();
			           				$("#slider .echart-table-response[data-first='"+db+"']").show();
			           				
			           				var data = $("#slider .mui-control-content[data-first='"+db+"']").attr("id");
			           				if(data == null) {
			           					$("#sliderSegmentedControl a").eq(0).attr("class","mui-active current");
			           					$("#slider .mui-control-content").eq(0).show().siblings().hide();
			               				$("#slider .echart-table-response").eq(0).show().siblings().hide();
			           				}
			           			}else{
			           				$("#sliderSegmentedControl a").eq(0).attr("class","mui-active current");
			           				$("#slider .mui-control-content").eq(0).show().siblings().hide();
			           				$("#slider .echart-table-response").eq(0).show().siblings().hide();
			           			}
			           			$("#data-tab a").on("mouseover",function(){
			                   		$(this).addClass("active").siblings().removeClass("active");
			                   		$(".chart-box-s").eq($(this).index()).show().siblings().hide();
			           			});
			            		$('#all-data').html('<div class="qkloading"></div>');
			            		$('#all-data').show();
			            		$('#nextPage').hide();
			            		loadList(year)
			               			
		               			$("#data-tab a").on("mouseover",function(){
		                       		$(this).addClass("active").siblings().removeClass("active");
		                       		$(".chart-box-s").eq($(this).index()).show().siblings().hide();
		               			})
			            	});
			            	//加载下一页
			            	$("#nextPage").click(function(){
			            		$('p.pd36').html("");
			            		var allSize = $('#count').val();
			            		var url = '<cms:getProjectBasePath/>scholar/journalList?journal=${cms:encodeURI(doc.docTitle) }&oaFirst=0&sort=0&start_y='+(year-1)+'&end_y='+year+'&_id=${doc._id}';
			            		url = url+"&offset=" + size;
			            		var that=$(this);
			            		var loading='<p class="loading"><i></i><i class="laymloadtwo"></i><i></i></p>';
			            		if(ajaxflag){
			            			ajaxflag=false;
			            			$.ajax({
				            			type:'get',
				            			url:url,
				            			beforeSend:function(){
				            				if(!$(".loading").length){
				        						that.html(loading);
				        					}
				            			},
				            			success:function(data){
				            				if(data.length>200){
					            				that.html("<span>下一页</span>");
					            				if(allSize < (size+20)) {
					        						$('#nextPage').hide();
					        						$("#all-data").append('<div class="pagenav">'+(size+1)+'-'+allSize+'条</div>');
					        					}else{
					        						$("#all-data").append('<div class="pagenav">'+(size+1)+'-'+(size+20)+'条</div>');
					        						size += 20;
					        					}
					            				$("#all-data").append(data);
					            				myScroll.refresh(); 
					            				ajaxflag=true;
					            				
					            				$(".docdelivery").click(function(){
						            			    var title=$(this).attr("d-title");
						            			    var chooesId = $(this).attr("docId");
						            			    layer.open({
						            			        btn: ['提交'],
						            			        content:'<p class="deltitle">'+title+'</p><div class="docdelbox"><label>邮箱:<input type="text" id="email" /></label></div><p id="err" style="margin:6px 0 4px 0px">&nbsp;</p>',
						            			        yes: function(index){
						            			        	var email = document.getElementById("email").value;
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
						            			          			$('.delivers').hide();
						            			          		}
						            			          	 });
						            			        	layer.close(index);
						            			        }
						            			    })
						            			  })
				            				}else{
				            					ajaxflag=true;
				            					that.html("<span>重新加载</span>");
				            				}
				            			}
				            		})
			            		}
			            	});

							// 列表加载
							function loadList(selYear){
								$('#all-data').load('<cms:getProjectBasePath/>scholar/journalList?journal=${cms:encodeURI(doc.docTitle) }&oaFirst=0&sort=0&start_y='+(selYear-1)+'&end_y='+selYear+'&_id=${doc._id}',function(data)
								{
			            			$('#nextPage').show();
			            			var pagesize = $("#count").val();
			            			if(pagesize <= 20) {
			            				$("#nextPage").hide();
			            			}
			            			var data = $('#all-data').html();
			            			console.log($('#all-data .artlist-bd-list li').length)
			            			size = $('#all-data .artlist-bd-list li').length;
			            			if(data.indexOf("请求超时") != -1){
			            				size = 0;
			            				ajaxflag=true;
			            				$('#nextPage').show();
			            				$("#nextPage").html("<span>重新加载</span>");
			            			} 
			            			myScroll.refresh();
			            			
			            			$(".docdelivery").click(function(){
			            			    var title=$(this).attr("d-title");
			            			    var chooesId = $(this).attr("docId");
			            			    layer.open({
			            			        btn: ['提交'],
			            			        content:'<p class="deltitle">'+title+'</p><div class="docdelbox"><label>邮箱:<input type="text" id="email" /></label></div><p id="err" style="margin:6px 0 4px 40px">&nbsp;</p>',
			            			        yes: function(index){
			            			        	var email = document.getElementById("email").value;
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
			            			          			$('.delivers').hide();
			            			          		}
			            			          	 });
			            			        	layer.close(index);
			            			        }
			            			    })
			            			})
			            		});
							}

			            	// 选择年份
			            	(function(){
			            		var year_wrap = $(".factors .factors-head"),
			            			year_sel = year_wrap.children("span"),
			            			year_list_box = year_wrap.find(".inchosen"),
			            			year_list_opt = year_wrap.find(".inchosen li");
			            	
				            	year_wrap.on('touchend',function(){
				            		year_list_box.toggle();
				            	})
				            	year_list_opt.on('touchend',function(e){
				            		e.stopPropagation();
				            		var txt = $(this).text();
				            		setTimeout(function(){
					            		year_sel.text(txt);
					            		year_list_box.hide();
					            		$('#all-data').html('<div style="min-height:100px" class="loading"></div>');
					            		$('#nextPage').hide();
					            		loadList(txt);
				            		},20)
				            	})
			            	}())
		            </script>
				</div>
			</div>
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
	</div>




	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>

	<script>
(function(){
  $(".mui-slider-item,.echart-box").width($(".mui-slider-group").eq(0).width());
  $('.mui-slider-item').eq(0).show().siblings().hide();
  $('.echart-tab-nav a').click(function(){
	  $(this).addClass('current').siblings().removeClass('current');
	  $('.mui-slider-item').eq($(this).index()).show().css({'z-index':1}).siblings().hide();
	  $('.echart-table-response').eq($(this).index()).show().siblings().hide().css({'z-index':-1});
  })
})()
  var lenData=[0],num=0,cur=0;
  var nav=$(".echart-tab-nav"),len=nav.find("a").length;
  var curPage=0;
  for(var i=0;i<len;i++){
        num=num+$(".echart-tab-nav a").eq(i).width();
        lenData.push(num);
  }

 var posiretScroll = new IScroll('.posire', {
	    mouseWheel: false,
	    scrollbars: false,
	    click:true,
	    scrollX:true,
	    scrollY:false
	})
 	 $('#favorites').click(function() {
	
		var id = $(this).attr("docId");
		var title = $(this).attr("docTitle");
		var type = 2;
		
		$.get('<cms:getProjectBasePath/>user/favorite/'+id+"?type=" + type + "&title="+title,function(data){
			var data=eval("("+data+")");
    		if(data.status==1){
    			 layer.open({content:'<p class="f14 layercolect">已收藏</p>',time: 2})
    			$('#favorites').hide();
    			$('#unfavorites').show();
			} else {
				alert(data.message);
			}
    	 });
	})
	$('#unfavorites').click(function() {
		var id = $(this).attr("docId");
		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
			var data=eval("("+data+")");
			if(data.status==1){
				 layer.open({content:'<p class="f14 layercolect">您已取消收藏</p>',time: 2})
				$('#unfavorites').hide();
    			$('#favorites').show();
			}
		});
	}) 
</script>
</body>
</html>
