<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>访问流量</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv00"></span> 流量分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.llfx }" var="llfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${llfx.url}"
					<c:if test="${llfx.id == 9 }">class="in"</c:if>>${llfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">流量分析</a>>
			<a href="#" class="in">访问流量</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form id="inputForm">
						<input type="hidden" id="sort" name="sort">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校:</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i> <span id="section_lx">全部学校</span>
									<div class="sc_selopt" style="display: none;">
										<p value="all" onclick='change("全部学校","all",1)'>全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school"
												onclick='change("${org.name }","${org.flag }",1)'>${org.name }</p>
										</c:forEach>
									</div>
								</div>
							</label>
							<!-- <input type="hidden" id="type" name="type" value="0"> -->
							<input type="hidden" id="schoolVal" name="school" value="all">
							<input type="hidden" id="schoolValName" name="schoolName"
								value="全部学校">
							<input type="hidden" id="school" name="compareSchool" value="all"
								class="compareSchool">
							<input type="hidden" id="schoolName" name="compareSchoolName"
								value="全部学校">
						</c:if>
						<c:if test="${org.flag!='wdkj' }">
							<input type="hidden" id="schoolVal" name="school"
								value="${org.flag }">
							<input type="hidden" id="schoolValName" name="schoolName"
								value="${org.name }">
							<input type="hidden" id="school" name="compareSchool"
								value="${org.flag }" class="compareSchool">
							<input type="hidden" id="schoolName" name="compareSchoolName"
								value="${org.name }">
						</c:if>
						<input type="hidden" id="type" name="type" value="0"> <input
							type="checkbox" style="display: none" value=""
							name="compareSchool" class="compareSchool"> <input
							type="checkbox" style="display: none" value=""
							name="compareSchool" class="compareSchool"> <input
							type="checkbox" style="display: none" name="compareSchoolName"
							class="compareSchoolName" value=""> <input
							type="checkbox" style="display: none" name="compareSchoolName"
							class="compareSchoolName" value="">
						<!-- 日历 -->
						<label for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" id="beginTime"
									class="tbSearch datechoose" name="beginTime"
									onchange="department()"
									onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}'})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" id="endTime"
									class="tbSearch  datechoose" name="endTime"
									onchange="department()"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d'})">
							</div>
						</label>
						<c:if test="${org.flag!='wdkj' }">
							<input type="hidden" class="tbRadio" name="day" value="3">
						</c:if>
						<c:if test="${org.flag=='wdkj' }">
							<label for="today" class="data-type"> <input type="radio"
								class="tbRadio" name="day" value="1" checked="checked">
								<span>按日</span>
							</label>
							<label for="sevenday" class="data-type"> <input
								type="radio" class="tbRadio" name="day" value="2"> <span>按周</span>
							</label>
							<label for="month" class="data-type"> <input type="radio"
								class="tbRadio" name="day" value="3"> <span>按月</span>
							</label>
							<!-- <label class="data-type">
							<span class="labt">数据类型:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<span id="section_lx">原始数据</span>
								<div class="sc_selopt" style="display: none;">
									<p onclick='change("",0,2)'>原始数据</p>
									<p onclick='change("",-1,2)'>添加数据</p>
								</div>
								<input type="hidden" name="type" id="type" value="0">
							</div>
						</label> -->
						</c:if>
						<div class="clear"></div>
				</div>

				<div class="radius">
					<div class="databox traffic-query">
						<c:if test="${org.flag=='wdkj' }">
							<div class="datahead bighead">
								<span class="thickBtn" data-thickcon="schoolTick"> <i></i>加入对比
								</span>
								<div class="current-schoolsed"></div>
							</div>
						</c:if>
						<div class="dbhead">
							<div class="dataActchoice">
								<c:forEach items="${quotas }" var="quo" varStatus="status">
									<c:if test="${quo.id!=7 && quo.id!=8 }">
										<label for="sevenday" class="data-type"> <input
											type="checkbox" class="types" name="types"
											value="${quo.quotaName }"
											<c:if test="${status.index==0 }">checked="checked"</c:if>>
											<span>${quo.quotaName }</span>
										</label>
									</c:if>
								</c:forEach>
							</div>
						</div>
						</form>
						<div class="databody">
							<div class="echart" id="echart" style="height: 400px"></div>
						</div>
						<c:if test="${org.flag == 'wdkj' }">
							<div class="table">
								<table class="data-table" id="data-table">
									<tr>
										<td>序号</td>
										<td>学校</td>
										<td>浏览量（PV）</td>
										<td>访客数（UV）</td>
										<td>IP数</td>
										<td>平均访问时长</td>
										<td>平均访问页数</td>
										<td>跳出率</td>
									</tr>
								</table>
							</div>
						</c:if>
					</div>
				</div>
				<div class="databottom clearfix">
					<span href="#" class="thickBtn downOut fr" data-thickcon="export">导出</span>
				</div>
				<!-- 导出弹窗 -->
				<div class="tickbox">
					<div id="export" class="export flowquery" data-tit="导出">
						<form id="exportForm"
							action="<cms:getProjectBasePath/>backend/flow/flowQuery/download"
							method="get">
							<ul>
								<li><c:if test="${org.flag=='wdkj' }">
										<label class="data-type"> <span class="labt">选择学校：</span>
											<div class="sc_selbox" style="*z-index: 99">
												<i class="inc uv21"></i> <span id="section_lx"
													class="down org">${org.name }</span>
												<div class="sc_selopt" style="display: none;">
													<p onclick='downChange("全部学校","all",1)'>全部学校</p>
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<p class="school"
															onclick='downChange("${org.name }","${org.flag }",1)'>${org.name }</p>
													</c:forEach>
												</div>
												<input type="hidden" id="downSchoolName" name="schoolName"
													value="${org.name }"> <input type="hidden"
													id="downSchool" name="school" value="${org.flag }">
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
												class="tbSearch datechoose" id="exportBeginTime"
												name="beginTime"
												onClick="WdatePicker({maxDate:'#F{$dp.$D(\'exportEndTime\')}',readOnly:true})">
										</div> <span class="labm">至</span>
										<div class="datebox">
											<i class="inc uv13"></i> <input type="text"
												class="tbSearch datechoose" id="exportEndTime"
												name="endTime"
												onClick="WdatePicker({minDate:'#F{$dp.$D(\'exportBeginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
										</div>
								</label></li>
								<li><span class="fl">流量指标：</span>
									<div class="ovh">
										<c:forEach items="${quotas }" var="quo" varStatus="status">
											<c:if test="${quo.id!=7 && quo.id!=8 }">
												<label for="month" class="data-type"> <input
													type="checkbox" class="tbcheckbox downTypes" name="types"
													value="${quo.quotaName }"
													<c:if test="${status.index == 0 }">checked = checked</c:if>>
													<span>${quo.quotaName }</span>
												</label>
											</c:if>
										</c:forEach>
										<c:if test="${quotas.size() gt 1 }">
											<span class="texttips">（可多选）</span>
										</c:if>
									</div></li>
								<c:if test="${org.flag=='wdkj' }">
									<li><label class="data-type"> <span class="labt">数据类型：</span>
											<div class="sc_selbox">
												<i class="inc uv21"></i>
												<c:if test="${type == -1 }">
													<span class="down type">所有数据</span>
												</c:if>
												<c:if test="${type == 0 }">
													<span class="down type">原始数据</span>
												</c:if>
												<c:if test="${type == 1 }">
													<span class="down type">添加数据</span>
												</c:if>
												<div class="sc_selopt" style="display: none;">
													<p href="javascript:void(0)" onclick="downChange('',-1,2)">所有数据</p>
													<p href="javascript:void(0)" onclick="downChange('',0,2)">原始数据</p>
													<p href="javascript:void(0)" onclick="downChange('',1,2)">添加数据</p>
												</div>
												<input type="hidden" name="type" id="downType"
													value="${type }">
											</div>
									</label></li>
								</c:if>
							</ul>
							<div class="tc">
								<input type="button" onclick="exports()" class="btnEnsure btn"
									value="确认导出"> <a href="" class="btnCancle btn">取消</a>
							</div>
						</form>
					</div>
					<!-- 加入对比弹窗 -->
					<div id="schoolTick" class="schoolTick"
						data-tit="选择学校<em>(可多选)</em>">
						<div class="">
							<div class="schoolChecked">
								<span class="hd">已选学校：</span>
								<div class="list"></div>
							</div>
							<div class="provinceBox">
								<c:forEach items="${pList }" var="p" varStatus="status">
									<span>${p.province }</span>
								</c:forEach>
							</div>
							<div class="schoolselect">
								<c:forEach items="${pList }" var="p" varStatus="status">
									<ul>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${p.province==org.province}">
												<%-- <li onclick="compareSchool('${org.name }','${org.flag }')">${org.name }</li> --%>
												<li v="${org.flag }">${org.name }</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:forEach>
							</div>
						</div>
						<div class="tc">
							<a class="btnEnsure btn" id="enSureSchool">确认</a> <a href=""
								class="btnCancle btn">取消</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

	<script type="text/javascript">
    //获取时间
    var now = new Date();
    var nowDayOfWeek = now.getDay();         //今天本周的第几天  
    var nowDay = now.getDate();              //当前日  
    var nowMonth = now.getMonth();           //当前月  
    var nowYear = now.getFullYear();         //当前年
    now = formatDate(now,0);                 //今天
    $(".datechoose").val(now);
    
    var schoolFlag = $('#school').val();
    if(schoolFlag != 'all') {
    	var oldYear = nowYear -1;
    	var oldMonth = nowMonth+1;
    	var monthStartDate = new Date(oldYear, oldMonth, 1);   
        var oldTime = formatDate(monthStartDate,0);
        $('#beginTime').val(oldTime);
    }
    
    //改变时间
    $(".tbRadio").click(function(){
    	department();
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
	    	var schoolselect=$(".schoolselect"),
	    		provinceBox=$(".provinceBox"),
	    		schoolChecked=$(".schoolChecked .list"),
	    		thickBtn=$(".datahead .thickBtn"),
	    		currentVal=0,
		    	schoolName=$('input[name=compareSchoolName]'),
		    	currentschoolsed=$(".current-schoolsed");
	    	
	    	initschoolset();
	    	
	    	schoolselect.find("ul").eq(0).show();
	    	provinceBox.find("span").eq(0).addClass("in");
	    	tab(provinceBox[0].getElementsByTagName("span"),schoolselect[0].getElementsByTagName("ul"));
	    	
	    	//更新current-schoolsed操作数据到input
	    	function updateOptdata(){
	    		var currentschool=$(".current-schoolsed").find("span");
	    		var compareSchool=$('.compareSchool');
	    		var compareSchoolName=$('input[name="compareSchoolName"]');
	    		for(var i=0;i<3;i++){
					if(currentschool.eq(i).attr("v")&&currentschool.eq(i).attr("v")!=""){
						compareSchool.eq(i).val(currentschool.eq(i).attr("v"));
		    			compareSchool.eq(i).attr("checked",true);
		    			compareSchoolName.eq(i).attr("checked",true);
		    			compareSchoolName.eq(i).val(currentschool.eq(i).text());
	    			}else{
	    				compareSchool.eq(i).attr("checked",false);
	    				compareSchool.eq(i).val("");
	    				compareSchoolName.eq(i).attr("checked",false)
	    				compareSchoolName.eq(i).val("")
	    			}
	    			
	    		}
	    		return false;
	    	}
	    	//更新schoolChecked .list的的数据到input 
	    	function updatalistData(){
	    		var currentschool=$(".schoolChecked .list").find("span");
	    		var compareSchool=$('.compareSchool');
	    		var compareSchoolName=$('input[name="compareSchoolName"]');
	    		for(var i=0;i<3;i++){
	    			if(currentschool.eq(i).attr("v")&&currentschool.eq(i).attr("v")!=""){
						compareSchool.eq(i).val(currentschool.eq(i).attr("v"));
		    			compareSchool.eq(i).attr("checked",true);
		    			compareSchoolName.eq(i).attr("checked",true);
		    			compareSchoolName.eq(i).val(currentschool.eq(i).text());
	    			}else{
	    				compareSchool.eq(i).attr("checked",false);
	    				compareSchoolName.eq(i).attr("checked",false)
	    				compareSchoolName.eq(i).val("");
	    				compareSchool.eq(i).val("");
	    			}
	    			
	    		}
	    		return false;
	    	}
	    	//获取数据到显示元素
	    	function getdatafrominput(){
	    		var compareSchool=$('.compareSchool');
	    		var compareSchoolName=$('input[name="compareSchoolName"]');
	    		var str="";
	    		for(var i=0;i<compareSchool.length;i++){
	    			if(compareSchool.eq(i).val()!=""&&compareSchoolName.eq(i).val()!=""){
	    				str=str+'<span class="schbtn" v='+compareSchool.eq(i).val()+' >'+compareSchoolName.eq(i).val()+'<i></i></span>';
	    			}
	    		}
	    		return str
	    	}
	    	//加载数据初始化
	    	function initschoolset(){
	    		var str=getdatafrominput()
	    		currentschoolsed.html("").append(str);
	    		schoolChecked.html("").append(str);
	    		return false;
	    	}
	    	//删除当前已选
			function removeSchbtn(){ 
	    		$(".schbtn").find("i").on("click",function(){
	    			var index=$(this).parents("span").index();
	    			var schoolChinese = $(this).parents("span").html();
	    			var schoolEname=$(this).parents("span").attr("v");

					/*取消下面选择列表变灰*/
					$(".schoolselect li[v='"+schoolEname+"']").removeClass("hui");
	    			
		    		if(index){
		    			$(this).parents("span").remove();
		    		}else{
		    			layer.alert("默认对比数据，不可删除！");
		    		}
		    		if($(this).parents(".current-schoolsed")){
		    			updateOptdata();
		    			department();
		    			return false;
		    		}
	    			return false;
	    		})
	    	}
	    	$(".thickBtn").on("click",function(){
	    		var str=getdatafrominput()
	    		schoolChecked.html("").append(str);
	    		removeSchbtn();
	    	})
	    	//弹窗提交数据更新
			$("#enSureSchool").on('click',function(){
				updatalistData();
	    		getdatafrominput();
	    		var str=getdatafrominput()
	    		currentschoolsed.html("").append(str);
	    		removeSchbtn();
	    		department();
	    		//默认选中第一个：浏览量
	    		$(".types").removeAttr("checked");
	    		$(".types").eq(0).attr("checked",true);
	    		$(".thickWarp").hide();
	    	})
	    	//current-schoolsed操作
	    	 $(".current-schoolsed span").on("click",function(){
	    		updateOptdata()
	    		removeSchbtn();
	    		getdatafrominput();
	    	})
	    	//----------------------------------------------on-----
	    	schoolselect.find("ul li").on("click",function(){
	    		var text=$(this).html();
	    		var flag=$(this).attr("v");
	    		var compareSchoolVal=$('.compareSchool');
	    		var compareSchoolNameVal = $('.compareSchoolName');

	    		/*选中变灰*/
	    		var checkElea=schoolChecked.find("span");
	    		if(checkElea.length<3){
		    		$(this).addClass("hui");
	    		}
	    		
	    		var repMaxnumChecked=repMaxnumCheck(text);
	    		
	    		if(repMaxnumChecked){//学校对比
	    				if(currentVal>2) index=0;
	    				compareSchoolVal.eq(currentVal).val(flag).attr("checked","true");
	    				compareSchoolNameVal.eq(currentVal).val(text).attr("checked","true");
	    				currentVal++;
	    		}
	    		
	    		var selected=schoolChecked.append(function(){
	    			return repMaxnumChecked ? '<span class="schbtn" v='+flag+'>'+text+'<i></i></span>': false;
	    		});
	    		
	    		removeSchbtn(text);
	    	})
	    	function repMaxnumCheck(text){//添加长度、重复检查
	    		var checkEle=schoolChecked.find("span"),
	    			chk=true;
	    		checkEle.each(function(){
	    			if($(this).text()==text){
	    				layer.alert("不可重复选择！")
	    				chk=false;
	    			}
	    		})
	    		if(checkEle.length>2){
	    			layer.alert("最多可选择三个学校！")
	    			chk=false;
	    		}
	    		return chk;
	    	}

		function change(name,val,type){
			if(type == 1) {
				var schoolOne = $('.compareSchool').eq(1).val();
				var schoolTwo = $('.compareSchool').eq(2).val();
				if(schoolOne == val || schoolTwo == val) {
					alert("该学校已在对比列表！");
					return;
				}
				$("#school").val(val);
				$("#schoolVal").val(val);
				$('#schoolName').val(name);
				$("#schoolValName").val(name);
			} else if(type == 2) {
				/* $("#type").val(val); */
			}
			initschoolset();
			department();
		}
		function downChange(name,val,type){
			if(type == 1) {
				$("#downSchool").val(val);
				$("#downSchoolName").val(name);
				if(val =='all') {
					$(".downTypes").removeAttr("checked");
		    		$(".downTypes").eq(0).attr("checked",true);
		    		$(".texttips").text('(单选)');
				} else {
					$(".texttips").text('（可多选）');
				}
			} else if(type == 2) {
				$("#downType").val(val);
				if(val == 0) {
		    		$('#exportForm span.down.type').text("原始数据");
		    	} else if(val == 1){
		    		$('#exportForm span.down.type').text("添加数据");
		    	} else {
		    		$('#exportForm span.down.type').text("所有数据");
		    	}
			}
		}
		$('.downTypes').click(function(){
			var val = $("#downSchool").val();
			if(val == 'all') {
				$(".downTypes").removeAttr("checked");
				$(this).attr("checked",true);
			}
		});
		
		$('.types').click(function(){
			var length =  $("input[type='checkbox'][class='types']").length;
			var pv =false, uv =false, ip =false, avgTime =false, hight =false, jump =false;
			
			for(var i=0;i<length;i++) {
				var name = $("input[type='checkbox'][class='types']").eq(i).val();
				//var name = $("input[type='checkbox'][class='types']").eq(i).parents("label").children("span").html();
				if(name == '浏览量（PV）')  {
					pv = $("input[type='checkbox'][class='types']").get(i).checked;
				}
				if(name == '访客数（UV）')  {
					uv = $("input[type='checkbox'][class='types']").get(i).checked;
				}
				if(name == 'IP数')  {
					ip = $("input[type='checkbox'][class='types']").get(i).checked;
				}
				if(name == '平均访问时长')  {
					avgTime = $("input[type='checkbox'][class='types']").get(i).checked;
				}
				if(name == '平均访问页数')  {
					hight = $("input[type='checkbox'][class='types']").get(i).checked;
				}
				if(name == '跳出率')  {
					jump = $("input[type='checkbox'][class='types']").get(i).checked;
				}
			}
			if((pv || uv || ip || hight) && avgTime && jump) {
				layer.alert("PV、UV、IP、平均访问页数与平均访问时长（秒）和跳出率（%）单位类型不同，一次最多只能选择两种单位类型指标");
				return false;
			} 
			var num =$("input[type='checkbox'][class='types']:checked").length;
			if(num <= 0) {
				layer.alert("请至少选择1个指标");
				return false;
			}
			if(num > 4) {
				layer.alert("最多勾选4个指标");
				return false;
			}
			//如果选择对比学校，复选框就只能选一个
			if($("input[type='checkbox'][class='compareSchool']")[0].checked) {
				for(var i=0;i<6;i++) {
					$(".types").removeAttr("checked");
				}
				$(this).attr("checked",true);
			}
			department();
		})
		
		//导出弹出
		$(".downOut").on("click",function(){
			var length =  $("input[type='checkbox'][class='types']").length;
			for(var i=0;i<length;i++) {
				var isChecked = $("input[type='checkbox'][class='types']").get(i).checked;
				if(isChecked) {
					$("#exportForm input[type='checkbox'][class='tbcheckbox downTypes']").eq(i).attr("checked", true);
				}
			}
			var downSchool = $('#downSchool').val();
			if(downSchool == 'all') {
				$(".texttips").text('(单选)');
			} else {
				$(".texttips").text('(可多选)');
			}
		})
		//导出
		function exports() {
			var exportBeginTime = $("#exportBeginTime").val();
			var exportEndTime = $("#exportEndTime").val();
			if(exportBeginTime > exportEndTime || exportEndTime>now) {
				layer.alert("请选择正确的时间");
	    		return false;
	    	}
			var checkNum = $("input[type='checkbox'][class='tbcheckbox downTypes']:checked").length;
			if(checkNum <= 0) {
				layer.alert("请选择要导出的数据");
				return false;
			}
			var downSchool = $('#downSchool').val();
			var length =  $("#exportForm input[type='checkbox'][class='tbcheckbox downTypes'][checked='checked']").length;
			if(downSchool == 'all' && length>1) {
				layer.alert("最多勾选1个指标");
				return false;
			}
			$("#exportForm").submit();
		}
	</script>

	<script type="text/javascript">
    // 路径配置
    require.config({
        paths: {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });
    var myChart;
    var EChartst;
    require([
             'echarts',
             'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
             'echarts/chart/bar'
         ],function(ec){
    	EChartst = ec;
		myChart = ec.init(document.getElementById('echart')); 
		var option = {
     	tooltip: {
     		trigger: 'axis'
         },
         legend: {
        	show : true,
         	data:['','','',''],
         	selectedMode : true
         },
         toolbox: {
 	        show : true,
 	        feature : {
 	            magicType : {show: true, type: ['line', 'bar']},
 	            restore : {show: true}
 	        },
 	       padding : 0
 	    },
         calculable : true,
         xAxis : [
         	{
             	type : 'category',
             	boundaryGap : false,
             	data : ['1']
             }
         ],
         yAxis : [
          	{
             	type : 'value',
             	min:'00:00:00',
                max:'18:00:00'
             },
             {
            	 "type":"",
            	 'name':'',
            	 min:'00:00:00',
                 max:'01:00:00'
             }
         ],
         
         series : [
           	{
             	"name":"",
                 "type":"",
                 data:[0],
                 "yAxisIndex": "",
                 itemStyle:{
                  	emphasis:{
                  		lineStyle:{
                        	color:''
                        }
                    }
                  }
             },
             {
              	"name":"",
                  "type":"",
                  data:[0],
                  "yAxisIndex": "",
                  itemStyle:{
                     	emphasis:{
                     		lineStyle:{
                           	color:''
                           }
                       }
                     }
              },
              {
                	"name":"",
                    "type":"",
                    data:[0],
              		"yAxisIndex": "",
              		itemStyle:{
                       	emphasis:{
                       		lineStyle:{
                             	color:''
                             }
                         }
                       }
                },
                {
                  	"name":"",
                    "type":"",
                    data:[0],
                	"yAxisIndex": "",
                	itemStyle:{
                       	emphasis:{
                       		lineStyle:{
                             	color:''
                            }
                        }
                    }
                  }
         ]
     };
		myChart.setOption(option, true);
		department();
	});
    function department(){
    	var school = $('#school').val();
    	var schoolName = $('#schoolName').val();
    	var beginTime = $('#beginTime').val();
    	var endTime = $('#endTime').val();
    	/* var type = $('#type').val(); */
    	$('#downSchoolName').val(schoolName);
    	$('#downSchool').val(school);
    	$('#exportForm span.down.org').text(schoolName);
    	$('#exportBeginTime').val(beginTime);
    	$('#exportEndTime').val(endTime);
    	//$('#downType').val(type);
    	/* if(type == 0) {
    		$('#exportForm span.down.type').text("原始数据");
    	} else if(type == 1){
    		$('#exportForm span.down.type').text("添加数据");
    	} else {
    		$('#exportForm span.down.type').text("所有数据");
    	} */
    	
    	if(beginTime > endTime || endTime>now) {
    		layer.alert("请选择正确的时间");
    		return false;
    	}
    	var option = myChart.getOption();
    	$.ajax({
			 type : "post",
			 url : '<cms:getProjectBasePath/>backend/flow/flowQuery/table',
			 data : $('#inputForm').serialize(),
			 dataType : 'json',
			 success : function(data) {
				 data = eval("("+data.message+")");
				 var sort = data.sort;
				 $('.table table').empty();
				 $('.table table').append("<tr><td>序号</td><td>学校</td><td class='sort pv' sort='down'>浏览量（PV）</td><td class='sort uv' sort='down'>访客数（UV）</td><td class='sort ip' sort='down'>IP数</td><td class='sort avgTime' sort='down'>平均访问时长</td><td class='sort avgPage' sort='down'>平均访问页数</td><td class='sort jump' sort='down'>跳出率</td></tr>");
				 data = data.list;
         		 if(data.length != 0) {
         			for ( var i = 0; i < data.length; i++) {
         				var jsAr = new Array();
				 		var vistor = data[i];
				 		jsAr.push("<tr><td>"+(i+1)+"</td><td>"+vistor.school+"</td><td>"+vistor.pv+"</td><td>"+vistor.uv+"</td><td>"+vistor.ip+"</td><td>"+vistor.avgTime+"</td><td>"+vistor.avgPage+"</td><td>"+vistor.jump+"%</td></tr>");
						$('.table table').append(jsAr);
         			}
         		 }
         		 if(sort == 'pv_down') {
         			 $(".pv").addClass("down");
         			 $(".pv").attr('sort','up');
         		 } else if(sort == 'pv_up') {
         			 $(".pv").addClass("up");
         			 $(".pv").attr('sort','down');
         		 } else if(sort == 'uv_down') {
         			 $(".uv").addClass("down");
         			 $(".uv").attr('sort','up');
         		 } else if(sort == 'uv_up') {
         			 $(".uv").addClass("up");
         			 $(".uv").attr('sort','down');
         		 } else if(sort == 'ip_down') {
         			 $(".ip").addClass("down");
         			 $(".ip").attr('sort','up');
         		 } else if(sort == 'ip_up') {
         			 $(".ip").addClass("up");
         			 $(".ip").attr('sort','down');
         		 } else if(sort == 'avgTime_down') {
         			 $(".avgTime").addClass("down");
         			 $(".avgTime").attr('sort','up');
         		 } else if(sort == 'avgTime_up') {
         			 $(".avgTime").addClass("up");
         			 $(".avgTime").attr('sort','down');
         		 } else if(sort == 'avgPage_down') {
         			 $(".avgPage").addClass("down");
         			 $(".avgPage").attr('sort','up');
         		 } else if(sort == 'avgPage_up') {
         			 $(".avgPage").addClass("up");
         			 $(".avgPage").attr('sort','down');
         		 } else if(sort == 'jump_down') {
         			 $(".jump").addClass("down");
         			 $(".jump").attr('sort','up');
         		 } else if(sort == 'jump_up') {
         			 $(".jump").addClass("up");
         			 $(".jump").attr('sort','down');
         		 }
			 }
    	}),
		$.ajax({
			 type : "post",
			 url : '<cms:getProjectBasePath/>backend/flow/flowQuery/list',
			 data : $('#inputForm').serialize(),
			 dataType : 'json',
			 success : function(data) {
				 myChart = EChartst.init(document.getElementById('echart')); 
				 var option = {
					     	tooltip: {
					     		trigger: 'axis'
					         },
					         legend: {
					        	 show : true,
					         	data:['','','',''],
					         	selectedMode : true
					         },
					         toolbox: {
					 	        show : true,
					 	        feature : {
					 	            magicType : {show: true, type: ['line', 'bar']},
					 	            restore : {show: true}
					 	        },
					 	       padding : 0
					 	    },
					         calculable : true,
					         xAxis : [
					         	{
					             	type : 'category',
					             	boundaryGap : false,
					             	data : ['1']
					             }
					         ],
					         yAxis : [
					          	{
					             	type : 'value',
					             	min:'00:00:00',
					                max:'18:00:00'
					             },
					             {
					            	 "type":"",
					            	 'name':'',
					            	 min:'00:00:00',
					                 max:'01:00:00',
					                  axisLabel:{
					                	  formatter:""
					                  }
					             }
					         ],
					         
					         series : [
					           	{
					             	"name":"",
					                 "type":"",
					                 data:[0],
					                 "yAxisIndex": "",
					                 itemStyle:{
					                  	emphasis:{
					                  		lineStyle:{
					                        	color:''
					                        }
					                    }
					                  }
					             },
					             {
					              	"name":"",
					                  "type":"",
					                  data:[0],
					                  "yAxisIndex": "",
					                  itemStyle:{
					                     	emphasis:{
					                     		lineStyle:{
					                           	color:''
					                           }
					                       }
					                     }
					              },
					              {
					                	"name":"",
					                    "type":"",
					                    data:[0],
					              		"yAxisIndex": "",
					              		itemStyle:{
					                       	emphasis:{
					                       		lineStyle:{
					                             	color:''
					                             }
					                         }
					                       }
					                },
					                {
					                  	"name":"",
					                    "type":"",
					                    data:[0],
					                	"yAxisIndex": "",
					                	itemStyle:{
					                       	emphasis:{
					                       		lineStyle:{
					                             	color:''
					                            }
					                        }
					                    }
					                  }
					         ]
					     };
				data = eval("("+data.message+")");
				date = data[0]; 
				types = data[1];
				myChart.clear();
				option.legend.data = types;
				option.xAxis[0].data = date;
				for(var i=0; i < 4;i++) {
					option.series[i].yAxisIndex = "0";
					option.series[i].data = "";
					option.series[i].type = "";
					option.series[i].name = "";
				}
				for(var i=0;i<types.length;i++) {
					var nums;
					nums = data[i+2];
					if(types[i] == "平均访问时长") {
						option.yAxis[1].type = "value";
						option.yAxis[1].name = "avgTime(秒)";
						option.series[i].yAxisIndex = "1";
					} else if(types[i] == "跳出率") {
						option.yAxis[1].type = "value";
						option.yAxis[1].name = "跳出率(%)";
						option.series[i].yAxisIndex = "1";
					} else {
						option.yAxis[0].name = "数量";
						if($("input[type='checkbox'][class='compareSchool']")[0].checked) {
							if($("input[type='checkbox'][class='types']")[3].checked) {
								option.yAxis[0].name = "avgTime(秒)";
							} else if($("input[type='checkbox'][class='types']")[5].checked) {
								option.yAxis[0].name = "跳出率(%)";
							}
						}
					}
					//如果返回只有一个时间段，就使用柱状图
					if(nums.length <= 1) {
						option.xAxis[0].boundaryGap = "true";
						option.series[i].type = "bar";
					} else {
						option.series[i].type = "line";
					}
					//如果是按月  就使用柱状图
					var tbRadioNum = $('.tbRadio:checked').val();
					if(tbRadioNum == 3) {
						option.xAxis[0].boundaryGap = "true";
						option.series[i].type = "bar";
					}
					if(types[i] == "平均访问时长") {
						option.series[i].data = nums;
						option.series[i].name = types[i];
					} else {
						option.series[i].data = nums;
						option.series[i].name = types[i];
					}
				}
				option.color =['#FF8800','#00FFFF','#FF44AA','#000000'];
				myChart.hideLoading(); 
				myChart.setOption(option,true);
			 }
    	 });
 	}
   
    </script>
	<script type="text/javascript">
	$('#data-table').on('click','.sort',function(){
		var sort = $(this).attr("sort");
		var type =  $(this).attr("class");
		type = type.replace('sort ','').replace(' down','').replace(' up','');
		sort = type+"_"+sort;
		$('#sort').val(sort);
		$.ajax({
			 type : "post",
			 url : '<cms:getProjectBasePath/>backend/flow/flowQuery/table',
			 data : $('#inputForm').serialize(),
			 dataType : 'json',
			 success : function(data) {
				 data = eval("("+data.message+")");
				 var sort = data.sort;
				 $('.table table').empty();
				 $('.table table').append("<tr><td>序号</td><td>学校</td><td class='sort pv' sort='down'>浏览量（PV）</td><td class='sort uv' sort='down'>访客数（UV）</td><td class='sort ip' sort='down'>IP数</td><td class='sort avgTime' sort='down'>平均访问时长</td><td class='sort avgPage' sort='down'>平均访问页数</td><td class='sort jump' sort='down'>跳出率</td></tr>");
				 data = data.list;
        		 if(data.length != 0) {
        			for ( var i = 0; i < data.length; i++) {
        				var jsAr = new Array();
        				console.log(i);
				 		var vistor = data[i];
				 		jsAr.push("<tr><td>"+(i+1)+"</td><td>"+vistor.school+"</td><td>"+vistor.pv+"</td><td>"+vistor.uv+"</td><td>"+vistor.ip+"</td><td>"+vistor.avgTime+"</td><td>"+vistor.avgPage+"</td><td>"+vistor.jump+"%</td></tr>");
						$('.table table').append(jsAr);
        			}
        		 }
        		 if(sort == 'pv_down') {
        			 $(".pv").addClass("down");
        			 $(".pv").attr('sort','up');
        		 } else if(sort == 'pv_up') {
        			 $(".pv").addClass("up");
        			 $(".pv").attr('sort','down');
        		 } else if(sort == 'uv_down') {
        			 $(".uv").addClass("down");
        			 $(".uv").attr('sort','up');
        		 } else if(sort == 'uv_up') {
        			 $(".uv").addClass("up");
        			 $(".uv").attr('sort','down');
        		 } else if(sort == 'ip_down') {
        			 $(".ip").addClass("down");
        			 $(".ip").attr('sort','up');
        		 } else if(sort == 'ip_up') {
        			 $(".ip").addClass("up");
        			 $(".ip").attr('sort','down');
        		 } else if(sort == 'avgTime_down') {
        			 $(".avgTime").addClass("down");
        			 $(".avgTime").attr('sort','up');
        		 } else if(sort == 'avgTime_up') {
        			 $(".avgTime").addClass("up");
        			 $(".avgTime").attr('sort','down');
        		 } else if(sort == 'avgPage_down') {
        			 $(".avgPage").addClass("down");
        			 $(".avgPage").attr('sort','up');
        		 } else if(sort == 'avgPage_up') {
        			 $(".avgPage").addClass("up");
        			 $(".avgPage").attr('sort','down');
        		 }
        		 else if(sort == 'jump_down') {
        			 $(".jump").addClass("down");
        			 $(".jump").attr('sort','up');
        		 } else if(sort == 'jump_up') {
        			 $(".jump").addClass("up");
        			 $(".jump").attr('sort','down');
        		 }
			 }
	   	})
	})
  
	//导出弹出
	$(".downOut").on("click",function(){
		var length =  $("input[type='checkbox'][class='types']").length;
		for(var i=0;i<length;i++) {
			var isChecked = $("input[type='checkbox'][class='types']").get(i).checked;
			if(isChecked) {
				$("#exportForm input[type='checkbox'][class='tbcheckbox downTypes']").eq(i).attr("checked", true);
			}
		}
		var downSchool = $('#downSchool').val();
		if(downSchool == 'all') {
			$(".texttips").text('(单选)');
		} else {
			$(".texttips").text('(可多选)');
		}
	})
	
    </script>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>

</body>
</html>