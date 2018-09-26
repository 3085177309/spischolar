<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>访客来源</title>
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
					<c:if test="${yhfx.id == 12 }">class="in"</c:if>>${yhfx.columnName }</a></li>
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
			<a href="#" class="in">访客来源</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="comefrom" action="" method="get">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校:</span>
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
										<p class="school" onclick="change('',1)">全部学校</p>
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
						<%-- 	<c:if test="${org.flag=='wdkj' }">
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
					</form>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<table class="data-table">
						<tr>
							<th width="40px">序号</th>
							<c:if test="${school == null }">
								<th><span>学校</span></th>
							</c:if>
							<c:if test="${school != null }">
								<th><span>来源网站</span></th>
								<th><span>网址机构</span></th>
							</c:if>
							<c:forEach items="${quotas }" var="quo" varStatus="statu">
								<c:if test="${quo.id!=5 && quo.id!=7 && quo.id!=8 }">
									<th><span sort="down" style="text-align: center;"
										<c:if test="${quo.id==6}">class="sort jump" type="jump"</c:if>
										<c:if test="${quo.id==4}">class="sort avgTime" type="avgTime"</c:if>
										<c:if test="${quo.id==3}">class="sort ip" type="ip"</c:if>
										<c:if test="${quo.id==2}">class="sort uv" type="uv"</c:if>
										<c:if test="${quo.id==1}">class="sort pv" type="pv"</c:if>>${quo.quotaName }</span></th>
								</c:if>
							</c:forEach>
						</tr>
						<c:forEach items="${list }" var="lists" varStatus="status">
							<tr
								<c:if test="${status.index+1 == fn:length(list) && school != null  }">style="display: none;"</c:if>>
								<td><span>${status.index+1 + offset }</span></td>
								<c:if test="${school == null }">
									<td><span><a href="#"
											onclick='change("${lists.schoolFlag }",1)'> <c:forEach
													items="${orgList }" var="org" varStatus="status">
													<c:if test="${org.flag == lists.schoolFlag }">
													${org.name }
												</c:if>
												</c:forEach>
										</a></span></td>
								</c:if>
								<c:if test="${school != null }">
									<td><a href="${lists.refererUrl }" target="_break"
										title="${lists.refererUrl }"> <c:choose>
												<c:when test="${fn:length(lists.refererUrl) < 50 }">
                         					${lists.refererUrl }
                         					</c:when>
												<c:otherwise>
                         						${lists.refererUrl.substring(0,42) }...
                         					</c:otherwise>
											</c:choose>
									</a></td>
									<td><span>${lists.refererOrg }</span></td>
								</c:if>
								<c:forEach items="${quotas }" var="quota" varStatus="stat">
									<c:if test="${quota.id==1 }">
										<td><span>${lists.pv }</span></td>
									</c:if>
									<c:if test="${quota.id==2 }">
										<td><span>${lists.uv }</span></td>
									</c:if>
									<c:if test="${quota.id==3 }">
										<td><span>${lists.ip }</span></td>
									</c:if>
									<c:if test="${quota.id==4 }">
										<td><span>${lists.avgTime }</span></td>
									</c:if>
									<c:if test="${quota.id==6 }">
										<td><span>${lists.jump }% </span></td>
									</c:if>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
					<c:if test="${school != null }">
						<table class="data-table sum">
							<c:if test="${fn:length(list) != 0 }">
								<c:forEach items="${list }" var="lists"
									begin="${fn:length(list)-1 }">
									<tr>
										<td width="40px"><span>总计</span></td>
										<td><span></span></td>
										<td><span></span></td>
										<c:forEach items="${quotas }" var="quota" varStatus="stat">
											<c:if test="${quota.id==1 }">
												<td><span>${lists.pv }</span></td>
											</c:if>
											<c:if test="${quota.id==2 }">
												<td><span>${lists.uv }</span></td>
											</c:if>
											<c:if test="${quota.id==3 }">
												<td><span>${lists.ip }</span></td>
											</c:if>
											<c:if test="${quota.id==4 }">
												<td><span>${lists.avgTime }</span></td>
											</c:if>
											<c:if test="${quota.id==6 }">
												<td><span>${lists.jump }% </span></td>
											</c:if>
										</c:forEach>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</c:if>
				</div>

				<div class="page" id="page">
					<a class="a1">${count}条</a>
					<pg:pager items="${count}" url="" export="cp=pageNumber"
						maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="beginTime" />
						<pg:param name="endTime" />
						<pg:param name="type" />
						<pg:param name="school" />
						<pg:param name="day" />
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


						<input type="text" onkeyup="clearNotInt(this)" id="go"
							style="width: 50px;" size="5">
						<pg:last>
							<a class="a1" onclick="go('${pageUrl}')">GO</a>
						</pg:last>
					</pg:pager>
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
		var offset = (page -1)*10;
		if(page == "") {
			return false;
		}
		var arr = new Array();
		arr = url.split("offset=");
		
		if(page*10-10 > arr[1]) {
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
			$("#type").val(val);
		}
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
	</script>

	</body>
	</html>