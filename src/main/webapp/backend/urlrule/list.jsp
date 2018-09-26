<!-- 站点列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<h3>Url替换地址</h3>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="qx_xx1" id="mytable2">
  <tr bgcolor="#f5f5f5">
    <td width="30%"><b>资源名称</b></td>
    <td width="35%"><b>Google Scholar地址</b></td>
    <td width="15%"><b>本地地址</b></td>
    <td colspan="1"><b>操作</b></td>
  </tr>
  <c:forEach var="rule" items="${datas.rows }">
  <tr>
  	<td><span>${rule.name }</span></td>
    <td><span>${rule.gsUrl }</span></td>
    <td><span>${rule.localUrl }</span></td>
	<td><a href="javascript:deleteUrlRule('${rule.name }','<%=basePath %>backend/urlrule/del/${orgFlag}/${rule.id}')">删除</a></td>
  </tr>
  </c:forEach>
</table>
<div class="page">
		<a class="a1">${datas.total}条</a>
		<pg:pager items="${datas.total}" url="backend/urlrule/list/${orgFlag }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:prev>
				<a href="${pageUrl}" class="a1 page_action">上一页</a>
			</pg:prev>
			<!-- 中间页码开始 -->
			<pg:pages>
				<c:choose>
					<c:when test="${cp eq pageNumber }">
						 <span>${pageNumber }</span>
					</c:when>
					<c:otherwise>
						<a href="${pageUrl}" class="a1 page_action">${pageNumber}</a>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<a class="a1 page_action" href="${pageUrl}">下一页</a>
			</pg:next>
	  </pg:pager>
    </div>
<form method="post" action="<%=basePath %>backend/urlrule/add" id="urlrule_add_form">
	<input type="hidden" name="orgFlag" value="${orgFlag }" />
    <ul class="xs_fxgl">
    <li><span>资源名称：</span><input name="name" type="text"  class="ip_input1"/></li>
    <li><span>谷歌地址：</span><input name="gsUrl" type="text" class="ip_input1" /></li>
    <li><span>本地地址：</span><input name="localUrl" type="text" class="ip_input1" /></li>
    <li><input value="" type="submit" class="ip_button1" /></li>
    </ul>
</form>
<script type="text/javascript">
$('#urlrule_add_form').bind('submit',function(e){
	var tar=$(this),name=tar.find('input[name="name"]').val(),
	gsUrl=tar.find('input[name="gsUrl"]').val(),
	localUrl=tar.find('input[name="localUrl"]').val();
	if(name==''){
		message('请输入资源名称!',function(){
			tar.find('input[name="name"]').focus();
		});
		e.preventDefault();
		return false;
	}
	if(gsUrl==''){
		message('请输入谷歌地址!',function(){
			tar.find('input[name="gsUrl"]').focus();
		});
		e.preventDefault();
		return false;
	}
	if(localUrl==''){
		message('请输入本地地址!',function(){
			tar.find('input[name="localUrl"]').focus();
		});
		e.preventDefault();
		return false;
	}
});
$('.page a.page_action').bind('click', function(e) {
	var href = $(this).attr('href');
	$('#urlrule_lsit').load(href);
	e.preventDefault();
	return false;
});
function deleteUrlRule(name,url){
	queren('确定要删除URL规则"'+name+'"吗?',function(){
		$('#urlrule_lsit').load(url);
	});
}
</script>