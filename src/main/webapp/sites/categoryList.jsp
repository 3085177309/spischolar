<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="include/meta.jsp" />
<link href="<cms:getProjectBasePath/>resources/css/chosen.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/js/chosen.jquery.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/pagination.js"></script>
<title>${cdt.authorityDb }_${cdt.subject }_Spi期刊指南</title>
</head>
<body>
	<div class="index-wraper qikan-page">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch"><jsp:include page="include/qksearch.jsp"></jsp:include></div>
				<div class="wraper" id="qkminH">
					<div class="container ovh">
						<div class="con-hd">
							<div class="com-hd fl">筛选:</div>
							<form method="get"
								action="<cms:getProjectBasePath/>journal/category/list"
								id="hide_form">
								<input type="hidden" name="sort" value="${cdt.sort }" /> <input
									type="hidden" name='docType' value='9' /> <input type="hidden"
									name='field' value='${cdt.field }' /> <input type="hidden"
									name='value' value='<c:out value="${cdt.value }"></c:out>' />
								<input type="hidden" name='lan' value='${cdt.lan }' /> <input
									type="hidden" name='effectSort' value='${cdt.effectSort }' />
								<c:forEach items="${cdt.filterCdt }" var="filterCdt">
									<input type="hidden" name='filterCdt' value='${filterCdt }' />
								</c:forEach>
								<c:forEach items="${cdt.queryCdt }" var="queryCdt">
									<input type="hidden" name='queryCdt' value="${queryCdt }" />
								</c:forEach>
								<input type='hidden' name="sortField" value='${cdt.sortField }' />
								<input type="hidden" value="${cdt.authorityDb }"
									name='authorityDb' /> <input type="hidden"
									value="${cdt.subject }" name='subject' /> <input type="hidden"
									value="${cdt.limit }" name='limit' /> <input type="hidden"
									name='detailYear' value='${cdt.detailYear }' /> <input
									type="hidden" name="viewStyle" value="${cdt.viewStyle }" /> <input
									type="hidden" name="batchId" value="${cdt.batchId }" /> <input
									type="hidden" name="partition" value="${cdt.partition }" />
							</form>
							<!--  <div class="com-hd fl">筛选:</div> -->
							<div class="resource-hd fl">
								<c:set var="isOa" value="false"></c:set>
								<c:forEach items="${cdt.filterMap }" var="entry">
									<c:if test="${'oa'==entry.key }">
										<c:forEach items="${entry.value }" var="norms">
											<c:if test="${'1'==norms }">
												<c:set var="isOa" value="true"></c:set>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>

								<label> <c:if test="${true==isOa }">
										<input id="choose_all" name="filterCdt" value="auDB_3_1_SCI-E"
											type="checkbox" checked="checked">
									</c:if> <c:if test="${false==isOa }">
										<input id="choose_oa" name="filterCdt" value="auDB_3_1_SCI-E"
											type="checkbox">
									</c:if> 仅显示OA期刊
								</label>

								<!-- <a href="#">馆藏资源</a> -->
								<script type="text/javascript">
						            (function($){
						            	$(function(){
						            		$('#subject').click(function(){
						            			if($(".related_qk").is(":visible")) {
						            				$('.related_qk').hide();
						            			} else {
						            				$('.related_qk').show();
						            			}
						            			
						            		});
						            		$('#choose_all').click(function(){
						            			for(var i = 0; i < $('#hide_form input[name="filterCdt"]').size(); i++) {
						            				var txt = $($('#hide_form input[name="filterCdt"]').get(i)).val();
						            				
						            				if(txt == 'oa_3_1_1') {
						            					$($('#hide_form input[name="filterCdt"]').get(i)).remove();
						            				}
						            				
						            			}
						            			$('#hide_form').submit();
						            		})
						            		$('#choose_oa').click(function(){
						            			$('#hide_form').append('<input type="hidden" name="filterCdt" value="oa_3_1_1" />');
						            			$('#hide_form').submit();
						            		});
						            	}); 	
						            })(jQuery)
					            </script>
							</div>
							<div class="adta-list-hd">
								<c:choose>
									<c:when test="${searchResult.total>50}">
										<c:set var="total" value="${searchResult.total }" />
									</c:when>
									<c:otherwise>
										<c:set var="total" value="${searchResult.total }" />
									</c:otherwise>
								</c:choose>
								<div class="fr">
									<div class="sc_selbox sr">
										<i></i> <span id="section_s4"> <c:if
												test="${cdt.sort==1 }">创刊年升序</c:if> <c:if
												test="${cdt.sort==2 }">创刊年降序</c:if> <c:if
												test="${cdt.sort==3 }">刊名升序</c:if> <c:if
												test="${cdt.sort==4 }">刊名降序</c:if> <c:if
												test="${cdt.sort==11 and cdt.viewStyle==\"list\"}">影响力</c:if>
											<c:if test="${cdt.sort==11 and cdt.viewStyle!=\"list\"}">相关性</c:if>
										</span>
										<div class="sc_selopt" style="display: none;">

											<c:if test="${db!='CSSCI' }">
												<a href="javascript:sort(11)"><c:choose>
														<c:when test="${cdt.viewStyle==\"list\" }">影响力</c:when>
														<c:otherwise>相关性</c:otherwise>
													</c:choose></a>
											</c:if>
											<a href="javascript:sort(3)">刊名升序</a> <a
												href="javascript:sort(4)">刊名降序</a> <a
												href="javascript:sort(1)">创刊年升序</a> <a
												href="javascript:sort(2)">创刊年降序</a>
										</div>
									</div>
								</div>
								<div class="clear"></div>
								<script type="text/javascript">
						            function sort(sortNum,field){
						            	$('#hide_form input[name="sort"]').val(sortNum);
						            	if(!!field){
						            		$('#hide_form input[name="sortField"]').val(field);
						            	}
						            	$('#hide_form').submit();
						            }
						        </script>
							</div>
							<c:if test="${empty db }">
								<a href="javascript:void(0)" class="fr" id="subject">相关学科</a>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${cdt.viewStyle==\"list\" }">
								<jsp:include page="include/sidebar.jsp"></jsp:include>
							</c:when>
							<c:otherwise>
								<jsp:include page="include/sidebar-search.jsp"></jsp:include>
							</c:otherwise>
						</c:choose>
						<div class="content">
							<div class="fl fl_t">
								<%-- <cms:keywordShow /> --%>
							</div>
							<div class="adta-list">
								<table id="jTable">
								</table>
								<div id="pager" ></div>
								<div class="pagination"></div>
								<!--和原期刊分页结构未变 直接扣过来的 -->
							</div>
						</div>
					</div>
				</div>
				<jsp:include page="include/topsearch.jsp"></jsp:include>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var ajaxHand = function(data,pageUrl,page){
			console.log(pageUrl);
			// 分页条插件配置项
			var size = 25;
			$('.pagination').pagination({
			    coping: true,
			    totalData:data.total?data.total:1, // 数据总数
			    isData:true, // 显示数据条数按钮
			    current:page+1, // 当前页
			    showData:size, // 每页10条
			    isHide:true,
			    jumpBtn:"GO",
			    prevContent: '上一页',
			    homePage:"首页",
			    nextContent: '下一页',
			    endPage:"末页",
			    callback: function (api) {
			    	var page = api.getCurrent() - 1;
			    	$.ajax({
			    		url:pageUrl+'&page='+page+'&size=' + size,
						type:'get',
						//data:  data,
						success:function(result){
							console.log(result);
							renderHtml(result.datas,page,size);
						}
			    	})
			    }
			}); 
			renderHtml(data.datas,page,size);
		}
	
		window.onload=function(){
			searchList();
		}
		function searchList() {
			var sort = '${cdt.sort}';
			var authorityDb = '${cdt.authorityDb}';
			var subject ='${cdt.subject}';
			var detailYear = '${cdt.detailYear}';
			var sortField = '${sortField}';
			var partition = '${cdt.partition}';
			var from = $("#from").val();
			var to = $("#to").val();
			console.log(to);
			var param = location.search;
			param = param + "&sortField=" + sortField;
			var pageUrl = 'http://cloud.test.hnlat.com/search-server/category/list' + param;
			$.ajax({
				type:"get",
				dataType:"json",
				url: pageUrl,
				success:function (result){
					ajaxHand(result,pageUrl,0);
					$("div.fl.fl_t").html(authorityDb+"("+detailYear+") --> " + subject +" "+ result.total + "本期刊");
				},
				error:function(){
				}
			})
		}
		
		var renderHtml = function(data,page,size){
			var batchId = '${cdt.batchId}';
			var flag = '${login_org.flag}';
			var hasImpact = '${hasImpact}';
			var field = '${field}';
			$('#jTable').empty();
			var headAr = new Array();
			var headTr = "<tr style='background: rgb(250, 250, 250);'><th width='10%' class='tc'><strong>序 号</strong></th><th width='60%' class='tc'><strong>刊 名</strong></th><th width='10%' class='tc'><strong>ISSN</strong></th>";
			if(hasImpact != null && hasImpact) {
				headTr = headTr + "<th width='10%' class='tc'><strong>影响因子</strong></th>";
			}
			headTr = headTr + "<th width='10%' class='tc'><strong>链接</strong></th></tr>";
			headAr.push(headTr);
			$('#jTable').append(headAr);
			
	   		if(data.length != 0) {
	   			for ( var i = 0; i < data.length; i++) {
	   				var jsAr = new Array();
				 	var item = data[i];
				 	var tr = "<tr><td class='tc'>" + (page*size+i+1) + "</td><td>" + "<a target='_blank' href='<cms:getProjectBasePath/>journal/detail/"+ item._id +"?batchId="+ batchId +"'>"+ item.docTitleFull +"</a>";
				 	if(!flag.indexOf(item.orgFlag) && item.orgFlag != null) {//${fn:contains(login_org.flag,item.orgFlag)==true && not empty item.orgFlag }
				 		tr = tr + "<i class='gc-icon' title='馆藏期刊'></i>";	
				 	}
				 	if(item.isOA == 1) {
				 		tr = tr + "<i class='oa-icon' title='Open Access'></i>";	
				 	}
				 	if(item.isOA == 2) {
				 		tr = tr + "<i class='soa-icon' title='Partial Access'></i>";	
				 	}
				 	if(item.core == '扩展') {
				 		tr = tr + "<i class='e-icon' title='扩展版'></i>";	
				 	}
				 	tr = tr + "</td>";
					tr = tr + "<td class='tl' style='text-align: center;'>";
				 	if(item.issn != null) {
				 		tr = tr + item.issn.substring(0,9);
				 	}
				 	tr = tr + "</td>";
				 	if(hasImpact != null && hasImpact) {
				 		tr = tr + "<td class='tl' style='text-align: center;'>"+item.sort[field]+"</td>";//<fmt:formatNumber value="${item.sort[field] }" pattern="#0.#######" />
				 	}
				 	tr = tr + "<td class='tc' id='"+item._id+"'>";
				 	if(item.mainLink != null) {
				 		tr = tr + "<a href='"+item.mainLink +"' target='_blank'>期刊官网</a>";
				 	}
				 	tr = tr + "</td></tr>";
				 	jsAr.push(tr);
					$('#jTable').append(jsAr);
	   			}
	   		 }
		}
	</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>