<!-- 站点列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<table>
	<tr>
		<c:if test="${org.flag=='wdkj' }">
			<th colspan="5" class="tl">本馆已购馆藏数据库 <span onclick="add('-1')"
				class="thickBtn addschool addDatabase" data-thickcon="modifytick">
					<i></i> 添加
			</span>

			</th>
		</c:if>
		<c:if test="${org.flag!='wdkj' }">
			<th colspan="3" class="tl">本馆已购馆藏数据库</th>
		</c:if>
	</tr>
</table>

<table class="tc" id="mytable1">
	<tr>
		<td width="60px"><span>序号</span></td>
		<td><span>资源名称</span></td>
		<td><span>网址</span></td>
		<c:if test="${org.flag=='wdkj' }">
			<td><span>是否显示</span></td>
			<td><span>操作</span></td>
		</c:if>
	</tr>
	<c:forEach var="pd" items="${datas.rows }" varStatus="status">
		<tr>
			<td><span>${status.index + 1 }</span></td>
			<td><span>${pd.dbName }</span></td>
			<td>${pd.url }</td>
			<c:if test="${org.flag=='wdkj' }">
				<td><c:if test="${pd.showDB==1}">是</c:if> <c:if
						test="${pd.showDB==0 }">否</c:if></td>
				<td><span onclick="add('${pd.orderNum}')"
					class="cd00 thickBtn  addDatabase" data-thickcon="modifytick">添加</span>
					<span
					onclick="dat('${pd.orderNum}','${pd.dbName }','${pd.url }','${pd.showDB }','${pd.id}')"
					class="cd00 sm-Btn thickBtn " data-thickcon="modifytickUpdate">编辑</span>
					<a data-dbName="${pd.dbName }"
					data-url="<%=basePath %>backend/org/resource/purchasedb/del/${orgFlag}/${pd.id}?dbType=${pd.dbType}"
					class="cd00 sm-Btn deldatabuyed">删除</a>
				</td>

			</c:if>
		</tr>
	</c:forEach>
</table>

<div class="page" style="padding-right: 20px;">
	<a class="a1">${datas.total}条</a>
	<pg:pager items="${datas.total}" url="" export="cp=pageNumber"
		maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
		<pg:param name="orgFlag" />
		<pg:first>
			<a href="${pageUrl}&orgFlag=${orgFlag}">首页</a>
		</pg:first>
		<pg:prev>
			<a href="${pageUrl}&orgFlag=${orgFlag}" class="a1 page_action">上一页</a>
		</pg:prev>
		<!-- 中间页码开始 -->
		<pg:pages>
			<c:choose>
				<c:when test="${cp eq pageNumber }">
					<span>${pageNumber }</span>
				</c:when>
				<c:otherwise>
					<a href="${pageUrl}&orgFlag=${orgFlag}" class="a1 page_action">${pageNumber}</a>
				</c:otherwise>
			</c:choose>
		</pg:pages>
		<pg:next>
			<a class="a1 page_action" href="${pageUrl}&orgFlag=${orgFlag}">下一页</a>
		</pg:next>
		<pg:last>
			<a href="${pageUrl}&orgFlag=${orgFlag}">末页</a>
		</pg:last>
	</pg:pager>
</div>
<script type="text/javascript">
function add(len){
	$('#orderNum').val(len);
}
function dat(orderNum,dbName,url,showDB,id){
	$('#orderNumUp').val(orderNum);
	$('#dbName').val(dbName);
	$('#url').val(url);
	if(showDB == 1) {
		$('#showDB').attr("checked", true);
	}
	$('#id').val(id);
}

//翻页事件绑定
$('.page a.page_action').bind('click', function(e) {
	var href = $(this).attr('href');
	location.href=href;
//	$('#purchasedb_list').load(href);
//	e.preventDefault();
//	return false;
});
$(".deldatabuyed").bind('click',function(){
	
	var $this=$(this);
	var index=layer.confirm('你确定要删除吗？', {
	    btn: ['确定','取消']
	}, function(){
		$.ajax({
			url:$this.attr("data-url")+"?fresh="+Math.random(),//这里原来为&，不知道改了后对IE兼容是否有影响，以前改过一次
			async:true,
			success:function(data){
				$this.parents("tr").remove();
				window.location.href = window.location.href;
				
				 
			},
			error:function(){
				layer.open('删除失败');
			}
		});
		layer.close(index);
	}, function(){
		layer.close(index);
	    return false;
	});
})
/* function deletePDB(name,url){
	var index=layer.confirm('你确定要删除吗？', {
	    btn: ['确定','取消']
	}, function(){
		$.ajax({
			url:url,
			async:true,
			success:function(data){
				
			}
		});
		//$('#purchasedb_list').load(url);
		layer.close(index);
	}, function(){
		layer.close(index);
	    return false;
	});
} */
</script>
