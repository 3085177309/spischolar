<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
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
	<title>期刊导航机构列表</title>
	<jsp:include page="../common/meta.jsp" />
</head>

<body>
<div class="header"><a href="#" class="png"></a></div>
<div class="container"> 
  <!--sidebar-->
  
  <c:set scope="request" var="menu" value="jnav"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
  <!--content-->
  <div id="contentH" class="content" >
    	<div class="tianj"></div>
        <div class="tj_con" id="tj_con">
        <form method="get" action="backend/org/jnav/list">
        <table width="100%">
        	<tr bgcolor="#f5f5f5">
        		<td>机构名称:</td>
        		<td width="28%"><input type="text" name="key" value="${key }"/></td>
        		<td colspan="2"><input type="submit" value="查找"/></td>
        	</tr>
        </table>
        </form>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  			<tr bgcolor="#f5f5f5">
    			<td width="33%"><b>学 校</b></td>
    			<td width="33%"><b>使用状态</b></td>
    			<td><b>时 间</b></td>
  			</tr>
  			<c:forEach items="${orgPager.rows }" var="org" varStatus="status">
   			<tr>
   				<td>
   					<c:out value="${org.orgName }" />
   				</td>
				<td>
					<c:if test="${org.status==1 }"><a href="#" class="gm_bnt"></a></c:if>
					<c:if test="${org.status==2 }"><a href="#" class="sy_bnt"></a></c:if>
					<c:if test="${org.status==0 }"><a href="#" class="ty_bnt"></a></c:if>
				</td>
				<td><fmt:formatDate value="${org.startDate }" pattern="yyyy-MM-dd"/>至<fmt:formatDate value="${org.endDate }" pattern="yyyy-MM-dd"/>
					<c:if test="${cms:compareDate(org.endDate) >0 }">
						<font style="background-color:#c9302c;color:#fff;border-color: #ac2925"><b>已经过期</b></font>
					</c:if>
					<c:if test="${cms:compareDate(org.endDate) ==0 }">
						<font style="background-color:#f0ad4e;color:#fff;order-color: #d58512;"><b>即将过期</b></font>
					</c:if>
				</td>
   			</tr>
   			</c:forEach>
	</table>
	<div class="page">
		<a class="a1">${orgPager.total}条</a>
		<pg:pager items="${orgPager.total}" url="backend/org/jnav/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
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