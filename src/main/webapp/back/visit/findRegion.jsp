<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>地域分布</title>
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
					<c:if test="${yhfx.id == 13 }">class="in"</c:if>>${yhfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">用户分析</a>>
			<a href="#" class="in">地域分布</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="comefrom" action="" method="get">

						<label class="data-type"> <span class="labt">学校:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:if test="${province == null || empty province}">
									<span id="section_lx">全部地区</span>
								</c:if>
								<c:if test="${province != null }">
									<span id="section_lx">${province }</span>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p class="province" onclick="change('',1)">全部地区</p>
									<c:forEach items="${pList }" var="org" varStatus="status">
										<p class="province" onclick='change("${org.province }",1)'>${org.province }</p>
									</c:forEach>
									<p class="province" onclick="change('其他',1)">其他</p>
								</div>
								<input type="hidden" name="province" id="province"
									value="${province }">
							</div>
						</label> <label for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									value="${beginTime }" class="tbSearch datechoose"
									id="beginTime" name="beginTime" onchange="submit()"
									onClick="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" value="${endTime }"
									class="tbSearch datechoose" id="endTime" name="endTime"
									onchange="submit()"
									onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="today" checked="checked"
							<c:if test='${day=="today" }'>checked="checked"</c:if>> <span>今日</span>
						</label> <label for="today" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="yesterday"
							<c:if test='${day=="yesterday" }'>checked="checked"</c:if>>
							<span>昨日</span>
						</label> <label for="sevenday" class="data-type"> <input
							type="radio" class="tbRadio" name="day" value="toWeek"
							<c:if test='${day=="toWeek" }'>checked="checked"</c:if>>
							<span>本周</span>
						</label> <label for="month" class="data-type"> <input type="radio"
							class="tbRadio" name="day" value="toMonth"
							<c:if test='${day=="toMonth" }'>checked="checked"</c:if>>
							<span>本月</span>
						</label>
						<%-- <c:if test="${org.flag=='wdkj' }">
					<label class="data-type">
						<span class="labt">数据类型:</span>
						<div class="sc_selbox">
							<i class="inc uv21"></i>
							<span id="section_lx">原始数据</span>
							<div class="sc_selopt" style="display: none;">
								<p onclick="change(0,2)">原始数据</p>
								<p onclick="change(-1,2)">添加数据</p>
							</div>
							<input type="hidden" id="type" name="type" value="${type }">
						</div>
					</label>
					</c:if> --%>
						<input type="hidden" id="sort" name="sort" value="${sort }">
						<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="databox">
						<h3 class="datahead">可视化图标</h3>
						<div class="dataActchoice">
							<c:forEach items="${quotas }" var="quo" varStatus="status">
								<c:if test="${quo.id!=7 && quo.id!=8 }">
									<label for="sevenday" class="data-type"> <input
										type="radio" class="types" name="types"
										value="${quo.quotaName }"
										<c:if test="${status.index==0 }">checked="checked"</c:if>>
										<span>${quo.quotaName }</span>
									</label>
								</c:if>
							</c:forEach>
						</div>
						</form>
						<div class="databody" id="chain" style="height: 400px;">
							图标内容</div>
					</div>
				</div>
				<div class="radius">
					<table class="data-table">
						<tbody>
							<tr>
								<th width="40px">序号</th>
								<th><span>地区</span></th>
								<c:forEach items="${quotas }" var="quo" varStatus="statu">
									<c:if test="${quo.id!=7 && quo.id!=8 }">
										<th><span sort="down" style="text-align: center;"
											<c:if test="${quo.id==6}">class="sort jump" type="jump"</c:if>
											<c:if test="${quo.id==4}">class="sort avgTime" type="avgTime"</c:if>
											<c:if test="${quo.id==3}">class="sort ip" type="ip"</c:if>
											<c:if test="${quo.id==2}">class="sort uv" type="uv"</c:if>
											<c:if test="${quo.id==1}">class="sort pv" type="pv"</c:if>>${quo.quotaName }</span></th>
									</c:if>
								</c:forEach>
								<!-- 	<th><span class="down">转化率</span></th> -->
							</tr>
							<c:forEach items="${list }" var="list" varStatus="status">
								<tr>
									<td><span>${status.index+1 }</span></td>
									<c:if test="${province == 'all' || empty province }">
										<c:if test="${empty list.schoolProvince }">
											<td><span>其他</span></td>
										</c:if>
										<c:if test="${not empty list.schoolProvince }">
											<td><span>${list.schoolProvince }</span></td>
										</c:if>
									</c:if>
									<c:if test="${province != 'all' && not empty province }">
										<td><span>${list.schoolName }</span></td>
									</c:if>
									<c:forEach items="${quotas }" var="quota" varStatus="stat">
										<c:if test="${quota.id==1 }">
											<td><span>${list.pv }</span></td>
										</c:if>
										<c:if test="${quota.id==2 }">
											<td><span>${list.uv }</span></td>
										</c:if>
										<c:if test="${quota.id==3 }">
											<td><span>${list.ip }</span></td>
										</c:if>
										<c:if test="${quota.id==4 }">
											<td><span>${list.avgTime }</span></td>
										</c:if>
										<c:if test="${quota.id==5 }">
											<td><span>${list.avgPage }</span></td>
										</c:if>
										<c:if test="${quota.id==6 }">
											<td><span>${list.jump }%</span></td>
										</c:if>
									</c:forEach>
									<!--	<td><span>56%</span></td> -->
								</tr>
							</c:forEach>

						</tbody>
					</table>

				</div>
				<div class="page" id="page">
					<a class="a1">${count}条</a>
					<pg:pager items="${count}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="beginTime" />
						<pg:param name="endTime" />
						<pg:param name="type" />
						<pg:param name="province" />
						<pg:param name="sort" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${count/10 gt 5 and (cp gt 3)}">
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
							<c:if test="${count/10 gt 5 and (count/10 gt (cp+2))}">
								...
							</c:if>
						</pg:page>
						<pg:next>
							<a class="a1" href="${pageUrl}">下一页</a>
						</pg:next>
						<pg:last>
							<a href="${pageUrl}">末页</a>
						</pg:last>
					</pg:pager>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>


	<!-- 初始化日期 -->
	<script type="text/javascript">
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
		$('#comefrom').submit();
	})
	
	//获取时间
    var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);                 //今天
