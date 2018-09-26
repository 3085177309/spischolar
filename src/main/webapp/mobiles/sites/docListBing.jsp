<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>学术搜索结果列表</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">

		<div class="data-sort-bd">
			<!-- 时间筛选表单 -->
			<form action="<cms:getProjectBasePath/>scholar/list" method="get"
				id="sort_form">
				<c:if test="${not empty condition.val }">
					<input type="hidden" name="val" value='${condition.val }' />
				</c:if>
				<c:if test="${not empty condition.journal }">
					<input type="hidden" name="journal" value="${condition.journal }" />
				</c:if>
				<c:if test="${not empty condition.fileType }">
					<input type="hidden" name="fileType" value="${condition.fileType }" />
				</c:if>
				<c:if test="${not empty condition.queryType }">
					<input type="hidden" name="queryType"
						value="${condition.queryType }" />
				</c:if>
				<c:choose>
					<c:when
						test="${not empty condition.oaFirst or condition.oaFirst==1 }">
						<input type="hidden" name="oaFirst" value="${condition.oaFirst }" />
					</c:when>
					<c:otherwise>
						<input type="hidden" name="oaFirst" value="0" />
					</c:otherwise>
				</c:choose>
				<c:forEach var="group" items="${condition.groups }"
					varStatus="index">
					<input type="hidden" name="groups[${index.index}].logic"
						value="${group.logic }" />
					<input type="hidden" name="groups[${index.index}].field"
						value="${group.field }" />
					<input type="hidden" name="groups[${index.index}].value"
						value='${group.value }' />
				</c:forEach>
				<c:forEach var="site" items="${condition.sites }"
					varStatus="siteIndex">
					<input type="hidden" name="sites[${siteIndex.index}]"
						value="${site }" class="site" />
				</c:forEach>
				<div class="sc_selbox" style="margin-top: 10px;">
					<i></i> <input type="hidden" name="sort" value="${condition.sort }">
				</div>
				<!-- 排序选择 -->
				<ul>
					<li
						<c:if test="${empty condition.sort or condition.sort==0 }">class="in"</c:if>>
						<a href="javascript:changeSortVal(0)" value="0">相关排序</a> <c:if
							test="${empty condition.sort or condition.sort==0 }">
							<i class="icon iconfont fr">&#xe60f;</i>
						</c:if>
					</li>
					<li <c:if test="${condition.sort==1 }">class="in"</c:if>><a
						href="javascript:changeSortVal(1)" value="1">时间排序</a> <c:if
							test="${condition.sort==1 }">
							<i class="icon iconfont fr">&#xe60f;</i>
						</c:if></li>
				</ul>
				<!-- 排序选择 -->
				<!--年份筛选 -->
				<ul>
					<li class="data-time-sort"><span>年份筛选：</span> <input
						type="tel" name="start_y" onkeyup="clearNotInt(this)"
						value="${condition.start_y }"> - <input type="tel"
						name="end_y" onkeyup="clearNotInt(this)"
						value="${condition.end_y }"></li>
					<li><input type="submit" class="ensure" value="确认"></li>
				</ul>
				<!--年份筛选 -->
			</form>
			<!-- 时间筛选表单End -->
			<!-- 本馆已购 -->
			<form action="<cms:getProjectBasePath/>scholar/list" method="get"
				id="gc_form">
				<c:if test="${not empty condition.val }">
					<input type="hidden" name="val" value='${condition.val }' />
				</c:if>
				<c:if test="${not empty condition.journal }">
					<input type="hidden" name="journal" value="${condition.journal }" />
				</c:if>
				<c:if test="${not empty condition.fileType }">
					<input type="hidden" name="fileType" value="${condition.fileType }" />
				</c:if>
				<c:if test="${not empty condition.start_y }">
					<input type="hidden" name="start_y" value="${condition.start_y }" />
				</c:if>
				<c:if test="${not empty condition.end_y }">
					<input type="hidden" name="end_y" value="${condition.end_y }" />
				</c:if>
				<c:if test="${not empty condition.sort }">
					<input type="hidden" name="sort" value="${condition.sort }" />
				</c:if>
				<c:if test="${not empty condition.queryType }">
					<input type="hidden" name="queryType"
						value="${condition.queryType }" />
				</c:if>
				<c:if test="${not empty condition.oaFirst or condition.oaFirst==1 }">
					<input type="hidden" name="oaFirst" value="${condition.oaFirst }" />
				</c:if>
				<c:forEach var="group" items="${condition.groups }"
					varStatus="index">
					<input type="hidden" name="groups[${index.index}].logic"
						value="${group.logic }" />
					<input type="hidden" name="groups[${index.index}].field"
						value="${group.field }" />
					<input type="hidden" name="groups[${index.index}].value"
						value='${group.value }' />
				</c:forEach>
				<ul class="checkbox-con">
					<li><span class="">可多选</span></li>
					<li class="bgborder"><c:forEach var="d" items="${dbs }"
							varStatus="i">
							<span class="collection"> <input name="sites"
								type="checkbox" style="display: none;" class="ipt-hide"
								value="${d.url }"> ${d.dbName }
							</span>

						</c:forEach></li>
					<li><input type="submit" class="ensure" value="确认"></li>
				</ul>
			</form>
			<script type="text/javascript">
		$(function(){
			$('#sort_form input.site').each(function(){
         		var url=$(this).val();
         		$('.collection >input[type="checkbox"]').each(function(){
         			if($(this).val()==url){
         				//$(this).attr('checked',true);
         				$(this).parents().addClass("in");
         			}
         		});
         	});
		});
		</script>
			<!-- 本馆已购end -->
		</div>
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<div class="return-back">
							<a class="return-back" onclick="history.go(-1)"> <i
								class="icon iconfont">&#xe610;</i> <span>返回</span>
							</a>
						</div>
						<!-- <div class="userbox">
						<div class="userSelect">
							<span class="username">Miss.W</span>
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
					</div>
				</header>
				<div class="common-search">
					<dd class="stab" style="display: block;">
						<form method="get" action="<cms:getProjectBasePath/>scholar/list">
							<div class="search-inputwrap">
								<input type="hidden" name="batchId" value="<cms:batchId />" />
								<input type="text" class="input-text" value='${searchKey }'
									id="keyword_text" autocomplete="off" name="val" placeholder="">
								<button type="submit" class="input-submit search"
									id="quick_search_btn" value="检索">
									<i class="icon iconfont">&#xe604;</i>
								</button>
								<input type="button" class="searchCancle" value="取消">
							</div>
							<div class="radio_js" id="lan_panel">
								<div class="ui-checkbox-s">
									<input type="checkbox" name="oaFirst" value="1"
										<c:if test="${condition.oaFirst ==1 }">checked="checked"</c:if>>
									<em>开放资源</em>
								</div>
								<i class="ftnm">勾选即可获取全部开放资源结果</i>
							</div>
						</form>
					</dd>
				</div>
				<div class="item-section">
					<div class="data-sort">
						<c:choose>
							<c:when test="${condition.type==\"quote\" }">
								<ul>
									<li style="height: 1.066667rem; line-height: 1.066667rem"><p
											style="font-size: 14px; color: #f96f00; padding-left: 10px;">施引文献</p></li>
								</ul>
							</c:when>
							<c:when test="${condition.type==\"related\" }">
								<ul>
									<li style="height: 1.066667rem; line-height: 1.066667rem"><p
											style="font-size: 14px; color: #f96f00; padding-left: 10px;">相关文章</p></li>
								</ul>
							</c:when>
							<c:when test="${condition.type==\"version\" }">
								<ul>
									<li style="height: 1.066667rem; line-height: 1.066667rem"><p
											style="font-size: 14px; color: #f96f00; padding-left: 10px;">所有版本</p></li>
								</ul>
							</c:when>
							<c:otherwise>
								<ul class="data-sort-hd">
									<li class="in">
										<p>
											<c:if test="${empty condition.sort or condition.sort==0 }">
										相关排序
										</c:if>
											<c:if test="${condition.sort==1 }">
										时间排序
										</c:if>
											<i class="icon iconfont">&#xe60d;</i>
										</p>
									</li>
									<li>
										<p>
											年份 <i class="icon iconfont">&#xe60d;</i>
										</p>
									</li>
									<!-- <li>
									<p>
										本馆已购
										<i class="icon iconfont">&#xe60d;</i>
									</p>
								</li> -->
								</ul>
							</c:otherwise>
						</c:choose>

					</div>
					<p class="resource-hd">
						已为您找到约<span>${result.count }</span>条结果
					</p>
				</div>
				<div class="adta-list" style="display: table-cell;">
					<ul class="artlist-bd-list arttop">
						<c:forEach items="${result.rows }" var="doc" varStatus="s">
							<li>
								<h2 class="ovh titfavorite">
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
				</div>
				<c:if test="${result.total gt 25 }">
					<div class="paginatin" id="nextPage">
						<span>下一页</span>
					</div>
				</c:if>

				<div class="clear10"></div>
			</div>
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>

	</div>
	<div class="lay_bj_div">
		<div class="lay_bj"></div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
	function changeSortVal(v){
		$('#sort_form input[name="sort"]').val(v);
		$('#sort_form').submit();
	}
	/**
	 * 只能输入正整数
	 */
	function clearNotInt(obj){
	  obj.value = obj.value.replace(/[^\d]/g,"");
	  if(obj.value.length > 4) {
	    obj.value = obj.value.substring(0,4);
	  }
	}
	//加载下一页
	var size = 20,ajaxflag=true;
	$("#nextPage").bind("click",function(){
		var url = window.location.href;
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
						var allSize = '${result.count}';
						if(allSize < (size+20)) {
							$('#nextPage').hide();
							$(".adta-list").append('<div class="pagenav">'+(size+1)+'-'+allSize+'条</div>');
						}else{
							$(".adta-list").append('<div class="pagenav">'+(size+1)+'-'+(size+20)+'条</div>');
							size += 20;
						}
						$(".adta-list").append(data);
						myScroll.refresh();
						ajaxflag=true;
						docdelivery();
					}else{
						ajaxflag=true;
				        that.html("<span>重新加载</span>");
					}
				}
			})
		}
		
	});
	$(".ui-checkbox-s input").bind("click",function(){
		var checkact=$(this).attr("checked");
		if(checkact){
			$(".ftnm").html("取消即可获取更多检索结果")
		}else{
			$(".ftnm").html("勾选即可获取全部开放资源结果");
		}
	})
