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
	<title>机构列表</title>
	<jsp:include page="../common/meta.jsp" />
	<link href="<%=path%>/resources/plugins/MDialog/MDialog.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/plugins/MDialog/MDialog.min.js"></script>
	
</head>

<body>
<div class="header"><a href="#" class="png"></a></div>
<div class="container"> 
  <!--sidebar-->
  
  <c:set scope="request" var="menu" value="feedback"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
  <!--content-->
  <div id="contentH" class="content" >
    	<div class="tianj"><strong>用户反馈</strong></div>
        <div class="tj_con" id="tj_con">
        <form method="get" action="backend/fb/list">
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
    			<td><b>系统名称</b></td>
    			<td><b>问题</b></td>
    			<td><b>联系方式</b></td>
    			<td><b>提交时间</b></td>
    			<td><b>是否回复</b></td>
    			<td><b>操作</b></td>
  			</tr>
  			<c:forEach items="${data.rows }" var="fb" varStatus="status">
   			<tr>
   				<td>
   					${fb.systemName }
   				</td>
   				<td>${fb.question }</td>
   				<td>${fb.contact }</td>
   				<td><fmt:formatDate value="${fb.questionTime }" pattern="yyyy-MM-dd HH:mm"/></td>
   				<td>
   					<c:if test="${fb.isProcess==1 }">是</c:if>
   					<c:if test="${fb.isProcess==0 }">否</c:if>
   				</td>
				<td>
					<c:if test="${fb.isProcess==0 }">
						<a href="javascript:openAddWin('backend/feedback/answer/${fb.id }')">回复</a>
					</c:if>
					<c:if test="${fb.isProcess==1 }">
						<a href="javascript:openAddWin('backend/feedback/answer/${fb.id }')">修改回复</a>
					</c:if>
				</td>
   			</tr>
   			</c:forEach>
	</table>
	<div class="page">
		<a class="a1">${data.total}条</a>
		<pg:pager items="${data.total}" url="backend/fb/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
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
    	title: '回复',
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