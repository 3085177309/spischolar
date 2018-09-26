<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>公告</title>
	<jsp:include page="../common/meta.jsp" />
	<link href="<%=path%>/resources/plugins/MDialog/MDialog.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/plugins/MDialog/MDialog.min.js"></script>
	
</head>

<body>
<div class="header"><a href="#" class="png"></a></div>
<div class="container"> 
  <!--sidebar-->
  
  <c:set scope="request" var="menu" value="news"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
  <!--content-->
  <div id="contentH" class="content" >
    	<div class="tianj"><a href="javascript:void(0)" onclick="openAddWin('backend/news/add')" class="tianj_a"></a></div>
        <div class="tj_con" id="tj_con">
        <form method="get" action="backend/news/list">
        <table width="100%">
        	<tr bgcolor="#f5f5f5">
        		<td>关键词:</td>
        		<td width="28%"><input type="text" name="key" value="${key }"/></td>
        		<td colspan="2"><input type="submit" value="查找"/></td>
        	</tr>
        </table>
        </form>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  			<tr bgcolor="#f5f5f5">
    			<td width="23%"><b>标题</b></td>
    			<td width="10%"><b>查看次数</b></td>
    			<td width="10%"><b>点赞次数</b></td>
    			<td><b>发布时间</b></td>
    			<td><b>是否显示</b></td>
    			<td><b>操作</b></td>
  			</tr>
  			<c:forEach items="${data.rows }" var="news" varStatus="status">
   			<tr>
   				<td>
   					${news.title }
   				</td>
   				<td>${news.times }</td>
   				<td>${news.praise }</td>
   				<td><fmt:formatDate value="${news.addTime }" pattern="yyyy-MM-dd HH:mm"/></td>
   				<td>
   					<c:if test="${news.isShow==2 }">显示并轮播</c:if>
   					<c:if test="${news.isShow==1 }">仅显示</c:if>
   					<c:if test="${news.isShow==0 }">不显示</c:if>
   				</td>
				<td>
					<a href="javascript:openEditWin('backend/news/edit/${news.id}')">编辑</a>
					<c:if test="${news.isShow==0 }">
						<a href="backend/news/varify/${news.id }/1">仅显示</a>
						<a href="backend/news/varify/${news.id }/2">显示并轮播</a>
					</c:if>
					<c:if test="${news.isShow==1 }">
						<a href="backend/news/varify/${news.id }/2">显示并轮播</a>
						<a href="backend/news/varify/${news.id }/0">取消显示</a>
					</c:if>
					<c:if test="${news.isShow==2 }">
						<a href="backend/news/varify/${news.id }/1">仅显示</a>
						<a href="backend/news/varify/${news.id }/0">取消显示</a>
					</c:if>
					<a href="backend/news/delete/${news.id}">删除</a>
				</td>
   			</tr>
   			</c:forEach>
	</table>
	<div class="page">
		<a class="a1">${data.total}条</a>
		<pg:pager items="${data.total}" url="backend/news/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:param name="key" />
			<pg:prev>
				<a href="${pageUrl}" class="a1">上一页</a>
			</pg:prev>
			<!-- 中间页码开始 -->
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
			<pg:next>
				<a class="a1" href="${pageUrl}">下一页</a>
			</pg:next>
	  </pg:pager>
    </div>
   </div>
  </div>
</div>
<script type="text/javascript">
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
function openAddWin(href){
	$M({
    	title: '添加公告',
    	iframe: true,
    	padding: 0,
    	top: '50%',
    	lock: true,
    	drag: false,
    	fixed: true,
    	content: href
	});
}
function openEditWin(href){
	$M({
    	title: '编辑公告',
    	iframe: true,
    	padding: 0,
    	top: '50%',
    	lock: true,
    	drag: false,
    	fixed: true,
    	content: href
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