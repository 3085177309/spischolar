<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>留存用户</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv40"></span> 用户分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.yhfx }" var="yhfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${yhfx.url}"
					<c:if test="${yhfx.id == 14 }">class="in"</c:if>>${yhfx.columnName }</a></li>
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
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">用户分析</a>>
			<a href="#" class="in">留存用户</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="keep_form"
						action="<cms:getProjectBasePath/>backend/visit/keep" method="get">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校:</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i>
									<c:if test="${school == null }">
										<span id="section_lxs">全部学校 </span>
									</c:if>
									<c:if test="${school != null }">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${org.flag == school }">
												<span id="section_lxs">${org.name }</span>
											</c:if>
										</c:forEach>
									</c:if>
									<div class="sc_selopt" style="display: none;">
										<p class="school" schoolFlag="" schoolId="">全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolFlag="${org.flag }"
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" id="school" name="school"
										value="${school }">
								</div>
							</label>
						</c:if>
						<label for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="beginTime" name="beginTime"
									value="${beginTime }"
									onClick="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
									onchange="validate()">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="endTime" name="endTime"
									value="${endTime }"
									onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})"
									onchange="validate()">
							</div>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="1" checked="checked"> <span>按天</span>
						</label> <label for="sevenday" class="data-type"> <input
							type="radio" class="tbRadio" name="day" value="2"> <span>按周</span>
						</label> <label for="month" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="3"> <span>按月</span>
						</label>

						<%-- <c:if test="${org.flag=='wdkj' }">
		<label class="data-type">
			<span class="labt">数据类型:</span>
			<div class="sc_selbox">
				<i class="inc uv21"></i>
				<span id="section_lx">原始数据</span>
				<div class="sc_selopt" style="display: none;">
					<p class="type" id="0">原始数据</p>
					<p class="type" id="1">添加数据</p>
				</div>
				<input type="hidden" id="type" name="type" value="${type }">
			</div>
		</label>
		</c:if> --%>
					</form>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<table class="data-table">
						<tbody>
							<c:if test="${result.size()==0 }">
								<tr>
									<th>首次使用时间</th>
									<th><span>新增用户</span></th>
									<th><span>留存率</span></th>
								</tr>
							</c:if>
							<c:if test="${result.size()>0 }">
								<tr>
									<th>首次使用时间</th>
									<th><span>新增用户</span></th>
									<th colspan="${result.get(0).keeps.size() }" align="center"><span>留存率</span></th>
								</tr>
								<tr>
									<th colspan="2"></th>
									<c:if test="${day==1 }">
										<c:forEach items="${result.get(0).keeps }" var="ke"
											varStatus="status">
											<th><span>${status.index+1 }天后</span></th>
										</c:forEach>
									</c:if>
									<c:if test="${day==2 }">
										<c:forEach items="${result.get(0).keeps }" var="ke2"
											varStatus="status">
											<th><span>${status.index+1 }周后</span></th>
										</c:forEach>
									</c:if>
									<c:if test="${day==3 }">
										<c:forEach items="${result.get(0).keeps }" var="ke3"
											varStatus="status">
											<th><span>${status.index+1 }月后</span></th>
										</c:forEach>
									</c:if>
								</tr>
								<c:forEach items="${result }" var="keep" varStatus="status">
									<tr>
										<td><span>${keep.time }</span></td>
										<td><span>${keep.addUsers }</span></td>
										<c:forEach items="${keep.keeps }" var="keepvalue"
											varStatus="status">
											<td><span>${keepvalue }%</span></td>
										</c:forEach>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function(){
		  var vs = ${day};
		  $("input[name=day][value="+vs+"]").attr("checked",'checked');
		  var type= ${type};
		  if(type=="0"){
			  $("#section_lx").html("原始数据");
		  }else{
			  $("#section_lx").html("添加数据");
		  }
		});
		$('.school').click(function(){
			var schoolFlag = $(this).attr('schoolFlag');
			$("#school").val(schoolFlag);
			validate();
		});
		$('.type').click(function(){
			var type = $(this).attr('id');
			$("#type").val(type);
			validate();
		});
		$(".tbRadio").click(function(){
			validate();
		});
		function validate(){
			var begintime = $("#beginTime").val();
			var endtime = $("#endTime").val();
			if(""==begintime){
				alert("请选择开始日期");
				$("#beginTime").focus();
				return false;
			}
			if(""==endtime){
				alert("请选择结束日期");
				$("#endTime").focus();
				return false;
			}
			var arr = begintime.split("-");
			var starttime = new Date(arr[0], arr[1], arr[2]);
			var starttimes = starttime.getTime();

			var arrs = endtime.split("-");
		    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
			var lktimes = lktime.getTime();
			if (starttimes > lktimes) {
				alert('开始日期大于结束日期，请检查');
				$("#beginTime").focus();
			    return false;
			}
			$('form#keep_form').submit();
		}
</script>
	</body>
	</html>