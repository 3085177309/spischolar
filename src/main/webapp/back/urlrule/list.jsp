<!-- 站点列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
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
<c:if test="${org.flag=='wdkj' }">
	<table>
		<tr>
			<th colspan="5" class="tl">URL替换地址 <span
				class="thickBtn addschool addDatabase" data-thickcon="modifyUrltick">
					<i></i> 添加
			</span>
			</th>
		</tr>
	</table>
	<table class="tc" id="mytable2">
		<tr>
			<td width="60px"><span>序号</span></td>
			<td><span>资源名称</span></td>
			<td><span>Google Scholar地址 </span></td>
			<td><span>本地地址</span></td>
			<td><span>操作</span></td>
		</tr>
		<c:forEach var="rule" items="${datas.rows }" varStatus="status">
			<tr>
				<td><span>${status.index + 1}</span></td>
				<td><span>${rule.name }</span></td>
				<td><span>${rule.gsUrl }</span></td>
				<td><span>${rule.localUrl }</span></td>
				<td><span> <a
						href="javascript:deleteUrlRule('${rule.name }','<%=basePath %>backend/org/resource/urlrule/del/${orgFlag}/${rule.id}')"
						class="cd00 thickBtn">删除</a>

				</span></td>
			</tr>
		</c:forEach>
	</table>

	<!-- 
	<div class="page" style="padding-right: 20px;">
		<a class="a1">${datas.total}条</a>
		<pg:pager items="${datas.total}" url="backend/org/resource/urlrule/list/${orgFlag }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:prev>
				<a href="${pageUrl}" class="a1 page_action">上一页</a>
			</pg:prev>
			 中间页码开始 
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
-->
</c:if>

<script type="text/javascript">

$('.page a.page_action').bind('click', function(e) {
	var href = $(this).attr('href');
	$('#urlrule_lsit').load(href);
	e.preventDefault();
	return false;
});
function deleteUrlRule(name,url){
//	queren('确定要删除URL规则"'+name+'"吗?',function(){
		
		/* if(window.confirm('你确定要删除吗？')){
			$('#urlrule_lsit').load(url);
	     }else{
	        return false;
	    } */
		
		var index=layer.confirm('你确定要删除吗？', {
		    btn: ['确定','取消']
		}, function(){
			$.ajax({
				url:url,
				async:true,
				success:function(data){
					window.location.href = window.location.href;
					$this.parents("tr").remove();
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
//	});
}
</script>