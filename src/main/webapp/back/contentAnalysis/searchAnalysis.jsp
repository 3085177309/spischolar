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
						<c:if test="${org.flag=='wdkj' }">
							<label class="access-pro"> <span class="labt">学校:</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i>
									<c:if test="${school == null }">
										<span id="section_lx">全部学校</span>
									</c:if>
									<c:if test="${school != null }">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${org.flag == school }">
												<span id="section_lx">${org.name }</span>
											</c:if>
										</c:forEach>
									</c:if>
									<div class="sc_selopt" style="display: none;">
										<p class="school" onclick="change('all',1)">全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" onclick='change("${org.flag }",1)'
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" name="school" id="school"
										value="${school }">
								</div>
							</label>
						</c:if>
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
					</form>
					<div class="clear"></div>
				</div>
				<c:forEach items="${quotas }" var="quo" varStatus="statu">
					<c:if test="${quo.id==7}">
						<div class="radius">
							<div class="databox">
								<h3 class="datahead">
									期刊关键词<span>共检索期刊${allJournalCount }次</span>
								</h3>

								<!-- 期刊 -->
								<div class="databody">
									<table class="data-table" id="journalTable">
									</table>

									<div class="page" id="page">
										<a class="a1">${journalCount }条</a>
										<pg:pager items="${journalCount}" url=""
											export="cp=pageNumber" maxPageItems="6" maxIndexPages="5"
											idOffsetParam="offset">
											<pg:param name="key" />
											<pg:param name="status" />
											<pg:first>
												<a onclick="changePage(0)">首页</a>
											</pg:first>
											<label class="changepage" id="changepageJ"> <!-- 中间页码开始 -->
												<pg:page>
													<c:if test="${journalCount/6 gt 5 and (cp gt 3)}">
													...
												</c:if>
												</pg:page> <pg:pages>
													<c:choose>
														<c:when test="${cp eq pageNumber }">
															<span>${pageNumber }</span>
														</c:when>
														<c:otherwise>
															<a class="a1"
																onclick="changePage(${pageUrl.substring(8,pageUrl.length())})">${pageNumber}</a>
														</c:otherwise>
													</c:choose>
												</pg:pages> <pg:page>
													<c:if
														test="${journalCount/6 gt 5 and (journalCount/6 gt (cp+2))}">
													...
												</c:if>
												</pg:page> <pg:next>
													<a class="a1"
														onclick="changePage(${pageUrl.substring(8,pageUrl.length())})">下一页</a>
												</pg:next>
											</label>
											<pg:last>
												<a
													onclick="changePage(${pageUrl.substring(8,pageUrl.length())})">末页</a>
											</pg:last>

											<input type="text" onkeyup="clearNotInt(this)" id="go"
												style="width: 50px;" size="5">
											<pg:last>
												<a class="a1"
													onclick="go(${pageUrl.substring(8,pageUrl.length())})">GO</a>
											</pg:last>
										</pg:pager>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<c:forEach items="${quotas }" var="quo" varStatus="statu">
					<c:if test="${quo.id==8 }">
						<div class="radius">
							<!-- 文章 -->
							<div class="databox">
								<h3 class="datahead">
									文章关键词<span>共检索文章${allScholarCount }次</span>
								</h3>
								<div class="databody">
									<table class="data-table" id="scholarTable">
									</table>
									<div class="page" id="page">
										<a class="a1">${scholarCount }条</a>
										<pg:pager items="${scholarCount}" url=""
											export="cp=pageNumber" maxPageItems="6" maxIndexPages="5"
											idOffsetParam="offset">
											<pg:param name="key" />
											<pg:param name="status" />
											<pg:first>
												<a onclick="changePageS(0)">首页</a>
											</pg:first>
											<label class="changepage" id="changepageS"> <!-- 中间页码开始 -->
												<pg:page>
													<c:if test="${scholarCount/6 gt 5 and (cp gt 3)}">
													...
												</c:if>
												</pg:page> <pg:pages>
													<c:choose>
														<c:when test="${cp eq pageNumber }">
															<span>${pageNumber }</span>
														</c:when>
														<c:otherwise>
															<a class="a1"
																onclick="changePageS(${pageUrl.substring(8,pageUrl.length())})">${pageNumber}</a>
														</c:otherwise>
													</c:choose>
												</pg:pages> <pg:page>
													<c:if
														test="${scholarCount/6 gt 5 and (scholarCount/6 gt (cp+2))}">
													...
												</c:if>
												</pg:page> <pg:next>
													<a class="a1"
														onclick="changePageS(${pageUrl.substring(8,pageUrl.length())})">下一页</a>
												</pg:next>
											</label>
											<pg:last>
												<a
													onclick="changePageS(${pageUrl.substring(8,pageUrl.length())})">末页</a>
											</pg:last>
											<input type="text" onkeyup="clearNotInt(this)" id="goS"
												style="width: 50px;" size="5">
											<pg:last>
												<a class="a1"
													onclick="goS(${pageUrl.substring(8,pageUrl.length())})">GO</a>
											</pg:last>
										</pg:pager>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
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
							<label class="data-type"> <span class="labt">选择学校：</span>
								<div class="sc_selbox" style="*z-index: 99">
									<i class="inc uv21"></i>
									<c:if test="${school == null }">
										<span id="section_lx">全部学校</span>
									</c:if>
									<c:if test="${school != null }">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${org.flag == school }">
												<c:set var="schoolName" value="${org.name }" />
												<span id="section_lx">${org.name }</span>
											</c:if>
										</c:forEach>
									</c:if>
									<div class="sc_selopt" style="display: none;">
										<p onclick='downChange("全部学校","all",1)'>全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school"
												onclick='downChange("${org.name }","${org.flag }",1)'>${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" id="downSchoolName" name="schoolName"
										value="${schoolName }"> <input type="hidden"
										id="downSchool" name="school" value="${school }">
								</div>
							</label>
						</c:if> <c:if test="${org.flag!='wdkj' }">
							<input type="hidden" id="downSchoolName" name="schoolName"
								value="${org.name }">
							<input type="hidden" id="downSchool" name="school"
								value="${org.flag }">
						</c:if></li>
					<li><label for="" class="data-type"> <span
							class="labt">时间范围：</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" style="*text-indent: 0"
									id="exportBeginTime" readonly="readonly" name="beginTime"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'exportEndTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="exportEndTime" name="endTime"
									readonly="readonly"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'exportBeginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
					</label></li>
					<li><label class="data-type"> <span class="labt">选择内容：</span>
							<div class="sc_selbox" style="*z-index: 98">
								<i class="inc uv21"></i> <span id="search_key">检索-期刊关键词</span>
								<div class="sc_selopt" style="display: none;">
									<p href="javascript:void(0)"
										onclick="changeKeyword('检索-期刊关键词')">检索-期刊关键词</p>
									<p href="javascript:void(0)"
										onclick="changeKeyword('检索-文章关键词')">检索-文章关键词</p>

								</div>
								<input type="hidden" name="content" id="downContent"
									value="检索-期刊关键词">
							</div>
					</label></li>
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
	$('#search_key').html(content);
	$("#downContent").val(content);
}
/**
 * 只能输入正整数
 */
