<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>页面点击统计</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv00"></span> 内容分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.nrfx }" var="nrfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${nrfx.url}"
					<c:if test="${nrfx.id == 34 }">class="in"</c:if>>${nrfx.columnName }</a></li>
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
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">内容分析</a>>
			<a href="#" class="in">页面点击统计</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="bro_form"
						action="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info"
						method="get">
						<input type="hidden" name="pageName" value="${pageName }">
						<%-- <label class="data-type">
						<span class="labt">学校:</span>
						<div class="sc_selbox">
							<i class="inc uv21"></i>
							<span id="section_xx">${schoolName }</span>
							<div class="sc_selopt" style="display: none;">
								<p class="school" schoolFlag="" schoolId="">全部学校</p>
								<c:forEach items="${orgList }" var="org" varStatus="status">
									<p class="school" schoolFlag="${org.flag }" schoolId="${org.id }">${org.name }</p>
								</c:forEach>
							</div>
							<input type="hidden" id="school" name="school" value="${school }">
							<input type="hidden" id="schoolName" name="schoolName" value="${schoolName }">
						</div>
					</label> --%>
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
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" checked="checked" value="0"> <span>今日</span>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="1"
							<c:if test="${day==1 }">checked="checked"</c:if>> <span>昨日</span>
						</label> <label for="sevenday" class="data-type"> <input
							type="radio" class="tbRadio" name="day" value="2"
							<c:if test="${day==2 }">checked="checked"</c:if>> <span>本周</span>
						</label> <label for="month" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="3"
							<c:if test="${day==3 }">checked="checked"</c:if>> <span>本月</span>
						</label> <label> <span>页面点击总次数:${total }</span>
						</label>
						<%-- <label class="data-type">
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
					</label> --%>
					</form>
					<div class="clear"></div>
				</div>
				<div class="radius databox">
					<h3 class="datahead">${pageName }</h3>
					<table>
						<thead>
							<td>统计链接</td>
							<td>点击次数</td>
							<td>占比</td>
						</thead>
						<c:forEach var="list" items="${list }" varStatus="status">
							<c:if test="${list.num != 0 && list.pageName != '蛛网学术搜索结果列表'}">
								<tr>
									<td>${list.pageName }</td>
									<td>${list.num }</td>
									<td>${list.percent }%</td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../foot.jsp"></jsp:include>


<script type="text/javascript">
//获取时间
var now = new Date();
var nowDayOfWeek = now.getDay();         //今天本周的第几天  
var nowDay = now.getDate();              //当前日  
var nowMonth = now.getMonth();           //当前月  
var nowYear = now.getFullYear();         //当前年
now = formatDate(now,0);                 //今天
//改变时间
$(".tbRadio").click(function(){
	var vals=$('.tbRadio').index(this);
	var beginTime;
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
	$("#bro_form").submit();
});
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
</script>

</body>
</html>
