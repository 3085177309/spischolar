<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>浏览分析</title>
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
					<c:if test="${nrfx.id == 17 }">class="in"</c:if>>${nrfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">内容分析</a>>
			<a href="#" class="in">浏览分析</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="bro_form"
						action="<cms:getProjectBasePath/>backend/contentAnalysis/browseAnalysis"
						method="get">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校:</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i> <span id="section_xx">${schoolName }</span>
									<div class="sc_selopt" style="display: none;">
										<p class="school" schoolFlag="" schoolId="">全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolFlag="${org.flag }"
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>

								</div>
							</label>
						</c:if>

						<input type="hidden" id="school" name="school" value="${school }">
						<input type="hidden" id="schoolName" name="schoolName"
							value="${schoolName }"> <label for="" class="data-type">
							<span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="beginTime" name="beginTime"
									value="${beginTime }"
									onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
									onchange="validate()">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="endTime" name="endTime"
									value="${endTime }"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d'})"
									onchange="validate()">
							</div>
						</label>
					</form>
					<div class="clear"></div>
				</div>


				<div class="radius">
					<div class="databox">
						<h3 class="datahead">
							期刊 <span>浏览${journalTotal}本期刊 共${journalCount}次</span>
						</h3>
						<div class="databody">
							<table class="data-table" id="journalTable">
							</table>
						</div>
						<div class="page" id="page">
							<a class="a1">${journalTotal}条</a>
							<pg:pager items="${journalTotal}" url="" export="cp=pageNumber"
								maxPageItems="6" maxIndexPages="5" idOffsetParam="offset">
								<pg:first>
									<a onclick="changePage(1)">首页</a>
								</pg:first>
								<label class="changepage"> <!-- 中间页码开始 --> <pg:page>
										<c:if test="${journalTotal/6 gt 5 and (cp gt 3)}">
											...
										</c:if>
									</pg:page> <pg:pages>
										<c:choose>
											<c:when test="${cp eq pageNumber }">
												<span>${pageNumber }</span>
											</c:when>
											<c:otherwise>
												<a class="a1" onclick="changePage(${pageNumber})">${pageNumber}</a>
											</c:otherwise>
										</c:choose>
									</pg:pages> <pg:page>
										<c:if
											test="${journalTotal/6 gt 5 and (journalTotal/6 gt (cp+2))}">
											...
										</c:if>
									</pg:page> <pg:next>
										<a class="a1" onclick="changePage(${pageNumber})">下一页</a>
									</pg:next>
								</label>
								<pg:last>
									<a onclick="changePage(${pageNumber})">末页</a>
								</pg:last>
								<input type="text" onkeyup="clearNotInt(this)" id="go"
									style="width: 50px;" size="5">
								<pg:last>
									<a class="a1" onclick="go(${pageNumber})">GO</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
				</div>
				<div class="radius">
					<div class="databox">
						<h3 class="datahead">
							学科 <span>浏览${subjectTotal}个学科 共${subjectCount }次</span>
						</h3>
						<div class="databody">
							<table class="data-table" id="subjectTable">
							</table>
						</div>
						<div class="page" id="pageS">
							<a class="a1">${subjectTotal}条</a>
							<pg:pager items="${subjectTotal}" url="" export="cp=pageNumber"
								maxPageItems="6" maxIndexPages="5" idOffsetParam="offset">
								<pg:first>
									<a onclick="changePageS(1)">首页</a>
								</pg:first>
								<label class="changepageS"> <!-- 中间页码开始 --> <pg:page>
										<c:if test="${subjectTotal/6 gt 5 and (cp gt 3)}">
											...
										</c:if>
									</pg:page> <pg:pages>
										<c:choose>
											<c:when test="${cp eq pageNumber }">
												<span>${pageNumber }</span>
											</c:when>
											<c:otherwise>
												<a class="a1" onclick="changePageS(${pageNumber})">${pageNumber}</a>
											</c:otherwise>
										</c:choose>
									</pg:pages> <pg:page>
										<c:if
											test="${subjectTotal/6 gt 5 and (subjectTotal/6 gt (cp+2))}">
											...
										</c:if>
									</pg:page> <pg:next>
										<a class="a1" onclick="changePageS(${pageNumber})">下一页</a>
									</pg:next>
								</label>
								<pg:last>
									<a onclick="changePageS(${pageNumber})">末页</a>
								</pg:last>
								<input type="text" onkeyup="clearNotInt(this)" id="goS"
									style="width: 50px;" size="5">
								<pg:last>
									<a class="a1" onclick="goS(${pageNumber})">GO</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
				</div>

				<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
				<div class="radius">
					<div class="databox">
						<h3 class="datahead">
							学科体系<span>共浏览${dbCount }次</span>
						</h3>
						<div class="databody">
							<div class="echart" id="echart" style="height: 400px"></div>
						</div>
					</div>
				</div>
				<div class="databottom clearfix">
					<span href="#" class="thickBtn downOut fr" data-thickcon="export">导出</span>
				</div>
				<div class="clear" style="height: 60px\0"></div>
			</div>
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
											<p onclick='downChange("${org.name }","${org.flag }",1)'>${org.name }</p>
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
				<li><label for="" class="data-type"> <span class="labt">时间范围：</span>
						<div class="datebox">
							<i class="inc uv13"></i> <input type="text"
								class="tbSearch datechoose" id="exportBeginTime"
								readonly="readonly" name="beginTime"
								onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'exportEndTime\')}',readOnly:true})">
						</div> <span class="labm">至</span>
						<div class="datebox">
							<i class="inc uv13"></i> <input type="text"
								class="tbSearch datechoose" id="exportEndTime"
								readonly="readonly" name="endTime"
								onfocus="WdatePicker({minDate:'#F{$dp.$D(\'exportBeginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
						</div>
				</label></li>
				<li><label class="data-type"> <span class="labt">选择内容：</span>
						<div class="sc_selbox" style="*z-index: 98">
							<i class="inc uv21"></i> <span>浏览期刊</span>
							<div class="sc_selopt" style="display: none;">
								<p href="javascript:void(0)" onclick="changeKeyword('浏览期刊')">浏览期刊</p>
								<p href="javascript:void(0)" onclick="changeKeyword('浏览学科')">浏览学科</p>
								<p href="javascript:void(0)" onclick="changeKeyword('浏览学科体系')">浏览学科体系</p>
							</div>
							<input type="hidden" name="content" id="downContent" value="浏览期刊">
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
			<div class="clear" style=""></div>
		</form>
	</div>
