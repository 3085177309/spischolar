<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>用户管理</title>

<jsp:include page="../head.jsp"></jsp:include>

<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
	type="text/javascript"></script>
<div id="content">
	<!-- 左侧栏目：开始 -->
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 21 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 左侧栏目：结束 -->

	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/member/list" class="in">用户管理</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form action="<cms:getProjectBasePath/>/backend/member/list/school"
						id="search_form">
						<label class="common" style="float: right"> <input
							type="text" class="tbSearch keyword ie10" name="key"
							value="${key }" placeholder="请输入用户名、邮箱、用户类型" autocomplete="off">
							<c:if test="${not empty schoolFlag }">
								<input type="hidden" name="schoolFlag" value="${schoolFlag }">
							</c:if> <c:if test="${empty schoolFlag }">
								<input type="hidden" name="schoolFlag" value="all">
							</c:if> <input class="tbBtn" type="submit" value="查询" autocomplete="off">
						</label>
					</form>
					<script>
					$('#search_form').submit(function(){
						var val=$('.keyword').val();
						if(val ==''||val==$('.keyword').attr("placeholder")) {
							$('.keyword').focus();
							return false;
						}
					});	
					</script>

					<div class="clear"></div>
				</div>
				<!-- table表格：开始 -->
				<div class="radius">
					<div class="area">
						<table class="data-table" id="divTable">
							<tr>
								<th width="60px"><span>序号</span></th>
								<th><span>学校</span></th>
								<th><span>注册用户数</span></th>
								<th><span>管理员</span></th>
								<th><span>可校外登录</span></th>
								<th><span>游客数</span></th>
								<th><span>在线人数</span></th>
							</tr>
							<c:forEach items="${pager.rows }" var="list" varStatus="status">
								<tr>
									<td>${status.index+1+ offset }</td>
									<td>${list.school }</td>
									<td><a
										href="<cms:getProjectBasePath/>backend/member/list/school?schoolFlag=${list.flag }"
										class="schoolSearch" org_falg="${list.flag }">${list.regrestCount }</a></td>
									<td>${list.userTypeCount }</td>
									<td>${list.permissionCount }</td>
									<td>${list.touristCount }</td>
									<td>${list.isOnlineCount }</td>
								</tr>
							</c:forEach>

						</table>
					</div>
				</div>
				<!-- 分页页码：开始 -->
				<div class="page" id="page">
					<a class="a1">${pager.total}条</a>
					<pg:pager items="${pager.total}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="order" />
						<pg:param name="key" />
						<pg:param name="schoolFlag" />
						<pg:param name="department" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<pg:page>
							<c:if test="${pager.total/20 gt 5 and (cp gt 3)}">
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
							<c:if
								test="${pager.total/20 gt 5 and (pager.total/20 gt (cp+2))}">
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
				<!-- 分页页码：结束 -->

			</div>
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
	</script>
</body>
</html>
