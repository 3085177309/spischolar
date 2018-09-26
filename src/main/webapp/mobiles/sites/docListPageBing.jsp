<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <c:if test="${not empty errorMsg }">
<div  class="reloading" onclick="reloading()" >重新加载</div>
<script type="text/javascript">
myScroll.refresh();
$('#nextPage').hide();
$('.reloading').on('click',function(){
	console.log(1);
})
function reloading(){
	$('#all-data').load('<cms:getProjectBasePath/>scholar/journalList?journal=${cms:encodeURI(doc.docTitle) }&oaFirst=0&sort=0&start_y='+${condition.start_y}+'&end_y='+${condition.end_y}+'&_id=${doc._id}',function(data){
		console.log(data)
		if(data){
			$('#all-data').append(data);
		}else{
			$('#all-data').append('<div  class="reloading" onclick="reloading()">重新加载</div>');
		}	
	})
}
	/* var ajaxflag=true;
	var loading='<p class="loading"><i></i><i class="laymloadtwo"></i><i></i></p>';
	var that=$(this);
	if(ajaxflag){
		ajaxflag=false;
		$.ajax({
			type:'get',
			url:'<cms:getProjectBasePath/>scholar/journalList?journal=${cms:encodeURI(doc.docTitle) }&oaFirst=0&sort=0&start_y='+${condition.start_y}+'&end_y='+${condition.end_y}+'&_id=${doc._id}',
			beforeSend:function(){
				if(!$(".loading").length){
					that.html(loading);
				}
			},
			success:function(data){
				console.log(data);
				if(data){
					$("#all-data").append(data);
					myScroll.refresh(); 
					
				}else{
					that.html('<div  class="reloading">重新加载</div>');
				}
				
				ajaxflag=true;
			},
			error:function(){
				that.html("<span>重新加载</span>");
			}
		})
	} */
</script>
</c:if> --%>
<c:if test="${not empty errorMsg }">
	<c:if
		test="${empty result ||empty result.rows|| fn:length(result.rows) == 0}">
		<c:choose>
			<c:when test="${not empty errorMsg }">
				<p class="pd36">${errorMsg }</p>
			</c:when>
			<c:otherwise>
				<p class="pd36">该期刊最近一年没有发布文章。</p>
			</c:otherwise>
		</c:choose>
	</c:if>
</c:if>
<c:if test="${empty errorMsg }">
	<ul class="artlist-bd-list arttop">
		<c:forEach items="${result.rows }" var="doc" varStatus="s">
			<li>
				<h2 class="ovh <c:if test="${!doc.isFavorite }">titfavorite</c:if>">
					<a
						href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id}?batchId=${condition.batchId}"
						target="_blank" class="link fl"> ${s.index+1+offset }.<c:if
							test="${not empty doc.docType}">${doc.docType }</c:if>
						${doc.title }
					</a>
				</h2>
				<h5>${doc.source }</h5>
				<div class="abstract" onclick="javascript:abstract(this)">
					<p>
						<span>查看摘要</span><i class="icon iconfont fr">&#xe60e;</i>
					</p>
					<div class="abstract-text">${doc.abstract_.replaceAll("<br />", "")}</div>
				</div>
				<h6>
					<c:if test="${not empty doc.quoteText}">
						<a>${doc.quoteText }</a>
						<%-- <a
							href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20'>${doc.quoteText }</a> --%>
					</c:if>
					<c:if test="${!doc.isOpen && !doc.hasLocal}">
						<!-- <cms:getProjectBasePath/>docDilivery?title=<c:out value=" ${doc.title }" />&url=<c:out value=" ${doc.href }" />"  -->
						<span class="docdelivery" docId="${doc.id }"
							d-title="<c:out value=" ${doc.title }" />"
							d-url="<c:out value=" ${doc.href }" />">文献互助 <span
							style="display: none;">${doc.title }</span>
						</span>
					</c:if>
					<c:if test="${not empty doc.openUri}">
						<a url_data="${doc.openUri }" class="exportdownload down" 
							docId="${doc.id }" docTitle="${doc.title }" docHref="${doc.href }">下载</a> 
						<%-- <a href="${doc.openUri }" target="_blank" download>下载</a> --%>
					</c:if>
					<c:if test="${!doc.isFavorite }">
						<a onclick="aa(this,'<cms:getProjectBasePath/>')"
							docId="${doc.id }" class="favorite ">收藏</a>
					</c:if>
					<c:if test="${doc.isFavorite }">
						<a onclick="aa(this,'<cms:getProjectBasePath/>')"
							docId="${doc.id }" class="favorite favorited">收藏</a>
					</c:if>
				</h6>

			</li>
		</c:forEach>
	</ul>
</c:if>
<input type="hidden" id="count" value="${result.count}">
