<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="pg"
	uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="artlist-bd border">
	<%-- <div class="artlist-search clearfix">
		<form method="get" action="<cms:getProjectBasePath/>scholar/list"
			id="ajax-journal-list" class="clearfix">
			<input type="hidden" name="journal" value='"${condition.journal }"' />
			<input type="hidden" name="journal" value='${condition.journal }' />
			<input type="hidden" name="sort" value="${condition.sort }" /> <input
				type="text" name="start_y" value="${condition.start_y }"
				style="width: 78px" onkeyup="clearNotInt(this)" /><span>-</span> <input
				type="text" id="end_y" name="end_y" value="${condition.end_y }"
				style="width: 78px" onkeyup="clearNotInt(this)" /> <input
				type="text" name="val" class="inw" value="${condition.val}"
				placeholder="请输入关键词" />
			<button type="submit" class="btn-grey">检索</button>
		</form>
	</div> --%>

	<div class="qkloading" id="all-datas" style="display: none; border: 0"></div>
	<div class="shu-poin">
		<c:if
			test="${empty result ||empty result.rows|| fn:length(result.rows) == 0}">
			<c:choose>
				<c:when test="${not empty errorMsg }">
					<c:if test="${errorMsg == 1 }">
						<%-- 请求超时啦....请重新<span id="refresh" onclick="refresh('${url }')"
							url="${url }">刷新</span>页面 --%>
						<!-- onclick='history.go(0)' -->
						<!--加载超时-->
						<div class="qikan-overtime" onclick="refresh('${url }')"></div>
					</c:if>
					<c:if test="${errorMsg == 2 }">
						<!-- 该期刊最近一年没有发布文章。 -->
						<div class="un-msg"></div>

					</c:if>
				</c:when>
				<c:otherwise>
					<div class="un-qikan-msg"></div>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
	<ul class="artlist-bd-list">
		<c:forEach items="${result.rows }" var="doc" varStatus="s">
			<li>
				<h3 class="title textOver">
					<c:if test="${not empty doc.href }">
						<a
							<c:if test="${not empty doc.href }"> 
								href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id}?batchId=${condition.batchId}"
							</c:if>
							target="_blank" class="link fl"> <!--${s.index+1+offset }、 -->
							<c:if test="${not empty doc.docType}">${doc.docType }</c:if>
							${doc.title }
						</a>
					</c:if>
					<c:if test="${empty doc.href }">
		            	${s.index+1+offset }、<c:if
							test="${not empty doc.docType}">${doc.docType }</c:if>
		                 ${doc.title }
		            </c:if>
				</h3>
				<p class="about">${doc.source }</p>
				<p class="text">${doc.abstract_.replaceAll("<br />", "") }</p>
				<h6 class="clearfix">
					<c:if test="${not empty doc.quoteText}">
						<a target="_blank"
							href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20'>${doc.quoteText }</a>
					</c:if>
					<c:if test="${not empty doc.relatedLink}">
						<a target="_blank"
							href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.relatedLink }"/>&type=related&size=20'>相关文章</a>
					</c:if>
					<c:if test="${not empty doc.versionText }">
						<a target="_blank"
							href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.versionLink }"/>&type=version&size=20'>${doc.versionText }</a>
					</c:if>
					<c:if test="${!doc.isOpen && !doc.hasLocal}">
						<!-- <cms:getProjectBasePath/>docDilivery?title=<c:out value=" ${doc.title }" />&url=<c:out value=" ${doc.href }" />"  -->
						<a
							href="javascript:deliver('${doc.id }','<c:out value=" ${doc.title }" />');"
							class="fl-right wxcd" d-title="<c:out value=" ${doc.title }" />"
							d-url="<c:out value=" ${doc.href }" />">文献互助 
							<span style="display: none;">${doc.title }</span>
						</a>
					</c:if>
					
					<c:if test="${doc.isGoogleBook }">
						<a href="${doc.href }" target="_blank">Google图书馆</a>
					</c:if>
					<!-- 		        <c:if test="${!doc.isFavorite }">
		          		<a href="javascript:favorite('${doc.id }');">收藏</a>
		          	</c:if>
		          	<c:if test="${doc.isFavorite }">
		          		<a href="javascript:unfavorite('${doc.id }');">已收藏</a>
		          	</c:if>
 -->
					<a href="javascript:favorites('${doc.id }');" id="${doc.id}t"
						lang="${doc.isFavorite }" class="favorite fl-right">收藏</a> 
					<a href="javascript:unfavorite('${doc.id }');" id="${doc.id}f"
						class="favoriteY fl-right"><b>已收藏</b></a>
						
					<c:if test="${not empty doc.openUri}">
						<a href="${doc.openUri }" target="_blank" download
							class="down fl-right">下载</a>
					</c:if>
				</h6>
			</li>
		</c:forEach>
	</ul>

</div>

<%-- <c:if test="${result.total>10}">
	<div class="paginatin container" id='journal_doc_paginatin'>
		<ul>
			<li id="all-datas" style="display: none"></li>
			<!-- 首页 -->
			<pg:pager items="${result.total }" url="journalList"
				export="cp=pageNumber" maxPageItems="20" maxIndexPages="10"
				idOffsetParam="offset">
				<pg:param name="journal" value='${condition.journal }' />
				<pg:param name="start_y" value='${condition.start_y }' />
				<pg:param name="end_y" value='${condition.end_y }' />
				<pg:param name="val" value='${condition.val }' />
				<pg:param name="sort" value='${condition.sort }' />
				<!-- 首页 -->
				<pg:first>
					<li><a hrefs='${pageUrl }' id='firstPage' class="ajax-page">首页</a></li>
				</pg:first>
				<pg:prev>
					<li><a hrefs="${pageUrl}" class="ajax-page">上一页</a></li>
				</pg:prev>
				<!-- 中间页码开始 -->
				<pg:pages>
					<c:choose>
						<c:when test="${cp eq pageNumber }">
							<li class="current"><a hrefs="javascript:return false ;">${pageNumber}</a></li>
						</c:when>
						<c:otherwise>
							<li><a hrefs="${pageUrl}" class="ajax-page">${pageNumber}</a></li>
						</c:otherwise>
					</c:choose>
				</pg:pages>
				<!-- 中间页码结束 -->
				<pg:next>
					<li><a id="next_page" hrefs="${pageUrl}" class="ajax-page">下一页</a></li>
				</pg:next>
			</pg:pager>
		</ul>

	</div>
