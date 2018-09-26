<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>期刊文章统计</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 41 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统管理</a>>
			<a href="#" class="in">期刊文章统计</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic">数据自动添加</a> 
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand" class="in">数据手动添加</a> 
					</div>
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand">访问流量</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis" class="in">期刊文章统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/downloadRecord">文章下载统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord">文献互助统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/userRecord" >学校用户管理</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="contentAnalysisFrom"
									action="<cms:getProjectBasePath/>backend/system/contentAnalysis"
									method="get">
									<div class="pageTopbar clearfix">
										<label class="data-type"> <span class="labt">学校:</span>
											<input type="hidden" id="orgFlag" name="browseHandId" value="${browseHandId }">
											<div class="sc_selbox">
												<i class="inc uv21"></i>
												<c:if test="${orgFlag != null }">
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<c:if test="${org.flag == orgFlag }">
															<span id="section_lx">${org.name }</span>
														</c:if>
													</c:forEach>
												</c:if>
											</div> 
											<input type="hidden" disabled="disabled" id="orgFlag" name="orgFlag" value="${orgFlag }">
										</label> <label for="" class="data-type"> <span class="labt">日期:</span>
											<div class="datebox">
												<i class="inc uv13"></i> 
													 <input type="text"
													class="tbSearch datechoose" id="beginTime" name="beginTime"
													value="${beginTime }"
													onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
													onchange="submit()">
											</div> <span class="labm">至</span>
											<div class="datebox">
												<i class="inc uv13"></i> 
													<i class="inc uv13"></i> 
														<input type="text"
													class="tbSearch datechoose" id="endTime" name="endTime"
													value="${endTime }"
													onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d'})"
													onchange="submit()">
											</div>
										</label> <label class="data-type"> <span class="labt">数据类型:</span>
											<div class="sc_selbox">
												<i class="inc uv21"></i> 
													<span id="section_xx">
														<c:if test="${journalType == 1 }">浏览期刊</c:if>
														<c:if test="${journalType == 2 }">检索期刊</c:if>
														<c:if test="${journalType == 3 }">检索文章</c:if>
														<c:if test="${journalType == 4 }">浏览学科</c:if>
														<c:if test="${journalType == 5 }">浏览学科体系</c:if>
													</span>
												<div class="sc_selopt" style="display: none;">
													<p class="journalType" journalType="2" onclick='change(2,2)'>检索期刊</p>
													<p class="journalType" journalType="3" onclick='change(3,2)'>检索文章</p>
													<p class="journalType" journalType="1" onclick='change(1,2)'>浏览期刊</p>
													<p class="journalType" journalType="4" onclick='change(4,2)'>浏览学科</p>
													<p class="journalType" journalType="5" onclick='change(5,2)'>浏览学科体系</p>
												</div>
											</div> <input type="hidden" id="journalType" name="journalType" value="${journalType }">
										</label> 
										<c:if test="${journalType != 5 }">
											<c:if test="${type == 0 }">
												<label>
													<span class="thickBtn" data-thickcon="addKeyword" style="margin-top: 7px;*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
													<i></i>添加</span>
												</label>
											</c:if>
											<label>
												TOP
												<input type="radio" class="size" name="size" onclick="submit()" value="10" <c:if test="${size==10 }">checked="checked"</c:if>>10
												<input type="radio" class="size" name="size" onclick="submit()" value="20" <c:if test="${size==20 }">checked="checked"</c:if>>20
												<input type="radio" class="size" name="size" onclick="submit()" value="50" <c:if test="${size==50 }">checked="checked"</c:if>>50
											</label>
										</c:if>
										<div class="clear"></div>
									</div>
								</form>
							</div>
							<p>${org.name }使用时间:<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>---${registerEndDate }</p>
							<form id="addBrowseHand"
								action="<cms:getProjectBasePath/>backend/system/contentAnalysis/add"
								method="post">
								<input type="hidden" name="browseHandId" value="${browseHandId }">
								<input type="hidden" name="journalType" value="${journalType }">
								<input type="hidden" name="orgFlag" value="${orgFlag }">
							<%-- 	<input type="hidden" name="beginTime" value="${beginTime }"> 
								<input type="hidden" name="endTime" value="${endTime }"> --%>
								<table class="data-table">
									<tr>
										<th><span>关键词</span></th>
										<th width="14%"><span>原始数据</span></th>
										<th><span>已添加数据量</span></th>
										<th><span>添加数据量</span></th>
										<th><span>最新修改时间</span></th>
										<th><span>操作人</span></th>
									</tr>
									<c:forEach var="list" items="${list }">
										<tr>
											<td>${list.keyword}</td>
											<td>${list.num}</td>
											<td>${list.addNum}</td>
											<c:if test="${list.keyword == '其他'}">
												<td></td>
											</c:if>
											<c:if test="${list.keyword != '其他'}">
												<td>+<input name="addNum" type="text"></td>
											</c:if>
											<input type="hidden" name="keyword" value="${list.keyword}">
											<input type="hidden" name="url" value="${list.url}">
											<td><fmt:formatDate value="${list.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td>${list.username}</td>
										</tr>
									</c:forEach>
								</table>
								<c:if test="${type == 0 }">
									<div class="tc">
										<input id="add_button" type="button" value="提交" class="btnEnsure btn" />
									</div>
								</c:if>
							</form>
							<br/><br/>
							<p><b>本次</b>数据添加已绑定数据</p>
							<table>
								<tr><td>关键词</td><td>时间段</td><td>数据量</td><td>操作时间</td><td>操作人</td></tr>
								<c:forEach items="${data.rows }" var="log">
									<c:if test="${log.browseHandId == browseHandId }">
										<tr>
											<td>${log.keyword }</td>
											<td>${log.beginTime }---${log.endTime }</td>
											<td>${log.num }</td>
											<td><fmt:formatDate value="${log.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td>${log.username }</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
							<br><br><br>
							<p><b>本校</b>所有数据添加日志</p>
							<table>
								<tr><td>关键词</td><td>时间段</td><td>数据量</td><td>操作时间</td><td>操作人</td></tr>
								<c:forEach items="${data.rows }" var="log">
									<tr>
										<td>${log.keyword }</td>
										<td>${log.beginTime }---${log.endTime }</td>
										<td>${log.num }</td>
										<td><fmt:formatDate value="${log.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${log.username }</td>
									</tr>
								</c:forEach>
							</table>
							<div class="page" style="margin-right: 20px;">
								<a class="a1">${data.total}条</a>
								<pg:pager items="${data.total}" url="" export="cp=pageNumber"
									maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
									<pg:param name="type" />
									<pg:param name="orgFlag" />
									<pg:param name="beginTime" />
									<pg:param name="endTime" />
									<pg:param name="journalType" />
									<pg:param name="browseHandId" />
									<pg:first>
										<a href="${pageUrl}">首页</a>
									</pg:first>
									<pg:prev>
										<a href="${pageUrl}" class="a1">上一页</a>
									</pg:prev>
									<!-- 中间页码开始 -->
									<pg:page>
										<c:if test="${data.total/20 gt 5 and (cp gt 3)}">
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
										<c:if test="${data.total/20 gt 5 and (data.total/20 gt (cp+2))}">
										...
									</c:if>
									</pg:page>
									<pg:next>
										<a class="a1" href="${pageUrl}">下一页</a>
									</pg:next>
									<pg:last>
										<a href="${pageUrl}">末页</a>
									</pg:last>
									<%-- <input type="text" onkeyup="clearNotInt(this)" id="go"
										style="width: 50px;" size="5">
									<pg:last>
										<a class="a1" onclick="go('${pageUrl}')">GO</a>
									</pg:last> --%>
								</pg:pager>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="addKeyword" class="export addKeyword" data-tit="新加关键词">
		<form id="addKeywordForm" method="post"
			action="<cms:getProjectBasePath/>backend/system/contentAnalysis/add">
			<input type="hidden" name="journalType" value="${journalType }">
			<input type="hidden" name="browseHandId" value="${browseHandId }">
			<input type="hidden" name="orgFlag" value="${orgFlag }"> <input
				type="hidden" name="beginTime" value="${beginTime }"> <input
				type="hidden" name="endTime" value="${endTime }">
			<table>
				<tr><td>关键词</td><td><input type="text" name="keyword"></td></tr>
				<tr><td>url</td><td><input type="text" name="url"></td></tr>
				<tr><td>数量</td><td><input type="text" name="addNum"></td></tr>
			</table>
			<div class="tc">
				<input id="addKeyword_button" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		//切换学校和数据类型
		function change(val,type){
			if(type == 1) {
				$("#orgFlag").val(val);
			} else if(type == 2) {
				$("#journalType").val(val);
			}
			$('#contentAnalysisFrom').submit();
		}
		$('#add_button').click(function(){
			var param = $("#addBrowseHand").serialize();  
			$.ajax({  
		    	url : "<cms:getProjectBasePath/>backend/system/contentAnalysis/add",  
		    	type : "post",  
		    	dataType : "json",
		    	data: param,  
		    	success : function(data) { 
		    		layer.alert(data.message,function(){
		    				location.reload();
					});
		    	}
		   });
		});
		$('#addKeyword_button').click(function(){
			var param = $("#addKeywordForm").serialize(); 
			var keyword = $("#addKeywordForm input[name=keyword]").val();
			var url = $("#addKeywordForm input[name=url]").val();
			var addNum = $("#addKeywordForm input[name=addNum]").val();
			if(keyword == null || keyword == '' || url == null || url == '' || addNum == null || addNum == '') {
				layer.alert("请填写关键词、url和数量！");
				return false;
			}
			$.ajax({  
		    	url : "<cms:getProjectBasePath/>backend/system/contentAnalysis/add",  
		    	type : "post",  
		    	dataType : "json",
		    	data: param,  
		    	success : function(data) { 
		    		layer.alert(data.message,function(){
		    				 location.reload(); 
					});
		    	}
		   });
		});
	</script>
	<jsp:include page="../foot.jsp"></jsp:include>
	</body>
	</html>