<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>文献互助统计</title>
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
			<a href="#" class="in">文献互助统计</a>
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
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis" >期刊文章统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/downloadRecord" >文章下载统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord" class="in">文献互助统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/userRecord" >学校用户管理</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="downloadRecordFrom"
									action="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord"
									method="get">
									<div class="pageTopbar clearfix">
										<label class="data-type"> <span class="labt">学校:</span>
											<div class="sc_selbox">
												<i class="inc uv21"></i>
												<%-- <c:if test="${orgFlag == 'all' }">
													<span id="section_lx">全部学校</span>
												</c:if> --%>
												<c:if test="${orgFlag != null }">
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<c:if test="${org.flag == orgFlag }">
															<span id="section_lx">${org.name }</span>
														</c:if>
													</c:forEach>
												</c:if>
												<div class="sc_selopt" style="display: none;">
													<!-- <p class="school" schoolFlag="" schoolId="" onclick='change("all",1)'>全部学校</p> -->
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<p class="school" onclick='change("${org.flag }",1)'>${org.name }</p>
													</c:forEach>
												</div>
											</div> <input type="hidden" id="orgFlag" name="orgFlag"
											value="${orgFlag }">
										</label> <label for="" class="data-type"> <span class="labt">日期:</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose" id="beginTime" name="beginTime"
													value="${beginTime }"
													onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
													onchange="submit()">
											</div> <span class="labm">至</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose" id="endTime" name="endTime"
													value="${endTime }"
													onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d'})"
													onchange="submit()">
											</div>
										</label> 
										<label>
											TOP
											<input type="radio" class="size" name="size" onclick="submit()" value="10" <c:if test="${size==10 }">checked="checked"</c:if>>10
											<input type="radio" class="size" name="size" onclick="submit()" value="20" <c:if test="${size==20 }">checked="checked"</c:if>>20
											<input type="radio" class="size" name="size" onclick="submit()" value="50" <c:if test="${size==50 }">checked="checked"</c:if>>50
										</label>
										<div class="clear"></div>
									</div>
								</form>
							</div>
							<p>${org.name }使用时间:<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>---${registerEndDate }</p>
							<form
								action="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord/add"
								method="post">
								<input type="hidden" name="orgFlag" value="${orgFlag }"> <input
									type="hidden" name="beginTime" value="${beginTime }"> <input
									type="hidden" name="endTime" value="${endTime }">
								<c:if test="${orgFlag != null }">
									<c:forEach items="${orgList }" var="org" varStatus="status">
										<c:if test="${org.flag == orgFlag }">
											<input type="hidden" name="orgName" value="${org.name }">
										</c:if>
									</c:forEach>
								</c:if>
								<table class="data-table">
									<tr>
										<th><span>邮箱</span></th>
										<th width="14%"><span>原始数据</span></th>
										<th><span>已添加数据量</span></th>
										<th><span>添加数据量</span></th>
										<th><span>最新修改时间</span></th>
									</tr>
									<c:forEach var="list" items="${list }">
										<tr>
											<td>${list.email}</td>
											<td>${list.num}</td>
											<td>${list.addNum}</td>
											<td>+<input name="addNum" type="text"></td>
											<input type="hidden" name="email" value="${list.email}">
											<td>2017-6-28</td>
										</tr>
										<%-- <c:forEach	var="timeList" items="${list.timeList }">
										<tr>
											<td>${timeList.times}月</td>
											<td>${list.num}</td>
											<td>${list.num}</td>
											<td>+<input type="text" ></td>
											<td>2017-6-28</td>
										</tr>
									</c:forEach> --%>
									</c:forEach>
								</table>
								<div class="tc">
									<input id="add_button" type="button" value="提交" class="btnEnsure btn" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//切换学校和数据类型
		function change(val,type){
			if(type == 1) {
				$("#orgFlag").val(val);
			} else if(type == 2) {
				$("#type").val(val);
			}
			$('#downloadRecordFrom').submit();
		}
	</script>
	<jsp:include page="../foot.jsp"></jsp:include>
	</body>
	</html>