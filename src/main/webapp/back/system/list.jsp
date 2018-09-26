<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>内容发布</title>
<jsp:include page="../head.jsp"></jsp:include>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"<c:if test="${xtgl.id == 25 }">class="in"</c:if>">${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统管理</a>>
			<a href="#" class="in">内容发布</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<label class="data-type"> <span class="labt">栏目:</span>

						<div class="sc_selbox">
							<i class="inc uv21"></i> <span id="section_lx"> <c:if
									test="${empty type }">全部</c:if> <c:if test="${type == 1 }">新手指南</c:if>
								<c:if test="${type == 2 }">学科体系</c:if> <c:if
									test="${type == 3 }">评价体系</c:if> <c:if test="${type == 4 }">系统日志</c:if>
								<c:if test="${type == 5 }">公告</c:if> <c:if test="${type == 6 }">使用手册</c:if>
							</span>
							<div class="sc_selopt" style="display: none;">
								<p onclick='change("")'>全部</p>
								<p onclick='change("1")'>新手指南</p>
								<p onclick='change("2")'>学科体系</p>
								<p onclick='change("3")'>评价体系</p>
								<p onclick='change("4")'>系统日志</p>
								<p onclick='change("5")'>公告</p>
								<p onclick='change("6")'>使用手册</p>
							</div>
						</div>
					</label> <label style="margin-top: 6px; margin-top: 0\9; *margin-top: 8px">
						<span class="labt"> <span
							class="thickBtn addschool addDatabase"> <i></i> 添加
						</span>
					</span>
					</label>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<table class="data-table area">
						<tr>
							<th><span>序号</span></th>
							<th><span>标题</span></th>
							<th><span>栏目</span></th>
							<th><span>阅读数</span></th>
							<th><span>点赞数</span></th>
							<th><span>发布时间</span></th>
							<th><span>发布人</span></th>
							<th width="12%"><span>操作</span></th>
							<th><span>状态</span></th>
						</tr>
						<c:forEach items="${data.rows }" var="news" varStatus="status">
							<tr>
								<td>${status.index+1 }</td>
								<td>${news.title }</td>
								<td><c:if test="${news.type == 1 }">新手指南</c:if> <c:if
										test="${news.type == 2 }">学科体系</c:if> <c:if
										test="${news.type == 3 }">评价体系</c:if> <c:if
										test="${news.type == 4 }">系统日志</c:if> <c:if
										test="${news.type == 5 }">公告</c:if> <c:if
										test="${news.type == 6 }">使用手册</c:if></td>
								<td>${news.times }</td>
								<td>${news.praise }</td>
								<td><fmt:formatDate value="${news.addTime }"
										pattern="yyyy-MM-dd HH:mm" /></td>
								<td>${news.publishers }</td>
								<td><a class="cd00 edit thickBtn" value="${news.id}"
									href="#">编辑</a> <!-- 	
								<c:if test="${news.isShow==0 }">
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/1">仅显示</a>
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/2">显示并轮播</a>
								</c:if>
								<c:if test="${news.isShow==1 }">
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/2">显示并轮播</a>
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/0">取消显示</a>
								</c:if>
								<c:if test="${news.isShow==2 }">
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/1">仅显示</a>
									<a href="<cms:getProjectBasePath/>backend/system/list/varify/${news.id }/0">取消显示</a>
								</c:if>
							--> <a class="cd00 delete thickBtn" value="${news.id}">删除</a></td>
								<td><c:if test="${news.isShow==2 }">显示并轮播</c:if> <c:if
										test="${news.isShow==1 }">仅显示</c:if> <c:if
										test="${news.isShow==0 }">不显示</c:if></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="page" style="margin-right: 20px;">
					<a class="a1">${data.total}条</a>
					<pg:pager items="${data.total}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="type" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${data.total/20 gt 5 and (cp gt 3)}">
							...
						</c:if>
						</pg:page>
						<pg:pages>
							<c:choose>
								<c:when test="${cp eq pageNumber }">
									<span>${pageNumber }</span>
								</c:when>
								<c:otherwise>
									<a href="${pageUrl}" class="a1">${pageNumber}</a>
								</c:otherwise>
							</c:choose>
						</pg:pages>
						<pg:page>
							<c:if test="${data.total/20 gt 5 and (data.total/20 gt (cp+2))}">
							...
						</c:if>
						</pg:page>
						<pg:next>
							<a class="a1" href="${pageUrl}">下一页</a>
						</pg:next>
						<pg:last>
							<a href="${pageUrl}">末页</a>
						</pg:last>
						<input type="text" onkeyup="clearNotInt(this)" id="go"
							style="width: 50px;" size="5">
						<pg:last>
							<a class="a1" onclick="go('${pageUrl}')">GO</a>
						</pg:last>
					</pg:pager>
				</div>

			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
		<script type="text/javascript">
	/**
	 * 只能输入正整数
	 */
	function clearNotInt(obj){
	  obj.value = obj.value.replace(/[^\d]/g,"");
	}
	//跳转翻页
	function go(url){
		var page = $('#go').val();
		var offset = (page -1)*20;
		if(page == "") {
			return false;
		}
		var arr = new Array();
		arr = url.split("offset=");
		
		if(page*20-20 > arr[1]) {
			alert("超出页码范围！");
			return false;
		}
		if(page<1) {
			alert("超出页码范围！");
			return false;
		}
		url = arr[0]+"offset="+offset;
		window.location.href=url; 
	}
	//删除用户
	$('.delete').click(function(){
		var that=$(this)
		var index=layer.confirm('你确定要删除此内容吗？', {
		    btn: ['确定','取消'] //按钮
		}, function(){
			var id = that.attr("value");
			$.get('<cms:getProjectBasePath/>backend/system/list/delete/'+id,function(data){
				location.reload();
			});
			layer.close(index);
		}, function(){
			layer.close(index);
		    return false;
		});
	});
	
	function change(type){
		window.location.href = '<cms:getProjectBasePath/>backend/system/list?type=' + type;
	}
	$('.addDatabase').click(function(){
		window.location.href = '<cms:getProjectBasePath/>backend/system/list/add';
	});
	$('.edit').click(function(){
		var newsId =  $(this).attr("value");
		window.location.href = '<cms:getProjectBasePath/>backend/system/list/edit/'+newsId;
	})
	
function queren(text, callback) {
    $("#spanmessage").text(text);
    $("#message").dialog({
        title: "学术资源管理后台，提示您",
        modal: true,
        resizable: false,
        buttons: {
            "否": function() {
                $(this).dialog("close");
            },
            "是": function() {
                callback.call();//方法回调
                $(this).dialog("close");
            }
        }
    });
}

function deleteOrg(org,href){
	queren("确定要删除机构'"+org+"'吗?",function(){
		window.location.href=href;
	});
}
$(function(){
	var boardDiv = "<div id='message' style='display:none;'><span id='spanmessage'></span></div>";
	$(document.body).append(boardDiv);	 
});
</script>
		</body>
		</html>