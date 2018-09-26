<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>文献互助统计</title>
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
					<c:if test="${nrfx.id == 36 }">class="in"</c:if>>${nrfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">内容分析</a>>
			<a href="#" class="in">文献互助统计</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="comefrom" action="" method="get">
						<%-- <c:if test="${org.flag=='wdkj' }">
					<label class="data-type">
						<span class="labt">学校:</span>
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
									<p class="school" onclick='change("${org.flag }",1)' schoolId="${org.id }">${org.name }</p>
								</c:forEach>
							</div>
							
						</div>
					</label>
					</c:if> --%>
						<input type="hidden" name="school" id="school" value=""> <label
							for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text"
									value="${beginTime }" class="tbSearch datechoose"
									id="beginTime" name="beginTime" onchange="validate()"
									onClick="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" value="${endTime }"
									class="tbSearch datechoose" id="endTime" name="endTime"
									onchange="validate()"
									onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
						</label>
						<%-- <label class="data-type">
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
					</label> --%>
						<input type="hidden" id="sort" name="sort" value="${sort }">

						<label class="common"> <input type="text"
							class="tbSearch keyword" name="key" value="${key }"
							placeholder="请输入学校名检索"> <input class="tbBtn"
							type="submit" value="查询" />
						</label>
					</form>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<table class="data-table">
						<tr>
							<th width="80px">序号</th>
							<th width="30%">学校</th>
							<th class="sort num" type="num" sort='down'>总请求量</th>
							<th class="sort successTime" type="successTime" sort='down'>传递成功率</th>
							<th class="sort userNum" type="userNum" sort='down'>请求用户数</th>
							<th class="sort avgUser" type="avgUser" sort='down'>人均请求量</th>
							<th class="sort avgDay" type="avgDay" sort='down'>日均请求量</th>
						</tr>
						<c:forEach items="${pager.rows }" var="lists" varStatus="status">
							<tr>
								<td><span>${status.index+1+offset }</span></td>
								<td><span> <a class="schoolSearch"
										org_falg="${lists.orgFlag }">${lists.orgName }</a>
								</span></td>
								<td><span>${lists.num }</span></td>
								<td><span>${lists.successTime }%</span></td>
								<td><span>${lists.userNum }</span></td>
								<td><span>${lists.avgUser }</span></td>
								<td><span>${lists.avgDay }</span></td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<div class="page" id="page">
					<a class="a1">${pager.total}条</a>
					<pg:pager items="${pager.total}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="beginTime" />
						<pg:param name="endTime" />
						<pg:param name="school" />
						<pg:param name="sort" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${pager.total/20 gt 5 and (cp gt 3)}">
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
							<c:if
								test="${pager.total/20 gt 5 and (pager.total/20 gt (cp+2))}">
								...
							</c:if>
						</pg:page>
						<pg:next>
							<a class="a1" href="${pageUrl}">下一页</a>
						</pg:next>
						<pg:last>
							<a href="${pageUrl}">末页</a>
						</pg:last>


						<input type="text" onkeyup="clearNotInt(this)" id="go"
							style="width: 50px;" size="5">
						<pg:last>
							<a class="a1" onclick="go('${pageUrl}')">go</a>
						</pg:last>
					</pg:pager>
				</div>

				<div class="databottom clearfix">
					<span class="thickBtn downOut fr" data-thickcon="export">导出</span>
				</div>

				<div class="tickbox">
					<div id="export" class="export" data-tit="导出">
						<form id="exportForm"
							action="<cms:getProjectBasePath/>backend/contentAnalysis/deliveryRecord/download"
							method="get">
							<ul>
								<li><c:if test="${org.flag=='wdkj' }">
										<label class="data-type"> <span class="labt">学校：</span>
											<span id="section_lx">全部学校</span> <input type="hidden"
											id="downSchool" name="school" value="${school }">
										</label>
									</c:if></li>
								<li><label for="" class="data-type"> <span
										class="labt">时间范围：</span>
										<div class="datebox">
											<i class="inc uv13"></i> <input type="text"
												class="tbSearch datechoose" style="*text-indent: 0"
												id="exportBeginTime" value="${beginTime }"
												readonly="readonly" name="beginTime"
												onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'exportEndTime\')}',readOnly:true})">
										</div> <span class="labm">至</span>
										<div class="datebox">
											<i class="inc uv13"></i> <input type="text"
												class="tbSearch datechoose" id="exportEndTime"
												name="endTime" value="${endTime }" readonly="readonly"
												onfocus="WdatePicker({minDate:'#F{$dp.$D(\'exportBeginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
										</div>
								</label> <label class="data-type data-type-s"> <span
										class="labt">数据类型:</span>
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
												<p href="javascript:void(0)" onclick="change(-1,2)">所有数据</p>
												<p href="javascript:void(0)" onclick="change(0,2)">原始数据</p>
												<p href="javascript:void(0)" onclick="change(1,2)">添加数据</p>
											</div>
											<input type="hidden" id="downType" name="type"
												value="${type }">
										</div>
								</label></li>
								<input type="hidden" name="content" id="downContent"
									value="检索分析">

							</ul>
							<div class="tc">
								<input type="button" onclick="exports()" class="btnEnsure btn"
									value="确认导出"> <a href="" class="btnCancle btn">取消</a>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
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
	
	/**排序*/
	function order(order) {
		$('#order').val(order);
		$('#comefrom').submit();
	}
	//切换学校和数据类型
	function change(val,type){
		if(type == 1) {
			$("#school").val(val);
		} else if(type == 2) {
			$("#downType").val(val);
		}
		//$('#comefrom').submit();
	}

	function validate(){
    	$('#comefrom').submit();
    }
	
	//获取时间
    var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);                 //今天
    
    var time = '${beginTime }';
    if(time == '') {
    	 $("#beginTime").val(now);
    	 $("#endTime").val(now);
    }
    
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
  
    $('.schoolSearch').click(function(){
    	var orgFlag = $(this).attr("org_falg");
    	$('#school').val(orgFlag);
    	$('#comefrom').submit();
    })
     function exports() {
		$("#exportForm").submit();
	}
	</script>

	</body>
	</html>