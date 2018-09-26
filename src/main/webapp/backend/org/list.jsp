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
  
  <c:set scope="request" var="menu" value="org"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
  <!--content-->
  <div id="contentH" class="content" >
    	<div class="tianj"><a href="javascript:void(0)" onclick="openAddWin('backend/org/add')" class="tianj_a"></a></div>
        <div class="tj_con" id="tj_con">
        <form method="get" action="backend/org/list">
        <table width="100%">
        	<tr bgcolor="#f5f5f5">
        		<td>机构名称:</td>
        		<td width="28%"><input type="text" name="key" value="${key }"/></td>
        		<td>IP地址:</td>
        		<td><input type="text" name="ip" value="${ip }"/></td>
        		<td colspan="2"><input type="submit" value="查找"/></td>
        	</tr>
        </table>
        </form>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  			<tr bgcolor="#f5f5f5">
    			<td width="23%"><b>学 校</b></td>
    			<td width="16%"><b>产 品</b></td>
    			<td><b>注册时间</b></td>
    			<td><b>访问首页</b></td>
    			<c:if test="${not empty ip }">
    			<td><b>IP范围</b></td>
    			</c:if>
    			<td><b>操作</b></td>
  			</tr>
  			<c:forEach items="${orgPager.rows }" var="org" varStatus="status">
   			<tr>
   				<td>
   					<a href="javascript:void(0)" style="width:100%" onclick="openEditWin('backend/org/detail/${org.id }');" title="<c:out value="${org.name }" />"><c:out value="${org.name }" /></a>
   				</td>
   				<td>${org.products }</td>
   				<td><fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/></td>
   				<td>
   					<a href="backend/org/home/${org.id }" target="_blank">访问首页</a>
   				</td>
   				<c:if test="${not empty ip }">
   				<td>
   				${cms:findIpRanges(org.ipRanges,ip) }
   				</td>
   				</c:if>
				<td>
					<a href="javascript:void(0)" onclick="openEditWin('backend/org/detail/${org.id }');" >[详情]</a>
					<a href="backend/person/list/${org.id }"  >[人员管理]</a>
					<a href="javascript:void(0)" onclick="deleteOrg('${org.name }','backend/org/delete/${org.id }')">[删除]</a>
				</td>
   			</tr>
   			</c:forEach>
	</table>
	<div class="page">
		<a class="a1">${orgPager.total}条</a>
		<pg:pager items="${orgPager.total}" url="backend/org/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:param name="key" />
			<pg:param name="ip" />
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
    	title: '添加机构',
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
    	title: '编辑机构信息',
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