</script>

	<%-- <!-- 文献互助 -->
<div style="display: none;" id="layer" class="layermbox layermbox0" index="1">
	<div class="laymshade"></div>
	<div class="layermmain">
		<div class="section">
			<div class="layermchild  layermanim">
				<div class="layermcont">
					<p class="deltitle"></p>
					<div class="docdelbox">
						<label>邮箱:<input type="text" id="email" value="${sessionScope.front_member.email }"></label>
					</div>
					<p id="err" style="margin:6px 0 4px 40px">&nbsp;</p>
				</div>
				<div class="layermbtn"><span type="1"><a href="javascript:search()" >提交</a></span></div>
			</div>
		</div>
	</div>
</div> --%>
	<script type="text/javascript">
docdelivery();
function docdelivery(){
$(".docdelivery").click(function(e){
	//e.stopPropagation();
    var title=$(this).attr("d-title");
    var chooesId = $(this).attr("docId");
    layer.open({
        btn: ['提交'],
        content:'<p class="deltitle">'+title+'</p><div class="docdelbox"><label>邮箱:<input type="text" id="email" /></label></div><p id="err" style="margin:6px 0 4px 0px">&nbsp;</p>',
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
          			//$('.delivers').hide();
          		}
          	 });
        	layer.close(index);
        }
    })
  })
}  


download();
function download(){
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
}
 

  </script>
</body>
</html>