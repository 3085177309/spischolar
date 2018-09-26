<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<%-- <title id="docTitle">${doc.docTitle }_Spi期刊指南</title> --%>
<title class="docTitle"></title>
<style type="text/css">
p b {
	color: red
}

article, aside, dialog, footer, header, section, footer, nav, figure,
	menu {
	display: block;
}
</style>
<script src="<cms:getProjectBasePath/>resources/js/wdEcharts.js?v=1.0.1"></script>
<script src="<cms:getProjectBasePath/>resources/js/echartsDataModel.js?v=1.0.1"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script>
divIds = [];
</script>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch clearfix"><jsp:include
						page="include/qksearch.jsp"></jsp:include></div>
				<div class="wraper">
					<div class="container">
						<div class="qkdetail border">
							<div class="qkdetail-hd">
								<a class="docTitle" target="_blank"></a>
								<span class="change-title" id="change-title"></span>
							</div>
							<div class="qkdetail-bd">
								<div class="qkdetail-bd-l">
									<div class="qkdetail-bd-fm">
										<a id="img_href" target="_blank">
											<img src="http://cloud.test.hnlat.com/resources-server/journal/${id }.jpg" 
												onerror="javascript:this.src='<cms:getProjectBasePath/>resources/images/qk_default1.png'" /></p> 
										</a>
										
									</div>
									<div class="tc">
										<div id="main_link">
										</div>
										<div id="db_link">
										</div>
									</div>

								</div>
								<div class="qkdetail-bd-r" id="qkdetail">
									<div class="qk-share-video">
										<a id="favorites" class="qk-collection" 
											<c:if test="${isFavorie }">style="display: none;"</c:if>>
											<i class="i"></i><span>收藏</span>
										</a> 
										<a id="unfavorites" class="qk-collection active" 
											<c:if test="${!isFavorie }">style="display: none;"</c:if>>
											<i class="i"></i><span>已收藏</span>
										</a> 
										<a href="http://www.jiathis.com/share"
											class="qk-share jiathis jiathis_txt" target="_blank">
											<i class="i"></i><span>分享</span>
										</a>
										<c:if test="${not empty video }">
											<div class="qk-sub-video">
												<a
													href="<cms:getProjectBasePath/>journal/video?submissionSystem=${video.submissionSystem }"
													target="_blank"> <i class="i"></i><span>投稿演示</span> <em>
														<div>
															<h3>${video.submissionSystem }投稿系统演示视频</h3>
															<h4>时长：${video.time }</h4>
															<p>${video.abstracts }</p>
															<i></i>
														</div>
												</em>
												</a>
											</div>
										</c:if>
									</div>
									<ul class="field">
									</ul>
									<c:if
										test="${not empty doc['phone'] || not empty doc['address'] || not empty doc['email'] || not empty doc['description']}">
										<a href="javascript:void(0)" class="toggle">展开</a>
									</c:if>

									<c:if test="${ not empty shoulu and fn:length(shoulu) > 0 }">
										<div class="chart border">
											<div class="data-tab" id="data-tab">
												<c:forEach var="item" items="${shoulu }" varStatus="idx">
													<c:choose>
														<c:when test="${item.key eq '中科院JCR分区(大类)'}">
															<a href="#" id="data-tab-zky_d" style="display: none"
																<c:if test="${item.key eq db}">class="active"</c:if>>
																${item.key } </a>
														</c:when>
														<c:when test="${item.key eq '中科院JCR分区(小类)'}">
															<a href="#" id="data-tab-zky_x" style="display: none"
																<c:if test="${item.key eq db}">class="active"</c:if>>
																${item.key } 
															</a>
														</c:when>
														<c:when test="${item.key eq '北大核心'}">
															<a href="#" id="data-tab-bdhx" style="display: none"
																<c:if test="${item.key eq db}">class="active"</c:if>>
																${item.key } 
															</a>
														</c:when>
														<c:otherwise>
															<a href="#" id="data-tab-${item.key }" style="display: none"
																<c:if test="${item.key eq db}">class="active"</c:if>>
																${item.key } 
															</a>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</div>
											<div class="chart-box" id="chart-box">
												<c:forEach var="item" items="${shoulu }" varStatus="idx">
													<div class="chart-box-s" id="dbs${idx.index }"
															style="padding: 3px;" data-first="${item.key}">
															<div>
																<div id="${item.key }" style="width: 800px; height: 300px; position: relative;margin: 0 auto;">
																		<script type="text/javascript">
																			// 路径配置
																		    require.config({
																		        paths: {
																		            echarts: 'http://echarts.baidu.com/build/dist'
																		        }
																		    });
																		    var myChart;
																		    var EChartst;
																		    require([
																		             'echarts',
																		             'echarts/chart/line' // 使用柱状图就加载bar模块，按需加载
																		         ],function(ec){
																		    	EChartst = ec;
																				myChart = ec.init(document.getElementById('${item.key }')); 
																			});
																		</script> 
																</div>
															</div>
															<c:choose>
																<c:when test="${item.key eq '中科院JCR分区(大类)'}">
																	<table id="table_zky_d"></table>
																</c:when>
																<c:when test="${item.key eq '中科院JCR分区(小类)'}">
																	<table id="table_zky_x"></table>
																</c:when>
																<c:when test="${item.key eq '北大核心'}">
																	<table id="table_bdhx"></table>
																</c:when>
																<c:otherwise>
																	<table id="table_${item.key }"></table>
																</c:otherwise>
															</c:choose>
													</div> 
												</c:forEach>
											</div>
										</div>
									</c:if>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>

					<div class="artlist artlist-new">
						<c:choose>
							<c:when test="${ztfxIsExists}">
								<div class="tab_tit container">
									<ul class="tab_tit_list" id="tab_tit">
										<li id="analysis" class="in">主题分析</li>
										<li id="detailList" class="wzlb">文章列表</li>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<div class="tab_tit container" style="overflow: visible;text-align: center;">
									<ul>
										<li><span id="title" style="display: none">文章列表</span></li>
									</ul>

									<button id="detailList" class="detailList"></button>
								</div>
							</c:otherwise>
						</c:choose>

						<div id="all-data" style="display: none"></div>
						<script type="text/javascript">
							var journalSearchTitle;
							
			            	var today=new Date();
			           		var year = today.getFullYear();
			           		var db='${db}';
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
			           			if(db!=''){
			           				$("#chart-box .chart-box-s").hide();
			           				$("#chart-box .chart-box-s[data-first='"+db+"']").show();
			           				
			           				var data = $("#chart-box .chart-box-s[data-first='"+db+"']").attr("id");
			           				if(data == null) {
			           					$("#chart-box .chart-box-s").eq(0).show().siblings().hide();
			           				}
			           			}else{
			           				$("#chart-box .chart-box-s").eq(0).show().siblings().hide();
			           			}
			           			$("#data-tab a").on("mouseover",function(){
			                   		$(this).addClass("active").siblings().removeClass("active");
			                   		$(".chart-box-s").eq($(this).index()).show().siblings().hide();
			           			});
			           			
			           			$('#all-data').show();
			           			if ("${ztfxIsExists}" == "true"){
			           				$('#all-data').html('<div id="ztpc"></div>');
				            		//主题分析1
				            		$("#ztpc").load('<cms:getProjectBasePath/>ztfx/init',function(){
                                        //加载完成 初始化下拉列表
                                        scSelboxN();
                                    });
			           			}else{
			           				 $('#analysis').remove();
			           			}
			           			

			               		
			           			$('div.tab_tit li').each(function(){
									$(this).click(function(e){
										//焦点切换 
										$('div.tab_tit li').removeClass('in');
										$(this).addClass('in');
										if ($(this).attr('id') != "detailList"){
                                            $('#journalList').hide()
                                            $('#all-data').html('<div id="ztpc"></div>');
                                            $('#all-data').show();
                                            //主题分析2
                                            $("#ztpc").load('<cms:getProjectBasePath/>ztfx/init',function(){
                                                //加载完成 初始化下拉列表
                                                scSelboxN();
                                            });
										}
									});
								});
			            	});
							/**文章列表*/
						 	$('#detailList').click(function() {
								$('#all-data').html('<div id="journalList" class="qkloading"></div>');
			            		$('#all-data').show();
			            		$('button.detailList').hide();
			            		$('#title').show();
			            		console.log(journalSearchTitle);
			            		$('#journalList').load('<cms:getProjectBasePath/>scholar/journalList?journal="${cms:encodeURI(journalSearchTitle) }"&oaFirst=0&sort=0&start_y='+(year-1)+'&end_y='+year+'&_id=${doc._id}',function(){
			            		});
			            		$("#data-tab a").on("mouseover",function(){
		                       		$(this).addClass("active").siblings().removeClass("active");
		                       		$(".chart-box-s").eq($(this).index()).show().siblings().hide();
		               			})	
							}) 
			            	
			            	$('#favorites').click(function() {
			            		var id = $(this).attr("docId");
			            		var title = $(this).attr("docTitle");
			            		var type = 2;
			            		$.get('<cms:getProjectBasePath/>user/favorite/'+id+"?type=" + type + "&title="+title,function(data){
			                   		if(data.status==1){
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
			            			if(data.status==1){
			            				$('#unfavorites').hide();
			                   			$('#favorites').show();
			            			}
			            		});
			            	})
			            </script>

					</div>
				</div>
				<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
				<jsp:include page="include/topsearch.jsp"></jsp:include>
					<!--  期刊变更 -->
					<div class="showWin change-title-box" id="change-title-box">
						<div class="Win-bj"></div>
						<div class="Win-cont">
							<div class="Win-pannel">
								<span class="Win-close"></span>
								<div class="">
									<!-- <p>doc['note']</p> -->
									<p></p>
								</div>
							</div>
						</div>
					</div>
					<script type="text/javascript">
						$(function(){
							$('#change-title').click(function(){
								$(document.body).addClass('modal-open-change');
								$('#change-title-box').show()
								$('#change-title-box .Win-close').click(function(){
									$(document.body).removeClass('modal-open-change');
								})
							})
						})
					</script>
					<!--  期刊变更end -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var db = '${db}';
		window.onload=function(){
			searchList();
		}
		function searchList() {
			var id = '${id}';
			
			$.ajax({
				type:"get",
				dataType:"json",
				url: "http://cloud.test.hnlat.com/search-server/detail/" + id,
				success:function (result){
					console.log(result);
					renderHtml(result);
				},
				error:function(){
				}
			})
		}
		
		var renderHtml = function(data){
			$('title.docTitle').html(data.docTitle + "_Spi期刊指南");
			$('a.docTitle').html(data.docTitle);
			if(null != data.mainLink) {
				$('a.docTitle').attr("href",data.mainLink);
				$('#img_href').attr("href",data.mainLink);
				var text = "<h3 id='main_link_h3'>主页地址</h3><a href='"+data.mainLink+"' class='btn-grey' target='_blank'>官网</a>";
				$("#main_link").append(text);
			}
			if(null != data.dbLinks) {
				var text = "<h3 id='main_link_h3'>数据库地址</h3>";
				for(var i=0;i<data.dbLinks.length;i++) {
					var dbLink = data.dbLinks[i];
					if(null != dbLink.dbName) {
						text = text + "<a href='" + dbLink.titleUrl + "' class='btn-grey' target='_blank'>"+dbLink.dbName +"</a>";
					} else {
						text = text + "<a href='" + dbLink.titleUrl + "' class='btn-grey' target='_blank'>数据库地址</a>";
					}
				}
				$("#db_link").append(text);
			}
			
			if(null != data.note) {
				$('#change-title').html("期刊更名记录");
				$('#change-title-box p').html(data.note);
			}
			if(null != data.wtitle) {
				journalSearchTitle = data.wtitle;
			} else {
				journalSearchTitle = data.docTitle;
			}
			if(data.isOpen==1) {
				$('.qkdetail-bd-fm').append("<span class='oa'>OA刊</span>");
			}
			$("#favorites").attr("docId",data._id);
			$("#favorites").attr("docTitle",data.docTitle);
			$("#unfavorites").attr("docId",data._id);
			$("#unfavorites").attr("docTitle",data.docTitle);
			ulInfo(data);
			echarInfo(data)
			tableInfo(data);
		}
		
		var tableInfo = function(data) {
			var zky = '${zky}';
			var map = data.souLu;
			for(var key in map){
				var jsAr = new Array();
				var tr = "<tr><th width='20%'></th>"; 
				for(var i = 0; i < map[key].years.length; i++) {
					var year = map[key].years[i];
					if(key == 'CSSCI') {
						if(year = 2018) {
							tr = tr + "<th>2017-2018</th>";
						} else {
							tr = tr + "<th>"+(year-2)+"-"+year+"</th>";
						}
					} else if((key == '中科院JCR分区(大类)' || key == '中科院JCR分区(小类)') && zky!=1) {
					} else {
						tr = tr + "<th>"+year+"</th>";
					}
				}
				tr = tr + "</tr>";
				jsAr.push(tr);
				if(map[key].hasImpact) {
					var impactTr = "<tr>"; 
					if(key == 'Eigenfactor') {
						impactTr = impactTr + "<th>特征因子</th>";
					} else {
						impactTr = impactTr + "<th>影响因子</th>";
					}
					for(var i = 0; i < map[key].impacts.length; i++) {
						if((key == '中科院JCR分区(大类)' || key == '中科院JCR分区(小类)') && zky!=1) {
						} else {
							impactTr = impactTr + "<td align=center>"+map[key].impacts[i]+"</td>";
						}
					}
					impactTr = impactTr + "</tr>";
					jsAr.push(impactTr);
				}
				for(var i = 0; i < map[key].subjects.length; i++) {
					
					var subjectTr = "<tr>"; 
					var subject = map[key].subjects[i];
					
					if(subject == '无') {
						subjectTr = subjectTr + "<th>EI</th>";
					} else {
						subjectTr = subjectTr + "<th>"+subject+"</th>";
					}
					if(!map[key].hasPartition) {
						
						for(var j = 0; j < map[key].years.length; j++) {
							var y = map[key].years[j];
							 if((key == '中科院JCR分区(大类)' || key == '中科院JCR分区(小类)') && zky!=1) {
							 } else {
								 subjectTr = subjectTr + "<td align='center'>";
								 if(map[key].yearSubject[subject].indexOf(y) != -1) {
									 if(subject == '无') {
										 subjectTr = subjectTr + "√";
									 } else {
										 subjectTr = subjectTr + "<a target='_break' href='<cms:getProjectBasePath/>journal/category/list?&authorityDb="+key+"&subject="+subject.replace(new RegExp('&',"gm"),'%26')+"&queryCdt=shouLuSubjects_3_1_"+key+"%5E"+y+"%5E"+subject.replace(new RegExp(',',"gm"),'%25320').replace(new RegExp('&',"gm"),'%26')+"&sort=11&viewStyle=list&detailYear="+y+"'>√</a>";
									 }
								 }
							 }
						}
					} else {
						for(var j = 0; j < map[key].partitions2[subject].length; j++) {
							var p = map[key].partitions2[subject][j];
							if((key == '中科院JCR分区(大类)' || key == '中科院JCR分区(小类)') && zky!=1) {
							} else {
								subjectTr = subjectTr + "<td align='center'><a target='_break' href='<cms:getProjectBasePath/>journal/category/list?&authorityDb="+key+"&subject="+subject.replace(new RegExp('&',"gm"),'%26')+"&queryCdt=partition_3_1_"+key+"%5E"+map[key].years[j] +"%5E"+subject.replace(new RegExp(',',"gm"),'%25320').replace(new RegExp('&',"gm"),'%26')+"%5E"+p +"&partition="+p +"&sort=11&viewStyle=list&detailYear="+map[key].years[j]+"'>";
								if(null != map[key].stuffix && p!='') {
									subjectTr = subjectTr +  p + map[key].stuffix;
								} else if(null != map[key].prefix && p!='') {
									subjectTr = subjectTr + map[key].prefix + p;
								}
								subjectTr = subjectTr + "</a></td>";
							}
						}
					}
					subjectTr = subjectTr + "</tr>";
					jsAr.push(subjectTr);
				}
				if(key == '中科院JCR分区(大类)') {
					key = 'zky_d';
				} else if(key == '中科院JCR分区(小类)') {
					key = 'zky_x';
				} else if(key == '北大核心') {
					key = 'bdhx';
				}
				$("#table_" + key).append(jsAr);
			}
		}
		
		/* 图表信息 */
		var echarInfo = function(data) {
			var zky = '${zky}';
			var map = data.souLu;
			for(var key in map){
				myChart = EChartst.init(document.getElementById(key)); 
				var option = {
			         legend: {
			         	data:['']
			         },
			         xAxis : [
			         	{
			             	type : 'category',
			             	data : []
			             }
			         ],
			         yAxis: {
			             type: 'value'
			         },
			         series : [
			        	 {
			        	        data: [],
			        	        type: 'line',
			        	        name: ''
			        	   }
			         ]
			     };
				if((key == '中科院JCR分区(大类)' || key == '中科院JCR分区(小类)') && zky!=1) {
					option.legend.data = ["影响因子"];
					option.xAxis[0].data = eval('(' + map[key].zkyNewYear + ')');
					option.series[0].data = eval('(' + map[key].zkyNewDate + ')');
					option.series[0].name = "影响因子";
				} else if(key == 'Eigenfactor') {
					option.legend.data = ["特征因子"];
					option.xAxis[0].data = eval('(' + map[key].xAxis + ')');
					option.series[0].data = eval('(' + map[key].data + ')');
					option.series[0].name = "特征因子";
				} else {
					if(map[key].data != '[null]') {
						option.legend.data = ["影响因子"];
						option.xAxis[0].data = eval('(' + map[key].xAxis + ')');
						option.series[0].data = eval('(' + map[key].data + ')');
						option.series[0].name = "影响因子";
					} else {
						myChart.clear();
						$('#'+key).remove();
					}
				}
			 	myChart.hideLoading(); 
				myChart.setOption(option,true);
				if(key == '中科院JCR分区(大类)') {
					key = 'zky_d';
				} else if(key == '中科院JCR分区(小类)') {
					key = 'zky_x';
				} else if(key == '北大核心') {
					key = 'bdhx';
				}
				$("#data-tab-"+key).show();
			}
		}
		
		
		/* 期刊信息 */
		var ulInfo = function(data){
			var jsAr = new Array();
			var ul = ""; 
			if(null != data.issn) {
				ul = ul + "<li><strong>【ISSN】：</strong>"+ data.issn.substring(0,9) +"</li>";
			}
			if(null != data.eissn) {
				ul = ul + "<li><strong>【EISSN】：</strong>"+ data.eissn.substring(0,9) +"</li>";
			}
			if(null != data.editor) {
				ul = ul + "<li><strong>【主编】：</strong>"+ data.editor +"</li>";
			}
			if(null != data.country) {
				ul = ul + "<li><strong>【国家】：</strong>"+ data.country +"</li>";
			}
			if(null != data.docLan) {
				ul = ul + "<li><strong>【语种】：</strong>"+ data.docLan +"</li>";
			}
			if(null != data.publishCycle) {
				ul = ul + "<li><strong>【出版频次】：</strong>"+ data.publishCycle +"</li>";
			}
			if(null != data.year) {
				ul = ul + "<li><strong>【创刊年】：</strong>"+ data.year +"</li>";
			}
			if(null != data.email) {
				ul = ul + "<li><strong>【Email】：</strong><ahref='mailto:"+data.email+"'>"+data.email+"</a></li>";
			}
			if(null != data.address) {
				ul = ul + "<li><strong>【地址】：</strong>"+ data.address +"</li>";
			}
			if(null != data.phone) {
				ul = ul + "<li><strong>【电话】：</strong>"+ data.phone +"</li>";
			}
			if(null != data.description) {
				if(data.description.length > 610) {
					ul = ul + "<li class='w' title='"+data.description+"'><strong>【内容介绍】：</strong>"+data.description.substring(0, 610)+"...</li>";
				} else {
					ul = ul + "<li class='w' title='"+data.description+"'><strong>【内容介绍】：</strong>"+data.description+"...</li>";
				}
			}
			jsAr.push(ul);
			$("ul.field").append(jsAr);
		}
	
	</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
	<script type="text/javascript"
		src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
</body>
</html>