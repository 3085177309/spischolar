<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<title>网站概况</title>
<jsp:include page="head.jsp" flush="false"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<!-- <span class="inc uv12"></span> -->
			<span class="inc uv00"></span>网站概况
		</h3>
		<ul class="side-nav">
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">网站概况</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<c:if test="${org.flag=='wdkj' }">
						<label class="access-pro"> <span class="labt">学校:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:if test="${school == 'all' }">
									<span id="section_lx">全部访问</span>
								</c:if>
								<c:if test="${school != 'all' }">
									<c:forEach items="${orgList }" var="org" varStatus="status">
										<c:if test="${org.flag == school }">
											<span id="section_lx">${org.name }</span>
										</c:if>
									</c:forEach>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p onclick="change('all',1)">全部访问</p>
									<c:forEach items="${orgList }" var="org" varStatus="status">
										<p class="school" onclick="change('${org.flag }',1)">${org.name }</p>
									</c:forEach>
								</div>
								<input type="hidden" id="school" name="school" value="${school}">
							</div>
						</label>
						<label>
							<span class="thickBtn" data-thickcon="downLoadInfo" style="margin-top: 7px;*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
							<i></i>下载详细数据</span>
						</label>

						<script type="text/javascript">
					function change(id,type){
						//type=1是学校，type=2是数据类型
						if(type == 1) {
							$("#school").val(id);
						} else if(type == 2) {
							$("#type").val(id);
						}
						var school = $("#school").val();
						var type = $("#type").val();
						window.location.href="<cms:getProjectBasePath/>/backend/index?school="+school+"&type="+type;
					}
					</script>
						
					</c:if>
					<c:if test="${org.flag!='wdkj' && school != 'all'}">
						<c:forEach items="${orgList }" var="org" varStatus="status">
							<c:if test="${org.flag == school }">
								<span class="labt">学校:</span>
								<span id="section_lx">${org.name }</span>
							</c:if>
						</c:forEach>
					</c:if>
					<div class="clear"></div>
				</div>
				<div class="radius" id="data-div">
					<c:forEach items="${permission.wzgk }" var="llfx"
						varStatus="status">
						<c:if test="${llfx.columnName == '访问流量'}">
							<div class="icon div">
								<span class="icon jt"></span><span>访问流量</span>
							</div>
							<table class="data-table" id="data-table">
								<tr>
									<th></th>
									<c:forEach items="${quotas }" var="quo" varStatus="statu">
										<c:if test="${quo.id!=6 && quo.id!=7 && quo.id!=8 }">
											<th><span>${quo.quotaName }</span></th>
										</c:if>
									</c:forEach>
								</tr>
								<c:forEach var="list" items="${visiteList }" varStatus="status">
									<tr>
										<c:if test="${status.index == 0 }">
											<td><span>今日</span></td>
										</c:if>
										<c:if test="${status.index == 1 }">
											<td><span>昨日</span></td>
										</c:if>
										<c:if test="${status.index == 2 }">
											<td><span>本周</span></td>
										</c:if>
										<c:if test="${status.index == 3 }">
											<td><span>本月</span></td>
										</c:if>
										<c:if test="${status.index == 4 }">
											<td><span>每日平均</span></td>
										</c:if>
										<c:if test="${status.index == 5 }">
											<td><span>总计</span></td>
										</c:if>
										<c:forEach items="${quotas }" var="quota" varStatus="stat">
											<c:if test="${quota.id==1 }">
												<td><span class="b">${list.pv }</span></td>
											</c:if>
											<c:if test="${quota.id==2 }">
												<td><span class="b">${list.uv }</span></td>
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
										</c:forEach>
									</tr>
								</c:forEach>
							</table>
						</c:if>
						<c:if test="${llfx.columnName == '检索&浏览'}">
							<div class="icon div">
								<span class="icon jt"></span><span>检索&浏览</span>
							</div>
							<table class="data-table">
								<tr>
									<th></
									<th>
									<th>检索期刊（次）</th>
									<th>检索文章（次）</th>
									<th>浏览学科体系（次）</th>
									<th>浏览学科（次）</th>
									<th>浏览期刊（次）</th>
								</tr>
								<c:forEach var="list" items="${searchInfoList }"
									varStatus="status">
									<tr>
										<td>总计</td>
										<td>${list.journalSearchNum }</td>
										<td>${list.scholarSearchNum }</td>
										<td>${list.dbNum }</td>
										<td>${list.subjectNum }</td>
										<td>${list.journalNum }</td>
									</tr>
								</c:forEach>
							</table>
						</c:if>
						<c:if test="${llfx.columnName == '获取全文'}">
							<div class="icon div">
								<span class="icon jt"></span><span>获取全文</span>
							</div>
							<table class="data-table">
								<tr>
									<th></th>
									<th>总下载次数</th>
									<th>文献互助请求量</th>
									<th></th>
									<th></th>
									<th></th>
								</tr>

								<tr>
									<td>总计</td>
									<td>${downloadCount }</td>
									<td>${deliveryCount }</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</table>
						</c:if>
						<c:if test="${llfx.columnName == '用户情况'}">
							<div class="icon div">
								<span class="icon jt"></span><span>用户情况</span>
							</div>
							<table class="data-table">
								<tr>
									<th></th>
									<th>注册用户数</th>
									<th>游客数</th>
									<th>用户总登录次数</th>
									<th></th>
									<th></th>
								</tr>
								<tr>
									<td>总计</td>
									<td>${memberList.regrestCount }</td>
									<td>${memberList.touristCount }</td>
									<c:if test="${type == -1 }">
										<td>${memberList.loginCount + memberList.loginCountAdd }</td>
									</c:if>
									<c:if test="${type == 0 }">
										<td>${memberList.loginCount }</td>
									</c:if>
									<c:if test="${type == 1 }">
										<td>${memberList.loginCountAdd }</td>
									</c:if>
									<td></td>
									<td></td>
								</tr>
							</table>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div id="downLoadInfo" class="export downLoadInfo" data-tit="下载详细数据">
		<form id="exportForm"
			action="<cms:getProjectBasePath/>backend/flow/flowQuery/downloadHistory"
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
	<script type="text/javascript">
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
	//导出
	function exports() {
		var exportBeginTime = $('#exportBeginTime').val();
		var exportEndTime = $('#exportEndTime').val();
		if(exportBeginTime == null || exportBeginTime == '' || exportEndTime == null || exportEndTime == '') {
			layer.alert("请选择开始时间和结束时间！")
			return false;
		}
		$("#exportForm").submit();
	}
	</script>
	<jsp:include page="foot.jsp"></jsp:include>
</div>
</body>
</html>
