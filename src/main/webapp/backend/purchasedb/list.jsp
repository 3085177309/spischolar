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
<h3>本馆已购馆藏资源</h3>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="qx_xx1" id="mytable1">
  <tr bgcolor="#f5f5f5">
    <td width="25%"><b>资源名称</b></td>
    <td width="30%"><b>网址</b></td>
    <td width="15%"><b>顺序</b></td>
    <td width="10%"><b>是否显示</b></td>
    <td><b>操作</b></td>
  </tr>
  <c:forEach var="pd" items="${datas.rows }">
  <tr>
    <td><span>${pd.dbName }</span></td>
    <td><span>${pd.url }</span></td>
    <td>${pd.orderNum }</td>
    <td>
    	<c:if test="${pd.showDB==1}">是</c:if>
    	<c:if test="${pd.showDB==0 }">否</c:if>
    </td>
	<td>
		<a href="javascript:deletePDB('${pd.dbName }','<%=basePath %>backend/purchasedb/del/${orgFlag}/${pd.id}')">删除</a>
		<a href="javascript:openEditWin('<%=basePath %>backend/purchasedb/edit/${pd.id}')">编辑</a>
	</td>
  </tr>
  </c:forEach>
</table>
<div class="page">
		<a class="a1">${datas.total}条</a>
		<pg:pager items="${datas.total}" url="backend/purchasedb/list/${orgFlag }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
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
<form method="post" action="<%=basePath %>backend/purchasedb/add" id="purchase_add_form">
	<input type="hidden" name="orgFlag" value="${orgFlag }"/>
    <ul class="xs_fxgl">
    <li><span>资源名称：</span><input name="dbName" type="text"  class="ip_input1"/></li>
    <li><span>网&#12288;&#12288;址：</span><input name="url" type="text" class="ip_input1" /></li>
    <li><span>顺&#12288;&#12288;序：</span><input name="orderNum" type="text" class="ip_input1" /></li>
    <li><span>是否显示：</span><input name="showDB" type="checkbox" checked="checked" value="1"/></li>
    <li><input value="" type="submit" class="ip_button1" /></li>
    </ul>
</form>
<script type="text/javascript">
//表单提交验证
function openEditWin(href){
	$M({
    	title: '编辑馆藏资源信息',
    	iframe: true,
    	padding: 0,
    	top: '50%',
    	lock: true,
    	drag: false,
    	fixed: true,
    	content: href
	});
}
$('#purchase_add_form').bind('submit',function(e){
	var tar=$(this),name=tar.find('input[name="dbName"]').val(),
	url=tar.find('input[name="url"]').val(),
	orderNum=tar.find('input[name="orderNum"]').val();
	if(name==''){
		message('请输入资源名称!',function(){
			tar.find('input[name="dbName"]').focus();
		});
		e.preventDefault();
		return false;
	}
	if(url==''){
		message('请输入网址!',function(){
			tar.find('input[name="url"]').focus();
		});
		e.preventDefault();
		return false;
	}
	if(orderNum==''){
		message('请输入顺序!',function(){
			tar.find('input[name="orderNum"]').focus();
		});
		e.preventDefault();
		return false;
	}
});
//翻页事件绑定
$('.page a.page_action').bind('click', function(e) {
	var href = $(this).attr('href');
	$('#purchasedb_list').load(href);
	e.preventDefault();
	return false;
});
function deletePDB(name,url){
	queren('确定要删除馆藏资源"'+name+'"吗?',function(){
		$('#purchasedb_list').load(url);
	});
}
</script>