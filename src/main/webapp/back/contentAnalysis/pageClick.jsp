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
				<div class="radius">
					<table>
						<thead>
							<td>序号</td>
							<td>页面类型</td>
							<td>操作</td>
						</thead>
						<tr>
							<td>1</td>
							<td>首页</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=首页">查看点击详情</a></td>
						</tr>
						<tr>
							<td>2</td>
							<td>学术期刊指南首页</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=学术期刊指南首页">查看点击详情</a></td>
						</tr>
						<tr>
							<td>3</td>
							<td>学术期刊指南浏览列表</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=学术期刊指南浏览列表">查看点击详情</a></td>
						</tr>
						<tr>
							<td>4</td>
							<td>学术期刊指南检索列表</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=学术期刊指南检索列表">查看点击详情</a></td>
						</tr>
						<tr>
							<td>5</td>
							<td>期刊详细页面</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=期刊详细页面">查看点击详情</a></td>
						</tr>
						<tr>
							<td>6</td>
							<td>蛛网学术搜索首页</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=蛛网学术搜索首页">查看点击详情</a></td>
						</tr>
						<tr>
							<td>7</td>
							<td>蛛网学术搜索结果列表</td>
							<td><a
								href="<cms:getProjectBasePath/>backend/contentAnalysis/pageClick/info?pageName=蛛网学术搜索结果列表">查看点击详情</a></td>
						</tr>
					</table>
					<div class="clear"></div>
				</div>
			</div>
		</div>
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
</script>
<script type="text/javascript">
	var school = $("#school").val();
	var beginTime = $("#beginTime").val();
	var endTime = $("#endTime").val();
	var type = $("#type").val();
	var offset = 0,size = 6;
	var total = ${total};
	var subjectTotal = ${subjectTotal};
	$(document).ready(function(){
		var type= ${type};
	  	if(type=="0"){
			$("#section_lx").html("原始数据");
	  	}else{
		  	$("#section_lx").html("添加数据");
	  	}
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
