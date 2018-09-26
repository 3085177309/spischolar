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
<title>学术期刊指南浏览列表</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<!-- 					<div class="return-back">
						<i class="icon iconfont">&#xe610;</i>
						<span onclick="history.back(-1)">返回</span>
					</div> -->
						<a class="return-back" href="<cms:getProjectBasePath/>journal/">
							<i class="icon iconfont"></i> <span>返回</span>
						</a>
					</div>
				</header>
				<form method="get"
					action="<cms:getProjectBasePath/>journal/category/list"
					id="hide_form">
					<input type="hidden" name="sort" value="${cdt.sort }" /> <input
						type="hidden" name='docType' value='9' /> <input type="hidden"
						name='field' value='${cdt.field }' /> <input type="hidden"
						name='value' value='<c:out value="${cdt.value }"></c:out>' /> <input
						type="hidden" name='lan' value='${cdt.lan }' /> <input
						type="hidden" name='effectSort' value='${cdt.effectSort }' />
					<c:forEach items="${cdt.filterCdt }" var="filterCdt">
						<input type="hidden" name='filterCdt' value='${filterCdt }' />
					</c:forEach>
					<c:forEach items="${cdt.queryCdt }" var="queryCdt">
						<input type="hidden" name='queryCdt' value="${queryCdt }" />
					</c:forEach>
					<input type='hidden' name="sortField" value='${cdt.sortField }' />
					<input type="hidden" value="${cdt.authorityDb }" name='authorityDb' />
					<input type="hidden" value="${cdt.subject }" name='subject' /> <input
						type="hidden" value="${cdt.limit }" name='limit' /> <input
						type="hidden" name='detailYear' value='${cdt.detailYear }' /> <input
						type="hidden" name="viewStyle" value="${cdt.viewStyle }" /> <input
						type="hidden" name="batchId" value="${cdt.batchId }" /> <input
						type="hidden" name="partition" value="${cdt.partition }" />
				</form>
				<div class="common-search mlr0">
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
				<div class="curentsubdata bgfff">
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
					<div class="fl datachose">
						<span javascript:void(0)" id="choose_all"
							<c:if test="${false==isOa }">class="current"</c:if>>全部资源</span> <span
							javascript:void(0)" id="choose_oa"
							<c:if test="${true==isOa }">class="current"</c:if>>OA资源</span>


						<!-- <span>相关资源</span> -->
					</div>
					<!-- <a href="" class="curent-chosen">SCI(2014)</a> -->
				</div>
				<div class="item-section">
					<div class="resource-hd qk-resource-hd">
						<c:choose>
							<c:when test="${searchResult.total>50}">
								<c:set var="total" value="${searchResult.total }" />
							</c:when>
							<c:otherwise>
								<c:set var="total" value="${searchResult.total }" />
							</c:otherwise>
						</c:choose>
						<div class="">
							<cms:keywordShow />
						</div>
					</div>
					<table class="qk-list">
						<tr style="background: rgb(250, 250, 250);">
							<th width="15%">序 号</th>
							<th width="75%" align="left">刊 名</th>

						</tr>


						<c:forEach var="item" items="${searchResult.datas }"
							varStatus="idx">
							<tr>
								<td class="tc">${idx.index+1+offset }</td>
								<td class="tl" style="padding-left: 20px"><a
									href="<cms:getProjectBasePath/>journal/detail/${item._id }?batchId=${cdt.batchId}">${item.docTitleFull }</a>
									<c:if
										test="${fn:contains(login_org.flag,item.orgFlag)==true && not empty item.orgFlag }">
										<i class="gc-icon" title="馆藏期刊"></i>
									</c:if> <c:if test="${item.isOA == 1 }">
										<i class="oa-icon" title="Open Access"></i>
									</c:if> <c:if test="${item.isOA == 2 }">
										<i class="soa-icon" title="Partial Access"></i>
									</c:if> <c:if test="${item.core == '扩展' }">
										<i class="e-icon" title="${db }${item.coreInfo }"></i>
									</c:if></td>

							</tr>
						</c:forEach>
					</table>

				</div>

				<c:if test="${total gt 25 }">
					<div class="paginatin" id="nextPage">
						<span>下一页</span>
					</div>
				</c:if>
				<div class="clear10"></div>
			</div>
			<jsp:include page="include/footer.jsp"></jsp:include>
			<script>
		var myScroll=null;
		$(function(){
			$('body,html').height($(window).height()).css({'overflow':'hidden'});
			$('.mui-content').height($(window).height());
			$(window).resize(function(){
				$('.mui-content').height($(window).height());
				$('body,html').height($(window).height()).css({'overflow':'hidden'});
			})
			myScroll = new IScroll('#mui-content', {
			    mouseWheel: true,
			    scrollbars: false,
			    click:true
			});
		})
		</script>
		</div>

	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script type="text/javascript">
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
//加载下一页
var size = 25,ajaxflag=true;
$("#nextPage").click(function(){
	var url = window.location.href;
	if(url.indexOf('?')!=-1) {
		url = url+"&offset=" + size;
	} else {
		url = url+"?offset=" + size;
	}
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
				that.html("<span>下一页</span>");
				var allSize = '${total}';
				if(allSize < (size+25)) {
					$(".item-section").append('<div class="pagenav">'+(size+1)+'-'+allSize+'条</div>');
					$('#nextPage').hide();
				}else{
					$(".item-section").append('<div class="pagenav">'+(size+1)+'-'+(size+25)+'条</div>');
					size += 25;
				}
				$(".item-section").append(data);
				myScroll.refresh();
				ajaxflag=true;
			}
		})
	}
	
});
</script>
</body>
</html>