</div>
<jsp:include page="../foot.jsp"></jsp:include>

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
/**
 * 只能输入正整数
 */
function clearNotInt(obj){
  obj.value = obj.value.replace(/[^\d]/g,"");
}
//跳转翻页
function go(url){
	var page = $('#go').val();
	if(page > url) {
		alert("超出页码范围！");
		return false;
	}
	if(page<1) {
		alert("超出页码范围！");
		return false;
	}
	changePage(parseInt(page));
}
//跳转翻页
function goS(url){
	var page = $('#goS').val();
	if(page > url) {
		alert("超出页码范围！");
		return false;
	}
	if(page<1) {
		alert("超出页码范围！");
		return false;
	}
	changePageS(parseInt(page));
}
</script>
<script type="text/javascript">
	var school = $("#school").val();
	var beginTime = $("#beginTime").val();
	var endTime = $("#endTime").val();
	var type = $("#type").val();
	var offset = 0,size = 6;
	var total = ${journalTotal};
	var subjectTotal = ${subjectTotal};
	var type= ${type};
	$(document).ready(function(){
	  	/* if(type=="0"){
			$("#section_lx").html("原始数据");
	  	}else if(type=="1"){
		  	$("#section_lx").html("添加数据");
	  	} else {
	  		$("#section_lx").html("所有数据");
	  	} */
	  	journalImp();
	  	subjectImp();
	  	
	  	//导出时间设置
	  	$("#exportBeginTime").val($("#beginTime").val());
	  	$("#exportEndTime").val($("#endTime").val());
	});
	$('.type').click(function(){
		var typevalue = $(this).attr('id');
		$("#type").val(typevalue);
		validate();
	});
	$('.school').click(function(){
		var schoolFlag = $(this).attr('schoolFlag');
		var schoolName = $(this).text();
		$("#school").val(schoolFlag);
		$("#schoolName").val(schoolName);
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
		$('form#bro_form').submit();
	}
	function journalImp() {
		console.log(type);
		$.ajax({
            async : true,
            cache : false,
            type : 'POST',
            url : "<cms:getProjectBasePath/>backend/contentAnalysis/browseAnalysis/journalImp",
            data : {"school":school,"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset,"size":size},
            success : function(data) {
               data = eval("("+data.message+")");
               createJournal(data);
            }
        });
	}
	function createJournal(data){
		$("#journalTable").empty();
		var jsAr = new Array();
		jsAr.push("<tr><th width='60px'><span>序号</span></th><th><span>期刊</span></th><th><span>次数</span></th><th width='40%'><span class='tl'>所占百分比</span></th></tr>");
		for(var i=0; i<data.length; i++){
			jsAr.push("<tr><td><span>"+(offset+i+1)+"</span></td><td><span>"+data[i].keyword+"</span></td><td><span>"+data[i].num+"</span></td><td><span>"+data[i].percent+"</span></td></tr>");
		}
		$("#journalTable").append(jsAr);
	}
	function subjectImp() {
		$.ajax({
            async : true,
            cache : false,
            type : 'POST',
            url : "<cms:getProjectBasePath/>backend/contentAnalysis/browseAnalysis/subjectImp",
            data : {"school":school,"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset,"size":size},
            success : function(data) {
               data = eval("("+data.message+")");
               createSubject(data);
            }
        });
	}
	function createSubject(data){
		$("#subjectTable").empty();
		var jsAr = new Array();
		jsAr.push("<tr><th width='60px'><span>序号</span></th><th><span>学科</span></th><th><span>次数</span></th><th width='40%'><span class='tl'>所占百分比</span></th></tr>");
		for(var i=0; i<data.length; i++){
			jsAr.push("<tr><td><span>"+(offset+i+1)+"</span></td><td><span>"+data[i].keyword+"</span></td><td><span>"+data[i].num+"</span></td><td><span>"+data[i].percent+"</span></td></tr>");
		}
		$("#subjectTable").append(jsAr);
	}
	/**分页*/
	function changePage(pageNum){
		offset=(pageNum-1)*6;
		journalImp();
		$(".changepage").empty();
		var pageAr = new Array();
		var s = total%6;
		var a=total/6;
		//向上去整  2.22 即是 3
		a=Math.ceil(a);
		if(pageNum!=1 && a!=0){
			pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>上一页</a>");
		}
		if(pageNum>3 && a>5){
			if(pageNum==a){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-4)+")'>"+(pageNum-4)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
			}else if(pageNum==(a-1)){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				//pageAr.push("...");
			}else{
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum+2)+")'>"+(pageNum+2)+"</a>");
				//pageAr.push("...");
				if(pageNum==(a-2)) {
					
				} else {
					pageAr.push("...");
				}
			}
		}else{
			if(pageNum>3 && a>5) {
				pageAr.push("...");
			}
			for(var i=1; i<=a; i++){
				if(i<=5){
					if(i==pageNum){
						pageAr.push("<span>"+pageNum+"</span>");
					}else{
						pageAr.push("<a class='a1' onclick='changePage("+i+")'>"+i+"</a>");
					}
				}
			}
			if(a>5) {
				pageAr.push("...");
			}
			
		}
		if(pageNum!=a && a!=0){
			pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>下一页</a>");
		}
		$(".changepage").append(pageAr);
	}
	function changePageS(pageNum){
		offset=(pageNum-1)*6;
		subjectImp();
		$(".changepageS").empty();
		var pageAr = new Array();
		var s = subjectTotal%6;
		var a=subjectTotal/6;
		//向上去整  2.22 即是 3
		a=Math.ceil(a);
		if(pageNum!=1 && a!=0){
			pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-1)+")'>上一页</a>");
		}
		if(offset>12 && a>5){
			if(pageNum==a){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-4)+")'>"+(pageNum-4)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
			}else if(pageNum==(a-1)){
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				//pageAr.push("...");
			}else{
				pageAr.push("...");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
				pageAr.push("<span>"+pageNum+"</span>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				pageAr.push("<a class='a1' onclick='changePageS("+(pageNum+2)+")'>"+(pageNum+2)+"</a>");
				//pageAr.push("...");
				if(pageNum==(a-2)) {
					
				} else {
					pageAr.push("...");
				}
			}
		}else{
			if(pageNum > 3 && a>5) {
				pageAr.push("...");
			}
			for(var i=1; i<=a; i++){
				if(i<=5){
					if(i==pageNum){
						pageAr.push("<span>"+pageNum+"</span>");
					}else{
						pageAr.push("<a class='a1' onclick='changePageS("+i+")'>"+i+"</a>");
					}
				}
			}
			if(a>5) {
				pageAr.push("...");
			}
		}
		if(pageNum!=a && a!=0){
			pageAr.push("<a class='a1' onclick='changePageS("+(pageNum+1)+")'>下一页</a>");
		}
		$(".changepageS").append(pageAr);
	}
</script>
<script type="text/javascript">
//路径配置
require.config({
    paths: {
        echarts: 'http://echarts.baidu.com/build/dist'
    }
});
var myChart;
require([
         'echarts',
         'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
         'echarts/chart/bar'
     ],function(ec){
	myChart = ec.init(document.getElementById('echart')); 
	var option = {
		    title : {
		        text: '各学科体系的浏览量'
		        //subtext: '纯属虚构'
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['pv']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: false},
		            dataView : {show: false, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: false}
		        },
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	            }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLabel:{
                        interval:0,
                      	rotate:45,
                      	margin:2,
                      	textStyle:{
                          color:"#222"
                      	}
                  	},
		            data : ${result.db}
		        }
		    ],
		    grid: { // 控制图的大小，调整下面这些值就可以，
	             x: 40,
	             x2: 100,
	             y2: 100// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
	         },

		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'pv',
		            type:'bar',
		            data:${result.data},
		            markPoint : {
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ]
		            }
		            
		        }
		    ]
		};
	myChart.setOption(option);
});
</script>
</body>
</html>
