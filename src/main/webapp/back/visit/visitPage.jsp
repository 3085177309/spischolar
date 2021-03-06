<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>访问页面</title>
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
					<c:if test="${yhfx.id == 15 }">class="in"</c:if>>${yhfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">用户分析</a>>
			<a href="#" class="in">访问页面</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="visit_form"
						action="<cms:getProjectBasePath/>backend/visit/visitPage"
						method="get">
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
										<p class="school" schoolFlag="all" schoolId="">全部学校</p>
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
									onchange="validate()" value="${beginTime }"
									onClick="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="endTime" name="endTime"
									onchange="validate()" value="${endTime }"
									onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="1" checked="checked"> <span>今日</span>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="2"> <span>昨日</span>
						</label> <label for="sevenday" class="data-type"> <input
							type="radio" class="tbRadio" name="day" value="3"> <span>本周</span>
						</label> <label for="month" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="4"> <span>本月</span>
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
		</c:if>	 --%>
					</form>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<table class="data-table">
						<tbody>
							<tr>
								<th><span>访问页数</span></th>
								<th><span>访客数</span></th>
								<th><span>访问次数</span></th>
								<th width="40%"><span class="tl">所占百分比</span></th>
							</tr>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><span>${result.page }</span></td>
									<td><span>${result.uv }</span></td>
									<td><span>${result.count }</span></td>
									<td><span><p class="percent">
												<b>${result.percent }</b><span>${result.percent }</span>
											</p></span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<jsp:include page="../foot.jsp"></jsp:include>
				<script>
	var histogram=function(){
		var $percentNum=$(".percent b");
		$percentNum.each(function(i,item){
			var $thisNum=parseFloat($(this).html())
			if($thisNum>"90.0"){
				$(this).siblings("span").css({
					"position":"absolute",
					"margin-left":"-50px"
				})
			}else if($thisNum=="0"){
				$(this).parents("p").hide().css({
					"background":"none"
				})
			}
			$(this).animate({
				width:$thisNum+"%"
			},1000);
		})
	}();
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
	var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);				//今天
	$(".tbRadio").click(function(){
    	var vals=$('.tbRadio').index(this);
    	var beginTime,endTime;
    	if(vals==0) {
    		beginTime = formatDate(new Date(),0);
    		endTime = formatDate(new Date(),0);
    	} else if(vals==1) {
    		beginTime = formatDate(new Date(),-1);
    		endTime = formatDate(new Date(),-1);
    	} else if(vals==2) {
    		beginTime = getWeekStartDate();
    		endTime = formatDate(new Date(),0);
    	} else if(vals==3) {
    		beginTime =  getMonthStartDate();
    		endTime = formatDate(new Date(),0);
    	}
    	$("#beginTime").val(beginTime);
    	$("#endTime").val(endTime);
    	
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
		$('form#visit_form').submit();
	}
  //获得本周的开始日期  
    function getWeekStartDate() {   
        var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek); 
        return formatDate(weekStartDate,0);  
    } 
  //获得本月的开始日期  
    function getMonthStartDate(){  
        var monthStartDate = new Date(nowYear, nowMonth, 1);   
        return formatDate(monthStartDate,0);  
    } 
    
  //格式化日期：yyyy-MM-dd  
    function formatDate(date,num) {  
        var myyear = date.getFullYear();  
        var mymonth = date.getMonth()+1;  
        var myweekday = date.getDate()+ num;   
        if(mymonth < 10){  
            mymonth = "0" + mymonth;  
        }   
        if(myweekday < 10){  
            myweekday = "0" + myweekday ;  
        }  
        return (myyear+"-"+mymonth + "-" + myweekday);  
    }
	</script>
				</body>
				</html>