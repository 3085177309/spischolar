<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:useBean id="now" class="java.util.Date" />
<!-- 当前时间 -->
<title>学校信息</title>

<jsp:include page="../head.jsp"></jsp:include>

<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 19 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<!-- 	<div class="conTab">
			
		</div> -->
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list" class="in">基本信息</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<label class="data-type"> <span class="labt">使用状态:</span>
						<div class="sc_selbox sc_selboxhalf">
							<i class="inc uv21"></i> <span id="section_lx">${statusName}</span>
							<div class="sc_selopt" style="display: none;">
								<p onclick='change(5)'>全部</p>
								<p onclick='change(1)'>购买</p>
								<p onclick='change(2)'>试用</p>
								<p onclick='change(0)'>停用</p>
								<p onclick='change(3)'>过期</p>
							</div>
						</div>
					</label>
					<!-- 查询 -->
					<form name="search_form" id="search_form" method="get" action="">
						<input type="hidden" name="status" value="${status }">
					</form>
					<form id="school_form" name="search_form" method="get" action="">
						<label class="common"> <input type="text"
							class="tbSearch keyword" name="key" value="${key }"
							placeholder="请输入学校名称或IP"> <input class="tbBtn"
							type="submit" value="查询" />
						</label>
					</form>
					<label class="common"> <a class="tbBtn ie10"
						href="<cms:getProjectBasePath/>backend/org/list/add"> 添加学校 <!-- <i></i>
							<input type="button" class="tbBtn" style="width: 80px;" value="添加学校"> -->
					</a>
					</label>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="area">
						<table class="tc">
							<tr>
								<th width="40px"><span>序号</span></th>
								<th><span>学校</span></th>
								<th><span>产品</span></th>
								<th width="60px"><span>状态</span></th>
								<th><span>馆藏资源配置</span></th>
								<th><span>注册时间</span></th>
								<th><span>剩余有效期</span></th>
								<th width="240px"><span>操作</span></th>
							</tr>
							<c:forEach items="${orgPager.rows }" var="org" varStatus="status">
								<c:forEach var="pro" items="${org.productList}"
									varStatus="index">
									<tr>
										<c:if test="${index.index ==0 }">
											<td rowspan="${fn:length(org.productList) }"><span>${status.index+1+offset}</span></td>
											<td rowspan="${fn:length(org.productList) }"><span><a
													href="<cms:getProjectBasePath/>backend/org/list/detail/${org.id }">${org.name }</a></span></td>
										</c:if>
										<td><span>${pro.productName }</span></td>
										<td><c:if test="${pro.status eq 1}">
												<span class="c090">购买</span>
											</c:if> <c:if test="${pro.status eq 2}">
												<span class="cf90">试用</span>
											</c:if> <c:if test="${pro.status eq 0}">
												<span class="cf90" style="color: red">停用</span>
											</c:if> <c:if test="${pro.status eq 3}">
												<span class="cf90" style="color: red">过期</span>
											</c:if></td>
										<td><span> <c:if test="${pro.productId ==1 }">馆藏期刊</c:if>
												<c:if test="${pro.productId ==2 }">馆藏数据库</c:if> <%-- <c:if test="${pro.productId ==4 }">CRS核心论文库</c:if> --%>
										</span></td>

										<c:if test="${index.index ==0 }">
											<td rowspan="${fn:length(org.productList) }"><span><fmt:formatDate
														value="${org.registerDate }" pattern="yyyy-MM-dd" /></span></td>
										</c:if>
										<c:if test="${not empty pro.endDate }">
											<c:set var="interval"
												value="${(pro.endDate.time - now.time)/1000/60/60/24+1}" />
										</c:if>
										<c:if test="${interval > 0}">
											<td><span><fmt:formatNumber value="${interval}"
														pattern="#0" /> 天</span></td>
										</c:if>
										<c:if test="${interval <= 0}">
											<td><span>0 天</span></td>
										</c:if>
										<c:if test="${index.index ==0 }">
											<td rowspan="${fn:length(org.productList) }"><span><a
													href="<cms:getProjectBasePath/>backend/org/list/home/${org.id }"
													target="_blank" class="btn defaultlink">访问首页</a></span> <span><a
													href="<cms:getProjectBasePath/>backend/org/list/backendHome/${org.id }"
													target="_blank" class="btn defaultlink">访问后台</a></span></td>
										</c:if>
									</tr>
								</c:forEach>
							</c:forEach>

						</table>
					</div>
				</div>
				<div class="page" id="page">
					<a class="a1">${orgPager.total}条</a>
					<pg:pager items="${orgPager.total}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="key" />
						<pg:param name="status" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${orgPager.total/20 gt 5 and (cp gt 3)}">
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
								test="${orgPager.total/20 gt 5 and (orgPager.total/20 gt (cp+2))}">
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
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>
<script type="text/javascript">
function change(type){
	$('input[name="status"]').val(type);
	$('#search_form').submit();
}
//（关键字查询）
$('#school_form').submit(function(){
	var val=$('.keyword').val();
	if(val ==''||val==$('.keyword').attr("placeholder")) {
		$('.keyword').focus();
		return false;
	}
});

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
