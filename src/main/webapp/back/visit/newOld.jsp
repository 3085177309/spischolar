<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>新老访客</title>
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
					<c:if test="${yhfx.id == 11 }">class="in"</c:if>>${yhfx.columnName }</a></li>
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
			<a href="#" class="in">新老访客</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<form id="newold"
					action="<cms:getProjectBasePath/>backend/visit/newOld" method="get">
					<div class="pageTopbar clearfix">
						<label for="" class="data-type"> <span class="labt">日期：</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="beginTime" name="beginTime"
									onchange="validate()" value="${beginTime }"
									onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})" />
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									class="tbSearch datechoose" id="endTime" name="endTime"
									onchange="validate()" value="${endTime }"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})" />
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
							<input type="hidden" id ="type" name="type" value="${type }">
						</div>
					</label>
					</c:if> --%>
						<div class="clear"></div>
					</div>
				</form>
				<div class="visitor">
					<div class="newvis">
						<div class="radius">
							<div class="faxtable">
								<div class="thead">新访客</div>
								<div class="tbody">
									<p>
										<c:forEach items="${list }" var="list" varStatus="stat">
											<c:if test="${list.memberType ==0 }">
												<c:forEach items="${quotas }" var="quota" varStatus="stat">
													<c:if test="${quota.id==1 }">
														<span class="col-sm-4">浏览量（PV）：${list.pv }</span>
													</c:if>
													<c:if test="${quota.id==2 }">
														<span class="col-sm-4">访客数：${list.uv }</span>
													</c:if>
													<c:if test="${quota.id==4 }">
														<span class="col-sm-4">平均访问时长：${list.avgTime }</span>
													</c:if>
													<c:if test="${quota.id==5 }">
														<span class="col-sm-4">平均访问页数：${list.avgPage }</span>
													</c:if>
													<c:if test="${quota.id==6 }">
														<span class="col-sm-4">跳出率：${list.jump }</span>
													</c:if>
												</c:forEach>
												<span class="col-sm-4">所占比重：${list.proportion }</span>
												<span class="col-sm-4">注册用户：${list.register }</span>
											</c:if>
										</c:forEach>
									</p>
								</div>
							</div>
							<table class="tc bdTopnone" id="newBrowseCountTable">
							</table>
						</div>
						<div class="page" id="page">
							<a class="a1">${newTotal}条</a>
							<pg:pager items="${newTotal}" url="" export="cp=pageNumber"
								maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
								<pg:first>
									<a onclick="changePage(1)">首页</a>
								</pg:first>
								<label class="changepage"> <!-- 中间页码开始 --> <pg:page>
										<c:if test="${count/20 gt 5 and (cp gt 3)}">
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
										<c:if test="${count/20 gt 5 and (count/20 gt (cp+2))}">
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
									<a class="a1" onclick="go('${pageNumber}')">GO</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
					<div class="oldvis">
						<div class="radius">
							<div class="faxtable">
								<div class="thead">老访客</div>
								<div class="tbody">
									<p>
										<c:forEach items="${list }" var="list" varStatus="stat">
											<c:if test="${list.memberType ==1 }">
												<c:forEach items="${quotas }" var="quota" varStatus="stat">
													<c:if test="${quota.id==1 }">
														<span class="col-sm-4">浏览量（PV）：${list.pv }</span>
													</c:if>
													<c:if test="${quota.id==2 }">
														<span class="col-sm-4">访客数：${list.uv }</span>
													</c:if>
													<c:if test="${quota.id==4 }">
														<span class="col-sm-4">平均访问时长：${list.avgTime }</span>
													</c:if>
													<c:if test="${quota.id==5 }">
														<span class="col-sm-4">平均访问页数：${list.avgPage }</span>
													</c:if>
													<c:if test="${quota.id==6 }">
														<span class="col-sm-4">跳出率：${list.jump }</span>
													</c:if>
												</c:forEach>
												<span class="col-sm-4">所占比重：${list.proportion }</span>
												<%-- <span class="col-sm-4">转化率：${newOld.newChange }</span> --%>
												<span class="col-sm-4">注册用户：${list.register }</span>
											</c:if>
										</c:forEach>
									</p>
								</div>
							</div>
							<table class="tc bdTopnone" id="oldBrowseCountTable">
							</table>
						</div>
						<div class="page" id="page">
							<a class="a1">${oldTotal}条</a>
							<pg:pager items="${oldTotal}" url="" export="cp=pageNumber"
								maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
								<pg:first>
									<a onclick="changePageOld(1)">首页</a>
								</pg:first>
								<label class="changePageOld"> <!-- 中间页码开始 --> <pg:page>
										<c:if test="${count/20 gt 5 and (cp gt 3)}">
								...
							</c:if>
									</pg:page> <pg:pages>
										<c:choose>
											<c:when test="${cp eq pageNumber }">
												<span>${pageNumber }</span>
											</c:when>
											<c:otherwise>
												<a class="a1" onclick="changePageOld(${pageNumber})">${pageNumber}</a>
											</c:otherwise>
										</c:choose>
									</pg:pages> <pg:page>
										<c:if test="${count/20 gt 5 and (count/20 gt (cp+2))}">
								...
							</c:if>
									</pg:page> <pg:next>
										<a class="a1" onclick="changePageOld(${pageNumber})">下一页</a>
									</pg:next>
								</label>
								<pg:last>
									<a onclick="changePageOld(${pageNumber})">末页</a>
								</pg:last>
								<input type="text" onkeyup="clearNotInt(this)" id="goOld"
									style="width: 50px;" size="5">
								<pg:last>
									<a class="a1" onclick="goOld('${pageNumber}')">GO</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<!-- 初始化日期 -->
	<script type="text/javascript">
	/**
	 * 只能输入正整数
	 */
	function clearNotInt(obj){
	  obj.value = obj.value.replace(/[^\d]/g,"");
	}
	//跳转翻页
	function go(maxPage){
		var page = $('#go').val();
		page = Number(page);
		if(page == "") {
			return false;
		}
		if(page > maxPage) {
			alert("超出页码范围！");
			return false;
		}
		if(page<1) {
			alert("超出页码范围！");
			return false;
		}
		changePage(page);
	}
	//跳转翻页
	function goOld(maxPage){
		var page = $('#goOld').val();
		page = Number(page);
		var offset = (page -1)*10;
		if(page == "") {
			return false;
		}
		if(page > maxPage) {
			alert("超出页码范围！");
			return false;
		}
		if(page<1) {
			alert("超出页码范围！");
			return false;
		}
		changePageOld(page);
	}
	
		var beginTime = $("#beginTime").val();
		var endTime = $("#endTime").val();
		var type = $("#type").val();
		var offset = 0;
		var newTotal = ${newTotal};
		var oldTotal = ${oldTotal};
		$(document).ready(function(){
		  var vs = ${day};
		  $("input[name=day][value="+vs+"]").attr("checked",'checked');
		  var type= ${type};
		  if(type=="0"){
			  $("#section_lx").html("原始数据");
		  }else{
			  $("#section_lx").html("添加数据");
		  }
		  newBrowseCountImp();
		  oldBrowseCountImp();
		});
		$('.type').click(function(){
			var type = $(this).attr('id');
			$("#type").val(type);
			validate();
		});
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
				layer.alert("请选择开始日期");
				$("#beginTime").focus();
				return false;
			}
			if(""==endtime){
				layer.alert("请选择结束日期");
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
				layer.alert('开始日期大于结束日期，请检查');
				$("#beginTime").focus();
			    return false;
			}
			$('form#newold').submit();
		}
		function newBrowseCountImp() {
			$.ajax({
	            async : true,
	            cache : false,
	            type : 'POST',
	            url : "<cms:getProjectBasePath/>backend/visit/newOld/newBrowseCountImp",
	            data : {"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset},
	            success : function(data) {
	               data = eval("("+data.message+")");
	               createNewBrowseCount(data);
	            }
	        });
		}
		function createNewBrowseCount(data){
			$("#newBrowseCountTable").empty();
			var jsAr = new Array();
			jsAr.push("<tr><th width='40px'><span class='c05a'>序号</span></th><th><span class='c05a'>来源网站</span></th><th width='160px;'><span class='c05a'>所属单位</span></th><th width='100px'><span class='c05a'>浏览量</span></th></tr>");
			for(var i=0; i<data.length; i++){
				var refOrg = data[i].refOrg;
				if(refOrg == null) {
					refOrg = '';
				}
				jsAr.push("<tr><td><span>"+(offset+i+1)+"</span></td><td><span>"+data[i].refererUrl+"</span></td><td><span>"+refOrg+"</span></td><td><span>"+data[i].pv+"</span></td></tr>");
			}
			$("#newBrowseCountTable").append(jsAr);
		}
		function oldBrowseCountImp() {
			$.ajax({
	            async : true,
	            cache : false,
	            type : 'POST',
	            url : "<cms:getProjectBasePath/>backend/visit/newOld/oldBrowseCountImp",
	            data : {"beginTime":beginTime,"endTime":endTime,"type":type,"offset":offset},
	            success : function(data) {
	               data = eval("("+data.message+")");
	               createOldBrowseCount(data);
	            }
	        });
		}
		function createOldBrowseCount(data){
			$("#oldBrowseCountTable").empty();
			var jsAr = new Array();
			jsAr.push("<tr><th width='40px'><span class='c05a'>序号</span></th><th><span class='c05a'>来源网站</span></th><th width='160px;'><span class='c05a'>所属单位</span></th><th width='100px'><span class='c05a'>浏览量</span></th>");
			for(var i=0; i<data.length; i++){
				var refOrg = data[i].refOrg;
				if(refOrg == null) {
					refOrg = '';
				}
				jsAr.push("<tr><td><span>"+(offset+i+1)+"</span></td><td><span>"+data[i].refererUrl+"</span></td><td><span>"+refOrg+"</span></td><td><span>"+data[i].pv+"</span></td></tr>");
			}
			$("#oldBrowseCountTable").append(jsAr);
		}
		function changePage(pageNum){
			offset=(pageNum-1)*20;
			newBrowseCountImp();
			$(".changepage").empty();
			var pageAr = new Array();
			var s = newTotal%20;
			var a=newTotal/20;
			//向上去整  2.22 即是 3
			a=Math.ceil(a);
			if(pageNum!=1 && a!=0){
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>上一页</a>");
			}
			if(pageNum>2 && a>5){
				if(pageNum==a){
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-4)+")'>"+(pageNum-4)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
				}else if(pageNum==(a-1)){
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				}else{
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
					pageAr.push("<a class='a1' onclick='changePage("+(pageNum+2)+")'>"+(pageNum+2)+"</a>");
				}
			}else{
				for(var i=1; i<=a; i++){
					if(i<=5){
						if(i==pageNum){
							pageAr.push("<span>"+pageNum+"</span>");
						}else{
							pageAr.push("<a class='a1' onclick='changePage("+i+")'>"+i+"</a>");
						}
					}
				}
			}
			if(pageNum!=a && a!=0){
				pageAr.push("<a class='a1' onclick='changePage("+(pageNum+1)+")'>下一页</a>");
			}
			$(".changepage").append(pageAr);
		}
		function changePageOld(pageNum){
			offset=(pageNum-1)*20;
			oldBrowseCountImp();
			$(".changePageOld").empty();
			var pageAr = new Array();
			var s = oldTotal%20;
			var a=oldTotal/20;
			//向上去整  2.22 即是 3
			a=Math.ceil(a);
			if(pageNum!=1 && a!=0){
				pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-1)+")'>上一页</a>");
			}
			if(pageNum>2 && a>5){
				if(pageNum==a){
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-4)+")'>"+(pageNum-4)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
				}else if(pageNum==(a-1)){
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-3)+")'>"+(pageNum-3)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
				}else{
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-2)+")'>"+(pageNum-2)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum-1)+")'>"+(pageNum-1)+"</a>");
					pageAr.push("<span>"+pageNum+"</span>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum+1)+")'>"+(pageNum+1)+"</a>");
					pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum+2)+")'>"+(pageNum+2)+"</a>");
				}
			}else{
				for(var i=1; i<=a; i++){
					if(i<=5){
						if(i==pageNum){
							pageAr.push("<span>"+pageNum+"</span>");
						}else{
							pageAr.push("<a class='a1' onclick='changePageOld("+i+")'>"+i+"</a>");
						}
					}
				}
			}
			if(pageNum!=a && a!=0){
				pageAr.push("<a class='a1' onclick='changePageOld("+(pageNum+1)+")'>下一页</a>");
			}
			$(".changePageOld").append(pageAr);
		}
  //获取时间
    var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);				//今天
    if($("#beginTime").val()==""){
    	$("#beginTime").val(now);
        $("#endTime").val(now);
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
</div>
</body>
</html>