</c:if> --%>

<script type="text/javascript">
var today=new Date();
var year = today.getFullYear();
$('#end_y').attr("placeholder",year);

var doc = window.document, input = doc.createElement('input');
if( typeof input['placeholder'] == 'undefined' ) // 如果不支持placeholder属性
{
    $('input').each(function( ele )
    {
        var me = $(this);
        var ph = me.attr('placeholder');
        if( ph && !me.val() )
        {
            me.val(ph).css('color', '#aaa').css('line-height', me.css('height'));
        }
        me.on('focus', function()
        {
            if( me.val() === ph)
            {
                me.val(null).css('color', '');
            }
 
        }).on('blur', function()
        {
            if( !me.val() )
            {
                me.val(ph).css('color', '#aaa').css('line-height', me.css('height'));
            }
        });
    });
}

function refresh(href) {
	$('#all-data div.shu-poin').html("");
	$('#all-datas').show();
	$('#all-data').load('<cms:getProjectBasePath/>'+ href);
}

$(function(){
	/**分页*/
	$('.ajax-page').bind('click',function(e){
		var href=$(this).attr('hrefs');
		$('#all-datas').show();
		$('#all-data').load('<cms:getProjectBasePath/>scholar/'+href);
		$(window).scrollTop($("#article").offset().top-50);
		e.preventDefault();
	});
	/**检索*/
	$('#ajax-journal-list').submit(function(e){
		var val=$('.inw').val();
		if(val==$('.inw').attr("placeholder")) {
			$('.inw').val("");
		}
	});
});

var favorite = $('.favorite');
for(var i = 0; i < favorite.length; i++) {
	if(favorite.eq(i).attr("lang") == "true") {
		$('.favorite').eq(i).hide();
		$('.favoriteY').eq(i).show();
	} else {
		$('.favorite').eq(i).show();
		$('.favoriteY').eq(i).hide();
	}
}
function unfavorite(id){
	$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
		if(data.status==1){
			$("#"+id+"f").hide();
			$("#"+id+"t").show();
		}
	});
}
function favorites(id){
	 $.get('<cms:getProjectBasePath/>user/favorite/'+id,function(data){
		if(data.status==1){
			$("#"+id+"t").hide();
		$("#"+id+"f").show();
		}
	 });
}

var chooesId;
function deliver(id,title){
	 chooesId=id;
	 $('body').addClass('delivers-open');
	 $('p#title_line').html(title);
}

function search(){
	 var email = document.getElementById("del-email").value;
	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 if(!em.test(email)) {
		 $('#err').html("邮箱格式不正确").css("color","red");
		 return false;
	 }
	 $.get('<cms:getProjectBasePath/>user/dilivery/'+chooesId+'/?email='+email+'&math='+Math.random(),function(data){
 		//alert(data.message); 
 		if(data.message == "请不要重复提交！") {
 			alert(data.message); 
 		} else {
 			$('#deliveryAlert-moadl div.modal-context p').html('');
  			$('#deliveryAlert-moadl div.modal-context p').html(data.message);
      		deliveryAlert();
  			$('body').removeClass('delivers-open')
 		}
 	 });
}
$(function(){
    $('.delivers').find('.Win-close').click(function(e){
   	 $('body').removeClass('delivers-open');
        $('p#err').html("&nbsp;");
        e.preventDefault();
    })
})
</script>
<!-- 文献互助 -->
<div class="showWin delivers" id="delivers">
	<div class="Win-bj"></div>
	<div class="Win-cont">
		<div class="title">文献互助：</div>
		<div class="Win-pannel">
			<span class="Win-close"></span>
			<div class="">
				<input type="hidden" name="title"> <input type="hidden"
					name="url">
				<div class="middle-box">
					<p class="sech_title" id="title_line"></p>
				</div>


				<p class="con clearfix">
					<span>邮箱：</span> <input type="text" name="email" id="del-email"
						class="sc_put"
						value='<c:if test="${not empty sessionScope.front_member}">${sessionScope.front_member.email }</c:if>'>
					<span id="err" class="err">&nbsp;</span>
				</p>

				<div class="tc">
					<input name="journal" type="submit" class="submit-btn"
						onclick="search()" value="提交">
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 文献互助结果弹窗0 -->
<div class="modal deliveryAlert-moadl" id="deliveryAlert-moadl">
	<div class="modal-bg"></div>
	<div class="modal-line"></div>
	<div class="modal-box">
		<i class="modal-close"></i>
		<div class="modal-title">提示：</div>
		<div class="modal-context">
			<p class="c"></p>
		</div>
	</div>
</div>
<script type="text/javascript">
/*
 * 文献互助结果弹窗
 */
 function deliveryAlert() {
	 $('body').addClass('deliveryAlert-open');
		
	$('.modal-close').live('click',function(){
		//$('.modal-context').html('')
	  	$('body').removeClass('deliveryAlert-open');
  	})
  	$('.close').live('click',function(){
		//$('.modal-context').html('')
	  	$('body').removeClass('deliveryAlert-open');
  	})
}
</script>