//    $("#beginTime").val(now);
//    $("#endTime").val(now);
    
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
    	$('#comefrom').submit();
//    	department();
    });
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
	<script type="text/javascript">
	function change(val,type){
		if(type == 1) {
			$("#province").val(val);
		} else if(type == 2) {
			$("#type").val(val);
		}
		$('#comefrom').submit();
	}
	</script>
	<script type="text/javascript">
	$('.types').click(function(){
		department();
	})
    require.config({
        paths: {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });
    var myChart;
    require([
             'echarts',
             'echarts/chart/map', // 使用柱状图就加载bar模块，按需加载
         ],
        function(ec){
		myChart = ec.init(document.getElementById('chain')); 
		var option = {
			    title : {
			        text: '用户分析',
			        subtext: '地域分布',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item'
			    },
			    legend: {
			        orient: 'vertical',
			        x:'left',
			        data:['jump']
			    },
			    dataRange: {
			        min: 0,
			        max: 2500,
			        x: 'left',
			        y: 'bottom',
			        text:['高','低'],           // 文本，默认为数值文本
			        calculable : true
			    },
			    toolbox: {
			        show: true,
			        orient : 'vertical',
			        x: 'right',
			        y: 'center',
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    roamController: {
			        show: true,
			        x: 'right',
			        mapTypeControl: {
			            'china': true
			        }
			    },
			    series : [
			        {
			            name: '',
			            type: 'map',
			            mapType: 'china',
			            roam: false,
			            itemStyle:{
			                normal:{label:{show:true}},
			                emphasis:{label:{show:true}}
			            },
			            data:[
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''},
			                {name: '',value: ''}
			            ]
			        }
			    ]
			};
		 myChart.setOption(option); 
		 department();
	});
    function department(){
    	var option = myChart.getOption();
		$.ajax({
			 type : "post",
			 url : '<cms:getProjectBasePath/>backend/visit/findRegion',
//			 data : {school:school, dateType:"day"},
			 data : $('#comefrom').serialize(),
			 dataType : 'json',
			 success : function(data) {
				data = eval("("+data.message+")");
				
				types = data.types;
				option.legend.data = types;
				option.series[0].name = types[0];
				
				var map = data;
				var i =0;
				var num = 0;
			    for (var key in map) {
			    	if(key != "types"){
			    	option.series[0].data[i].name = key;
					option.series[0].data[i].value = map[key];
					if(types == "跳出率") {
						option.series[0].data[i].value = Number(map[key]);
					}
					if(num < Number(map[key])) {
						num = Number(map[key]);
					}
					i++;
			    	}
			     } 
			    option.dataRange.max=num;
			    if(types == "跳出率") {
			    	option.dataRange.max=100;
				}
				myChart.hideLoading(); 
				myChart.setOption(option,true);
			 }
    	 });
 	}
	</script>
	</body>
	</html>