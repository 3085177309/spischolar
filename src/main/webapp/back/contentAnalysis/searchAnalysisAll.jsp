<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>检索分析</title>
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
					<c:if test="${nrfx.id == 16 }">class="in"</c:if>>${nrfx.columnName }</a></li>
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
			<a href="#" class="in">检索分析</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form
						action="<cms:getProjectBasePath/>backend/contentAnalysis/searchAnalysis"
						id="divForm" method="get">
						<input type="hidden" name="school" id="school" value="${school }">
						<label for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="beginTime" name="beginTime"
									onchange="validate()" value="${beginTime }"
									onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="endTime" name="endTime"
									onchange="validate()" value="${endTime }"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
						</label>
						<%-- <c:if test="${org.flag=='wdkj' }">
						<label class="data-type">
							<span class="labt">数据类型:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:if test="${type !=-1 }">
									<span id="section_lx">原始数据</span>
								</c:if>
								<c:if test="${type ==-1 }">
									<span id="section_lx">添加数据</span>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p onclick="change(0,2)">原始数据</p>
									<p onclick="change(-1,2)">添加数据</p>
								</div>
								<input type="hidden" id="type" name="type" value="${type }">
							</div>
						</label>
					</c:if> --%>
						<input type="hidden" id="sort" name="sort" value="${sort }">
						<label class="common"> <input type="text"
							class="tbSearch keyword" name="key" value="${key }"
							placeholder="请输入学校名检索"> <input class="tbBtn"
							type="submit" value="查询" />
						</label>
					</form>
					<div class="clear"></div>
				</div>
				<table class="data-table">
					<tr>
						<th style="text-align: center; width: 60px;">序号</th>
						<th style="text-indent: 12px;">学校</th>
						<th class="sort num" type="num" sort="down"
							style="text-align: center;">总检索次数</th>
						<th class="sort journalSearchNum" type="journalSearchNum"
							sort='down' style="text-align: center;">检索期刊（次）</th>
						<th class="sort scholarSearchNum" type="scholarSearchNum"
							sort='down' style="text-align: center;">检索文章（次）</th>
						<th class="sort avgPage" type="avgPage" sort='down'
							style="text-align: center;">日均检索量</th>
					</tr>
					<c:forEach items="${pager.rows }" var="list" varStatus="status">
						<tr>
							<td style="text-align: center;">${status.index+1+ offset }</td>
							<td style="text-indent: 12px;">${list.school }</td>
							<td style="text-align: center;"><a class="schoolSearch"
								org_falg="${list.flag }">${list.num }</a></td>
							<td style="text-align: center;">${list.journalSearchNum }</td>
							<td style="text-align: center;">${list.scholarSearchNum }</td>
							<td style="text-align: center;">${list.avgPage }</td>
						</tr>
					</c:forEach>
				</table>
				<div class="page" id="page">
					<a class="a1">${pager.total }条</a>
					<pg:pager items="${pager.total}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="beginTime" />
						<pg:param name="endTime" />
						<pg:param name="type" />
						<pg:param name="sort" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<label class="changepage" id="changepageS"> <!-- 中间页码开始 -->
							<pg:page>
								<c:if test="${pager.total/20 gt 5 and (cp gt 3)}">
									...
								</c:if>
							</pg:page> <pg:pages>
								<c:choose>
									<c:when test="${cp eq pageNumber }">
										<span>${pageNumber }</span>
									</c:when>
									<c:otherwise>
										<a href="${pageUrl}" class="a1">${pageNumber}</a>
									</c:otherwise>
								</c:choose>
							</pg:pages> <pg:page>
								<c:if
									test="${pager.total/20 gt 5 and (pager.total/20 gt (cp+2))}">
									...
								</c:if>
							</pg:page> <pg:next>
								<a class="a1" href="${pageUrl}">下一页</a>
							</pg:next>
						</label>
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

				<div class="databottom clearfix">
					<span class="thickBtn downOut fr" data-thickcon="export">导出</span>
				</div>
				<div class="clear10"></div>
			</div>
		</div>
	</div>
	<div class="tickbox">
		<div id="export" class="export" data-tit="导出">
			<form id="exportForm"
				action="<cms:getProjectBasePath/>backend/contentAnalysis/browseAnalysis/download"
				method="get">
				<ul>
					<li><c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校：</span> <span
								id="section_lx">全部学校</span> <input type="hidden" id="downSchool"
								name="school" value="${school }">
							</label>
						</c:if></li>
					<li><label for="" class="data-type"> <span
							class="labt">时间范围：</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" style="*text-indent: 0"
									id="exportBeginTime" value="${beginTime }" name="beginTime"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'exportEndTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="exportEndTime" name="endTime"
									value="${endTime }"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'exportBeginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
					</label></li>
					<input type="hidden" name="content" id="downContent" value="检索分析">
					<li><label class="data-type"> <span class="labt">数据类型：</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:if test="${type == -1 }">
									<span>所有数据</span>
								</c:if>
								<c:if test="${type == 0 }">
									<span>原始数据</span>
								</c:if>
								<c:if test="${type == 1 }">
									<span>添加数据</span>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p href="javascript:void(0)" onclick="downChange('',-1,2)">所有数据</p>
									<p href="javascript:void(0)" onclick="downChange('',0,2)">原始数据</p>
									<p href="javascript:void(0)" onclick="downChange('',1,2)">添加数据</p>
								</div>
								<input type="hidden" name="type" id="downType" value="${type }">
							</div>
					</label></li>
				</ul>
				<div class="tc">
					<input type="button" onclick="exports()" class="btnEnsure btn"
						value="确认导出"> <a href="" class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<!-- 初始化日期 -->
	<!-- 导出 -->
	<script type="text/javascript">
function exports() {
	$("#exportForm").submit();
}
function downChange(name,val,type){
	if(type == 1) {
		$("#downSchool").val(val);
		$("#downSchoolName").val(name);
	} else if(type == 2) {
		$("#downType").val(val);
	}
}
function changeKeyword(content) {
	$("#downContent").val(content);
}
</script>

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
	//排序
	var sort = '${sort }';
	var sortType = sort.substring(0,sort.indexOf("_"));
	sort = sort.substring(sort.indexOf("_")+1,sort.length);
	$(".sort."+sortType).addClass(sort);
	if(sort == 'down') {
		$(".sort."+sortType).attr("sort","up");
	} else {
		$(".sort."+sortType).attr("sort","down");
	}
	$('table.data-table .sort').click(function() {
		var sortType = $(this).attr("type");
		var sort = sortType + "_" +  $(this).attr("sort");
		$('#sort').val(sort);
		$('#divForm').submit();
	})
	
	
	var school = $("#school").val();
	var beginTime = $("#beginTime").val();
	var endTime = $("#endTime").val();
	var type = $("#type").val();

	//获取时间
    var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);                 //今天
    var beginTime = $("#beginTime").val();
    var endTime = $("#endTime").val();
    if(beginTime == "") {
    	beginTime = now;
    }
    if(endTime == "") {
    	endTime = now;
    }
    $("#beginTime").val(beginTime);
    $("#endTime").val(endTime);
    
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
    
    function change(val,type){
		if(type == 1) {
			$("#school").val(val);
		} else if(type == 2) {
			$("#type").val(val);
		}
		$('#divForm').submit();
	}
    function validate(){
    	$('#divForm').submit();
    }
    $('.schoolSearch').click(function(){
    	var orgFlag = $(this).attr("org_falg");
    	$('#school').val(orgFlag);
    	$('#divForm').submit();
    })
	</script>
	</body>
	</html>