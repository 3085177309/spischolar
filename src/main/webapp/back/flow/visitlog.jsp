<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>访问报告</title>
<jsp:include page="../head.jsp" flush="false"></jsp:include>

<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv00"></span> 流量分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.llfx }" var="llfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${llfx.url}"
					<c:if test="${llfx.id == 31 }">class="in"</c:if>>${llfx.columnName }</a></li>
			</c:forEach>
		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<!--		<div class="conTab">
			 <a href="">基本信息<span class="inc uv01"></span></a>
			<a href="" class="in">访客来源<span class="inc uv01"></span></a>
			<a href="">新老访客<span class="inc uv01"></span></a>
			<a href="">用户管理<span class="inc uv01"></span></a> 
		</div>-->
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">浏览分析</a>>
			<a href="#" class="in">访问报告</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form action="<cms:getProjectBasePath/>backend/flow/visitlog"
						id="visitFrom" method="get">
						<label class="data-type">
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:if test="${empty remark }">
									<span id="section_lx">全部异常原因</span>
								</c:if>
								<c:if test="${not empty remark }">
									<span id="section_lx">${remark }</span>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p class="remark" value="">全部异常原因</p>
									<p class="remark" value="请求超时">请求超时</p>
									<p class="remark" value="没有发布文章">没有发布文章</p>
									<p class="remark" value="其他">其他</p>
								</div>
							</div> <input type="hidden" id="remark" name="remark"
							value="${remark }">
						</label> <label class="common"> <input type="text"
							class="tbSearch keyword ie10" name="val" value="${val }"
							placeholder="请输入刊名检索..."> <input class="tbBtn"
							type="submit" value="查询">
						</label>
					</form>
					<script type="text/javascript">
						$('.remark').click(function(){
							var remark = $(this).attr("value");
							$('#remark').val(remark);
							$('#visitFrom').submit();
						})
						//（关键字查询）
						/* $('#visitFrom').submit(function(){
							var val=$('.keyword').val();
							if(val ==''||val==$('.keyword').attr("placeholder")) {
								$('.keyword').focus();
								return false;
							}
						}); */
					</script>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="history">

						<table class="tc data-table pd0">
							<tr>
								<th width="80px"><span>序号</span></th>
								<th><span>刊名</span></th>
								<th width="120px"><span>来源</span></th>
								<th width="160px"><span>时间</span></th>
								<th><span>异常</span></th>
								<th><span>异常原因</span></th>
							</tr>
							<c:forEach items="${list }" var="list" varStatus="status">
								<tr>
									<td><span>${status.index+1 +offset }</span></td>
									<td><span><a href="${list.url }" target="_blank">${list.name }</a></span></td>
									<td><span>${list.source }</span></td>
									<td><span><fmt:formatDate value="${list.time }"
												pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
									<td><span>${list.info }</span></td>
									<td><span>${list.remark }</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="page" id="page">
					<a class="a1">${count }条</a>
					<pg:pager items="${count }" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="val" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${count/20 gt 5 and (cp gt 3)}">
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
							<c:if test="${count/20 gt 5 and (count/20 gt (cp+2))}">
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
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
</div>


</body>
</html>
