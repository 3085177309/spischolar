<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>数据手动添加-访问流量</title>

<jsp:include page="../head.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
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
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand" class="in">数据手动添加</a>
		</div>

		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic">数据自动添加</a> 
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand" class="in">数据手动添加</a> 
					</div>
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand" class="in">访问流量</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis">期刊文章统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/downloadRecord">文章下载统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord">文献互助统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/userRecord">学校用户管理</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="browseHandFrom"
									action="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand"
									method="get">
									<div class="pageTopbar clearfix">
										<label class="data-type"> <span class="labt">学校:</span>
											<div class="sc_selbox">
												<i class="inc uv21"></i>
												<span id="section_lx">${orgName }</span>
												<%-- <c:if test="${orgFlag != null }">
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<c:if test="${org.flag == orgFlag }">
															<span id="section_lx">${org.name }</span>
														</c:if>
													</c:forEach>
												</c:if> --%>
												<div class="sc_selopt" style="display: none;">
													<p class="school" onclick='change("")'>全部学校</p>
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<p class="school" onclick='change("${org.flag }")'>${org.name }</p>
													</c:forEach>
												</div>
											</div> 
											<input type="hidden" id="orgFlag" name="orgFlag" value="${orgFlag }">
										</label> 
										<label for="" class="data-type"> <span class="labt">日期:</span>
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
										<div class="clear"></div>
									</div>
								</form>
							</div>
							<c:if test="${orgFlag != null }">
							<p>${org.name }使用时间:<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>---${registerEndDate }</p>
							</c:if>
							<form action="" id="addBrowseHand">
								<table>
									<tr>
										<td>学校：</td><td>${orgName }</td>
									</tr> 
									<tr>
										<td>原始日均PV/原始总PV量</td><td>${map.pv }/${map.allPv }</td>
										<input type="hidden" id="addOrgName" class="orgName"name="orgName" value="${orgName }"> 
										<input type="hidden" id="addOrgFlag" class="orgFlag" name="orgFlag" value="${orgFlag }">
										<input type="hidden" id="beginTime" class="beginTime"name="beginTime" value="${beginTime }"> 
										<input type="hidden" id="endTime" class="endTime" name="endTime" value="${endTime }">
									</tr>
									<tr>
										<td>原始新老访客比例(新访客)</td><td>${map.newOld }</td>
									</tr>
									<tr>
										<td style="width: 80px;"><em>*</em>添加pv量：</td>
										<td><input type="text" class="thickBtn pv" name="pv" ></td>
									</tr>
									<tr>
										<td style="width: 80px;"><em>*</em>新老访客比例设置：</td>
										<td><input type="text" class="thickBtn newOld" name="newOld" value="100">%</td>
									</tr>
									<tr>
										<td style="width: 80px;"><em>*</em>平均访问时长：</td>
										<td><input type="text" class="thickBtn avgTime" name="avgTime" >秒</td>
									</tr>
									<tr>
										<td>访问页面概率</td>
										<td>
											<input class="thickBtn pageRatio" id="pageRatio" name="pageRatio"  readonly="readonly" value="0,25,50,25">
											<span class="thickBtn" data-thickcon="pageRatio_edit" style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
											<i></i>编辑</span>
										</td>
									</tr>
									<tr>
										<td>集中访问时间</td>
										<td>
											<input class="thickBtn timeRatio" id="timeRatio" name="timeRatio"  readonly="readonly" value="10,30,30,30">
											<span class="thickBtn" data-thickcon="timeRatio_edit" style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
											<i></i>编辑</span>
										</td>
									</tr>
								</table>
								<div class="tc">
									<input id="add_button" type="button" value="确认添加" />
								</div>
							</form>
							<table class="data-table">
								<tr>
									<th><span>学校</span></th>
									<th width="14%"><span>时间段</span></th>
									<th><span>已添加数据量（pv）</span></th>
									<th><span>新老访客比例（%）</span></th>
									<th><span>平均访问时长（秒）</span></th>
									<th><span>页面数量概率（%）</span></th>
									<th><span>范围集中时间概率（%）</span></th>
									<th><span>操作人</span></th>
									<th><span>操作时间</span></th>
									<th><span>操作</span></th>
								</tr>
								<c:forEach var="list" items="${data.rows }">
									<tr>
										<td>${list.orgName}</td>
										<td>
											<fmt:formatDate value="${list.beginTime}" pattern="yyyy-MM-dd"/>
											---<fmt:formatDate value="${list.endTime}" pattern="yyyy-MM-dd"/>
										</td>
										<td>${list.pv}</td>
										<td>${list.newOld}</td>
										<td>${list.avgTime}</td>
										<td>${list.pageRatio}</td>
										<td>${list.timeRatio}</td>
										<td>${list.username}</td>
										<td><fmt:formatDate value="${list.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<c:if test="${list.type == 0 }">
											<td>
											<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis?browseHandId=${list.id}" target="_blank" class="cd00 thickBtn">查看/添加</a>
											<a data_id="${list.id}" class="cd00 start thickBtn">启动</a>
											</td>
										</c:if>
										<c:if test="${list.type == 1}">
											<td><a href="<cms:getProjectBasePath/>backend/system/contentAnalysis?browseHandId=${list.id}" target="_blank" class="cd00 thickBtn">查看</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
							<div class="page" style="margin-right: 20px;">
								<a class="a1">${data.total}条</a>
								<pg:pager items="${data.total}" url="" export="cp=pageNumber"
									maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
									<pg:param name="type" />
									<pg:param name="orgFlag" />
									
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
		<div id="pageRatio_edit" class="export pageRatio_edit" data-tit="访问页面概率">
			<table>
				<tr><td>访问页面</td><td>目标访问比例</td></tr>
				<tr><td>1</td><td><input class="thickBtn" name="pageRatio" value="0">%</td></tr>
				<tr><td>2-10</td><td><input class="thickBtn" name="pageRatio" value="25">%</td></tr>
				<tr><td>11-20</td><td><input class="thickBtn" name="pageRatio" value="50">%</td></tr>
				<tr><td>21-30</td><td><input class="thickBtn" name="pageRatio" value="25">%</td></tr>
			</table>
			<div class="tc">
				<input id="add_pageRatio" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</div>
		<div id="timeRatio_edit" class="export timeRatio_edit" data-tit="集中访问时间">
			<table>
				<tr><td>集中访问时间</td><td>所占比例</td></tr>
				<tr><td>00:00:00—06:00:00</td><td><input class="thickBtn" name="timeRatio" value="10">%</td></tr>
				<tr><td>06:00:00—12:00:00</td><td><input class="thickBtn" name="timeRatio" value="30">%</td></tr>
				<tr><td>12:00:00—18:00:00</td><td><input class="thickBtn" name="timeRatio" value="30">%</td></tr>
				<tr><td>18:00:00—24:00:00</td><td><input class="thickBtn" name="timeRatio" value="30">%</td></tr>
			</table>
			<div class="tc">
				<input id="add_timeRatio" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</div>
		
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
</div>
<script type="text/javascript">
	//切换学校和数据类型
	function change(val){
		$("#orgFlag").val(val);
		$('#browseHandFrom').submit();
	}
	function choose(val,name){
		$("#addOrgFlag").val(val);
		$("#addOrgName").val(name);
	}
	
	$('.btnEnsure').click(function() {
		$(this).parent().children(".btnCancle").trigger('click');
		/* $('.btnCancle').trigger('click'); */
	})
	
	$('#add_pageRatio').click(function(){
		var pageRatioVal = $("#pageRatio_edit input[name='pageRatio']").map(function(){return $(this).val()}).get().join(",");
		$('#pageRatio').val(pageRatioVal);
	})
	$('#add_timeRatio').click(function(){
		var timeRatioVal = $("#timeRatio_edit input[name='timeRatio']").map(function(){return $(this).val()}).get().join(",");
		$('#timeRatio').val(timeRatioVal);
	})
	

	$('#add_button').click(function(){
		var orgFlag = $("#addBrowseHand .orgFlag").val();
		var beginTime = $("#addBrowseHand input[name='beginTime']").val();
		var endTime = $("#addBrowseHand input[name='endTime']").val();
		var pv = $("#addBrowseHand .pv").val();
		var avgTime = $("#addBrowseHand .avgTime").val();
		var pageRatio = $("#addBrowseHand .pageRatio").val();
		var timeRatio = $("#addBrowseHand .timeRatio").val();
		if(orgFlag==undefined || orgFlag=="" || orgFlag==null){  
		     alert("请选择学校！");  
		     return false;
		}
		if(beginTime==undefined || beginTime=="" || beginTime==null){  
		     alert("请选择起始时间！");  
		     return false;
		}
		if(endTime==undefined || endTime=="" || endTime==null){  
		     alert("请选择结束时间！");  
		     return false;
		}
		if(pv==undefined || pv=="" || pv==null){  
		     alert("请输入添加pv数量！");  
		     return false;
		}
		if(avgTime==undefined || avgTime=="" || avgTime==null){  
		     alert("请输入设置平均访问时长！");  
		     return false;
		}
		if(pageRatio==undefined || pageRatio=="" || pageRatio==null){  
		     alert("请输入页面数量概率！");  
		     return false;
		}
		if(timeRatio==undefined || timeRatio=="" || timeRatio==null){  
		     alert("请输入范围集中时间概率！");  
		     return false;
		}
		var param = $("#addBrowseHand").serialize();  
		$.ajax({  
	    	url : "<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand/add",  
	    	type : "get",  
	    	dataType : "json",
	    	data: param,  
	    	success : function(data) { 
	    		if(data.message >= 1) {
    				window.location.href="<cms:getProjectBasePath/>backend/system/contentAnalysis?browseHandId="+data.message;  
    				/* location.reload(); */
	    		}
	    	}
	   });
	})
	
	$('.start').click(function() {
		var id = $(this).attr("data_id");
		$.ajax({  
	    	url : "<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand/start",  
	    	type : "get",  
	    	dataType : "json",
	    	data: {browseHandId:id},  
	    	success : function(data) { 
    			layer.alert(data.message,function(){
    				location.reload();
				});
	    	}
	   });
	})
</script>
</body>
</html>