function clearNotInt(obj){
  obj.value = obj.value.replace(/[^\d]/g,"");
}
//跳转翻页
function go(url){
	var page = $('#go').val();
	var offset = (page -1)*6;
	if(page*6-6 > url) {
		alert("超出页码范围！");
		return false;
	}
	if(page<1) {
		alert("超出页码范围！");
		return false;
	}
	changePage(offset);
}
//跳转翻页
function goS(url){
	var page = $('#goS').val();
	var offset = (page -1)*6;
	if(page*6-6 > url) {
		alert("超出页码范围！");
		return false;
	}
	if(page<1) {
		alert("超出页码范围！");
		return false;
	}
	changePageS(offset);
}
</script>

	<script type="text/javascript">
	var school = $("#school").val();
	var beginTime = $("#beginTime").val();
	var endTime = $("#endTime").val();
	var type = $("#type").val();
	var offset = 0,size = 6;
	var journalCount = ${journalCount};
	var scholarCount = ${scholarCount};
	var type= ${type};
	$(document).ready(function(){
		//导出时间设置
	  	$("#exportBeginTime").val($("#beginTime").val());
	  	$("#exportEndTime").val($("#endTime").val());
		journalImp();//期刊
		scholarImp();//文章
	}); 
	//期刊
	function journalImp() {
		$.ajax({  
			url: "<cms:getProjectBasePath/>backend/contentAnalysis/searchAnalysis/searchJournal",  
			data : {"school":school,"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset,"size":size},
			type: "POST",  
			dataType:'json',  
			success:function(data) {
				data = eval("("+data.message+")");
				createJournal(data);
			}
		}); 
	}
	//文章
	function scholarImp() {
		$.ajax({  
			url: "<cms:getProjectBasePath/>backend/contentAnalysis/searchAnalysis/searchScholar",  
			data : {"school":school,"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset,"size":size},
			type: "POST",  
			dataType:'json',  
			success:function(data) {
				data = eval("("+data.message+")");
				createScholar(data);
			}
		}); 
	}
	//期刊
	function createJournal(data){
		$("#journalTable").empty();
		var jsAr = new Array();
		jsAr.push("<tr><th width='60px'><span>序号</span></th><th><span>关键词</span></th><th><span>次数</span></th><th width='40%'><span class='tl'>所占百分比</span></th></tr>");
		for(var i=0; i<data.length; i++){
			jsAr.push("<tr><td><span>"+(i+1)+"</span></td><td><span>"+data[i].keyword+"</span></td><td><span>"+data[i].num+"</span></td><td><span>"+(data[i].percent)+"%</span></td></tr>");
		}
		$("#journalTable").append(jsAr);
	}
	function changePage(pageNum){
		offset=pageNum;
		journalImp();
		$("#changepageJ").empty();
		var pageAr = new Array();
		var s = journalCount%6;
		var a=0;
			a = journalCount/6;
		
		a=Math.ceil(a);
		var b = offset/6+1;
		if(offset!=0 && a!=0){
			pageAr.push("<a class='a1' onclick='changePage("+(offset-6)+")'>上一页</a>");
		}
		if(offset>12 && a>5){
			if(b==a){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-24)+")'>"+(offset/6-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-18)+")'>"+(offset/6-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
			}else if(b==(a-1)){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-18)+")'>"+(offset/6-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset+6)+")'>"+(offset/6+2)+"</a>");
				//pageAr.push("...");
			}else{
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset+6)+")'>"+(offset/6+2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(offset+12)+")'>"+(offset/6+3)+"</a>");
				if(b==(a-2)) {
					
				} else {
					pageAr.push("...");
				}
			}
		}else{
			if(b>3 && a>5) {
				pageAr.push("...");
			}
			for(var i=1; i<=a; i++){
				if(i<=5){
					if(i==(offset/6+1)){
						pageAr.push("<span>"+(offset/6+1)+"</span>");
					}else{
						pageAr.push("<a class='a1' onclick='changePage("+(i-1)*6+")'>"+i+"</a>");
					}
				}
			}
			if(a>5) {
				pageAr.push("...");
			}
		}
		if(b!=a && a!=0){
			pageAr.push("<a class='a1' onclick='changePage("+(offset+6)+")'>下一页</a>");
		}
		$("#changepageJ").append(pageAr);
	}
	//文章
	function createScholar(data){
		$("#scholarTable").empty();
		var jsAr = new Array();
		jsAr.push("<tr><th width='60px'><span>序号</span></th><th><span>关键词</span></th><th><span>次数</span></th><th width='40%'><span class='tl'>所占百分比</span></th></tr>");
		for(var i=0; i<data.length; i++){
			jsAr.push("<tr><td><span>"+(i+1)+"</span></td><td><span>"+data[i].keyword+"</span></td><td><span>"+data[i].num+"</span></td><td><span>"+(data[i].percent)+"%</span></td></tr>");
		}
		$("#scholarTable").append(jsAr);
	}
	function changePageS(pageNum){
		offset=pageNum;
		scholarImp();
		$("#changepageS").empty();
		var pageAr = new Array();
		var s = scholarCount%6;
		var a=0;
			a = scholarCount/6;
		
		a=Math.ceil(a);
		var b = offset/6+1;
		if(offset!=0 && a!=0){
			pageAr.push("<a class='a1' onclick='changePageS("+(offset-6)+")'>上一页</a>");
		}
		if(offset>12 && a>5){
			if(b==a){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-24)+")'>"+(offset/6-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-18)+")'>"+(offset/6-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
			}else if(b==(a-1)){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-18)+")'>"+(offset/6-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset+6)+")'>"+(offset/6+2)+"</a>");
				//pageAr.push("...");
			}else{
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-12)+")'>"+(offset/6-1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset-6)+")'>"+(offset/6)+"</a>");
				pageAr.push("<span>"+(offset/6+1)+"</span>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset+6)+")'>"+(offset/6+2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(offset+12)+")'>"+(offset/6+3)+"</a>");
				//pageAr.push("...");
				if(b==(a-2)) {
					
				} else {
					pageAr.push("...");
				}
			}
		}else{
			if(b>3 && a>5) {
				pageAr.push("...");
			}
			for(var i=1; i<=a; i++){
				if(i<=5){
					if(i==(offset/6+1)){
						pageAr.push("<span>"+(offset/6+1)+"</span>");
					}else{
						pageAr.push("<a class='a1' onclick='changePageS("+(i-1)*6+")'>"+i+"</a>");
					}
				}
			}
			if(a>5) {
				pageAr.push("...");
			}
		}
		if(b!=a && a!=0){
			pageAr.push("<a class='a1' onclick='changePageS("+(offset+6)+")'>下一页</a>");
		}
		$("#changepageS").append(pageAr);
	}
	
	
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
	</script>
	</body>
	</html>