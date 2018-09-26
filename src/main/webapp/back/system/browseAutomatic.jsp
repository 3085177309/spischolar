<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>数据自动添加</title>

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
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic" class="in">数据自动添加</a>
		</div>

		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic"
							class="in">数据自动添加</a> 
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseHand">数据手动添加</a> 
						<%-- <a href="<cms:getProjectBasePath/>backend/system/contentAnalysis">期刊文章统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/downloadRecord">文章下载统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/deliveryRecord">文献互助统计</a>
						<a href="<cms:getProjectBasePath/>backend/system/contentAnalysis/userRecord">学校用户管理</a> --%>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="browseHandFrom"
									action="<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic"
									method="get">
									<div class="pageTopbar clearfix">
										<label class="data-type"> <span class="labt">学校:</span>
											<div class="sc_selbox">
												<i class="inc uv21"></i>
												<span id="section_lx">${orgName }</span>
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
								<p>${orgName }使用时间:<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>---${registerEndDate }</p>
							</c:if>
							<form action="" id="addBrowseHand">
								<input type="hidden" name="orgFlag" value="${orgFlag }">
								<input type="hidden" id="addOrgName" class="orgName"name="orgName" value="${orgName }"> 
								<input type="hidden" name="id" value="${automaticMap.id }">
								<table>
									<tr>
										<td></td><td>值</td><td>编辑</td>
									</tr>
									<tr>
										<td>原始日均PV</td><td>${map.pv }</td><td></td>
									</tr>
									<tr>
										<td>原始新老访客比例(新访客)</td><td>${map.newOld }</td><td><input type="text" class="thickBtn newOld" name="newOld" value="${automaticMap.newOld}">%</td>
									</tr>
									<tr>
										<td>目标日均pv值范围</td><td>${automaticMap.minPv}---${automaticMap.maxPv}</td>
										<td><input class="thickBtn" name="minPv" value="${automaticMap.minPv}"> --- <input class="thickBtn" name="maxPv" value="${automaticMap.maxPv}"></td>
									</tr>
									<tr>
										<td>目标日均PV波动范围</td><td>${automaticMap.minPvWave}---${automaticMap.maxPvWave}</td>
										<td><input class="thickBtn" name="minPvWave" value="${automaticMap.minPvWave}"> --- <input class="thickBtn" name="maxPvWave" value="${automaticMap.maxPvWave}"></td>
									</tr>
									<tr>
										<td>波动概率</td><td>${automaticMap.pvRatio}</td>
										<td><input class="thickBtn" name="pvRatio" value="${automaticMap.pvRatio}">%</td>
									</tr>
									<tr>
										<td>平均访问时长</td><td>${automaticMap.avgTime}</td>
										<td><input class="thickBtn" name="avgTime" value="${automaticMap.avgTime}">秒</td>
									</tr>
									<tr>
										<td>访问页面概率</td><td>${automaticMap.pageRatio}</td>
										<td>
											<input class="thickBtn" id="pageRatio" name="pageRatio" readonly="readonly" value="${automaticMap.pageRatio}">
											<span class="thickBtn" data-thickcon="pageRatio_edit" style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
											<i></i>编辑</span>
										</td>
									</tr>
									<tr>
										<td>集中访问时间</td><td>${automaticMap.timeRatio}</td>
										<td>
											<input class="thickBtn" id="timeRatio" name="timeRatio" readonly="readonly" value="${automaticMap.timeRatio}">
											<span class="thickBtn" data-thickcon="timeRatio_edit" style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
											<i></i>编辑</span>
										</td>
									</tr>
									<tr>
										<td>特殊访问月份</td><td>${automaticMap.monthRatio}</td>
										<td>
											<input class="thickBtn" id="monthRatio" name="monthRatio" readonly="readonly" value="${automaticMap.monthRatio}">
											<span class="thickBtn" data-thickcon="monthRatio_edit" style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
											<i></i>编辑</span>
										</td>
									</tr>
								</table>
								<div class="tc">
									<input id="add_button" type="button" value="确认添加" />
								</div>
							</form>
							<br/><br/>
							<p>日志</p>
							<c:forEach var="log" items="${data.rows }">
								<c:forEach items="${orgList }" var="org" varStatus="status">
									<c:if test="${org.flag == log.orgFlag }">学校：${org.name}&nbsp;&nbsp;</c:if>
								</c:forEach>
								操作人：${log.username}&nbsp;&nbsp;  时间：<fmt:formatDate value="${log.time }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp; 操作：${log.state }
								<table>
									<tr><td>目标日均pv值范围</td><td>${log.minPv}---${log.maxPv}</td></tr>
									<tr><td>目标日均PV波动范围</td><td>${log.minPvWave}---${log.maxPvWave}</td></tr>
									<tr><td>波动概率</td><td>${log.pvRatio}%</td></tr>
									<tr><td>新老访客比例</td><td>${log.newOld}%</td></tr>
									<tr><td>平均访问时长</td><td>${log.avgTime}秒</td></tr>
									<tr><td>访问页面概率</td><td>${log.pageRatio}</td></tr>
									<tr><td>集中访问时间</td><td>${log.timeRatio}</td></tr>
									<tr><td>特殊访问月份</td><td>${log.monthRatio}</td></tr>
								</table>
								<br/><br/>
							</c:forEach>
							<div class="page" style="margin-right: 20px;">
								<a class="a1">${data.total}条</a>
								<pg:pager items="${data.total}" url="" export="cp=pageNumber"
									maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
									<pg:param name="type" />
									<pg:param name="orgFlag" />
									<pg:param name="beginTime" />
									<pg:param name="endTime" />
									<pg:first>
										<a href="${pageUrl}">首页</a>
									</pg:first>
									<pg:prev>
										<a href="${pageUrl}" class="a1">上一页</a>
									</pg:prev>
									<!-- 中间页码开始 -->
									<pg:page>
										<c:if test="${data.total/10 gt 10 and (cp gt 3)}">
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
										<c:if test="${data.total/10 gt 10 and (data.total/10 gt (cp+2))}">
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
				<tr><td width="25%">访问页面</td><td width="30%">原始访问比例</td><td>目标访问比例</td></tr>
				<c:forEach items="${automaticMap.pageRatioList }" var="pageRatioList">
					<tr><td>${pageRatioList.name }</td><td>${pageRatioList.oldRatio }%</td><td><input class="thickBtn" name="pageRatio" value="${pageRatioList.ratio }">%</td></tr>
				</c:forEach>
			</table>
			<div class="tc">
				<input id="add_pageRatio" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</div>
		<div id="timeRatio_edit" class="export timeRatio_edit" data-tit="集中访问时间">
			<table>
				<tr><td>集中访问时间</td><td>所占比例</td></tr>
				<c:forEach items="${automaticMap.timeRatioList }" var="timeRatioList">
					<tr><td>${timeRatioList.name }</td><td><input class="thickBtn" name="timeRatio" value="${timeRatioList.ratio }">%</td></tr>
				</c:forEach>
			</table>
			<div class="tc">
				<input id="add_timeRatio" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</div>
		<div id="monthRatio_edit" class="export monthRatio_edit" data-tit="特殊访问月份">
			<table>
				<tr><td>特殊访问月份</td><td>所占比例</td></tr>
				<c:forEach items="${automaticMap.monthRatioList }" var="monthRatioList">
					<tr><td>${monthRatioList.name }</td><td><input class="thickBtn" name="monthRatio" value="${monthRatioList.ratio }">%</td></tr>
				</c:forEach>
			</table>
			<div class="tc">
				<input id="add_monthRatio" type="button" value="确认添加"
					class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
</div>
<script type="text/javascript">
	$('.btnEnsure').click(function() {
		$(this).parent().children(".btnCancle").trigger('click');
		/* $('.btnCancle').trigger('click'); */
	})
	//切换学校和数据类型
	function change(val){
		$("#orgFlag").val(val);
		$('#browseHandFrom').submit();
	}
	
	$('#add_pageRatio').click(function(){
		var pageRatioVal = $("#pageRatio_edit input[name='pageRatio']").map(function(){return $(this).val()}).get().join(",");
		$('#pageRatio').val(pageRatioVal);
	})
	$('#add_timeRatio').click(function(){
		var timeRatioVal = $("#timeRatio_edit input[name='timeRatio']").map(function(){return $(this).val()}).get().join(",");
		$('#timeRatio').val(timeRatioVal);
	})
	$('#add_monthRatio').click(function(){
		var timeRatioVal = $("#monthRatio_edit input[name='monthRatio']").map(function(){return $(this).val()}).get().join(",");
		$('#monthRatio').val(timeRatioVal);
	})
	
	
	$('#add_button').click(function(){
		var orgFlag = $("#addBrowseHand [name='orgFlag']").val();
		var minPv = $("#addBrowseHand input[name='minPv']").val();
		var maxPv = $("#addBrowseHand input[name='maxPv']").val();
		var minPvWave = $("#addBrowseHand input[name='minPvWave']").val();
		var maxPvWave = $("#addBrowseHand input[name='maxPvWave']").val();
		var pvRatio = $("#addBrowseHand input[name='pvRatio']").val();
		var avgTime = $("#addBrowseHand input[name='avgTime']").val();
		var pageRatio = $("#addBrowseHand input[name='pageRatio']").val();
		var timeRatio = $("#addBrowseHand input[name='timeRatio']").val();
		if(orgFlag==undefined || orgFlag=="" || orgFlag==null){  
		     alert("请选择学校！");  
		     return false;
		}
		if(minPv==undefined || minPv=="" || minPv==null){  
		     alert("请输入添加pv范围最小值！");  
		     return false;
		}
		if(maxPv==undefined || maxPv=="" || maxPv==null){  
		     alert("请输入添加pv范围最大值！");  
		     return false;
		}
		if(minPvWave==undefined || minPvWave=="" || minPvWave==null){  
		     alert("请输入添加pv波动范围最小值！");  
		     return false;
		}
		if(maxPvWave==undefined || maxPvWave=="" || maxPvWave==null){  
		     alert("请输入添加pv波动范围最大值！");  
		     return false;
		}
		if(pvRatio==undefined || pvRatio=="" || pvRatio==null){  
		     alert("请输入添加pv波动概率！");  
		     return false;
		}
		if(avgTime==undefined || avgTime=="" || avgTime==null){  
		     alert("请输入添加平均访问时长！");  
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
	    	url : "<cms:getProjectBasePath/>backend/system/contentAnalysis/browseAutomatic/add",  
	    	type : "get",  
	    	dataType : "json",
	    	data: param,  
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
