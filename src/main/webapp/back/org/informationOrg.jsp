<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>基本信息</title>
<jsp:include page="../head.jsp"></jsp:include>
<!--<script src="<cms:getProjectBasePath/>/resources/js/jquery-ui-1.8.18.custom.min.js"></script>-->
<!--<link rel="stylesheet" type="text/css" href="<cms:getProjectBasePath/>/resources/css/jquery-ui-1.8.18.custom.css" />-->
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<jsp:useBean id="now" class="java.util.Date" />
<!-- 当前时间 -->
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 19 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list" class="in">基本信息</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="radius">
					<div class="data-table databody">
						<form name="qq_form" method="post"
							action="<cms:getProjectBasePath/>backend/org/list/updateOrg">
							<div class="infochoose">
								<input type="hidden" name="id" value="${org.id }" /> <input
									type="hidden" name="template" value="xsfx"> <label
									class="list"> <span class="labt">学校：</span> <input
									type="text" class="tbSearch" name="name" value="${org.name }">
								</label>
								<c:if test="${org.flag=='wdkj' }">
									<label class="list"> <span class="labt">机构标识：</span> <input
										type="text" name="flag" class="tbSearch" value="${org.flag }"
										style="background: #ddd;" readonly="readonly">
									</label>
								</c:if>
								<label class="list wid53" id="comefrom"> <span
									class="labt">地区：</span> <input type="text" class="tbSearch"
									style="background: #ddd;" readonly="readonly" name="province"
									value="${org.province }"> <input type="text"
									class="tbSearch" style="background: #ddd;" readonly="readonly"
									name="city" value="${org.city }">
								</label>
								<script
									src="<cms:getProjectBasePath/>/resources/back/js/comefrom.js"></script>
								<label class="list"> <span class="labt">联系人：</span> <input
									type="text" name="contactPerson" class="tbSearch"
									value="${org.contactPerson }">
								</label> <label class="list"> <span class="labt">联系方式：</span> <input
									type="text" name="contact" class="tbSearch"
									value="${org.contact }">
								</label> <label class="list"> <span class="labt">邮箱：</span> <input
									type="text" name="email" id="email" onchange="CheckMail()"
									class="tbSearch" value="${org.email }">
								</label>
								<div class="clear"></div>
							</div>
							<div class="productAll clearfix">
								<span class="tit">产品：</span>
								<div class="productchoose">
									<!-- 期刊 -->
									<c:set var="hasJN" value="0"></c:set>
									<c:forEach var="p" items="${org.productList }">
										<c:if test="${p.productId==1 }">
											<c:set var="hasJN" value="1"></c:set>
											<div class="chooseline">
												<label>学术期刊指南</label> <input type="hidden" value="学术期刊指南"
													class="proName" /> <input type="hidden" value="1"
													class="proId" /> <label class="list wid30"> <span
													class="labt">状态：</span>
													<div class="sc_selbox sc_selboxhalf">
														<c:if test="${p.status==1 }">
															<span id="section_lx">购买</span>
														</c:if>
														<c:if test="${p.status==2 }">
															<span id="section_lx">试用</span>
														</c:if>
														<c:if test="${p.status==0 }">
															<span id="section_lx">停用</span>
														</c:if>
														<input type="hidden" value="" class="status">
													</div>
												</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
													<div class="datebox">
														<i class="inc uv13"></i> <input type="text"
															class="tbSearch datechoose startDate"
															value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
															readonly="readonly">
													</div> <span class="labm">结束日期：</span>
													<div class="datebox">
														<i class="inc uv13"></i> <input type="text"
															class="tbSearch datechoose endDate"
															value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
															readonly="readonly">
													</div>
												</label>
												<c:if test="${not empty p.endDate }">
													<c:set var="interval"
														value="${(p.endDate.time - now.time)/1000/60/60/24+1}" />
												</c:if>
												<%-- <label for="" class="data-type">
											<c:if test="${interval > 0}">
												<span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
											</c:if>
											<c:if test="${interval <= 0}">
												<span class="labm">剩余有效期：</span>0 天
											</c:if>
										</label> --%>
											</div>
										</c:if>

									<c:if test="${hasJN==0 }">
										<div class="chooseline">
											<label>学术期刊指南</label> <input type="hidden" value="学术期刊指南"
												class="proName" /> <input type="hidden" value="1"
												class="proId" /> <label class="list wid30"> <span
												class="labt">状态：</span>
												<div class="sc_selbox sc_selboxhalf">
													<i class="inc uv21"></i><span id="section_lx">没购买</span> <input
														type="hidden" value="" class="status">
												</div>
											</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
												<div class="datebox">
													<i class="inc uv13"></i> <input type="text"
														class="tbSearch datechoose startDate"
														value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
														readonly="readonly">
												</div> <span class="labm">结束日期：</span>
												<div class="datebox">
													<i class="inc uv13"></i> <input type="text"
														class="tbSearch datechoose endDate"
														value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
														readonly="readonly">
												</div>
											</label>
											<c:if test="${not empty p.endDate }">
												<c:set var="interval"
													value="${(p.endDate.time - now.time)/1000/60/60/24+1}" />
											</c:if>
											<%-- <label for="" class="data-type">
											<c:if test="${interval > 0}">
												<span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
											</c:if>
											<c:if test="${interval <= 0}">
												<span class="labm">剩余有效期：</span>0 天
											</c:if>
										</label> --%>
										</div>
									</c:if>
									</c:forEach>
									<!-- 文章 -->
									<c:set var="hasAC" value="0"></c:set>
									<c:forEach var="p" items="${org.productList }">
										<c:if test="${p.productId==2 }">
											<c:set var="hasAC" value="1"></c:set>
											<div class="chooseline">
												<label>蛛网学术搜索</label> <input type="hidden" value="蛛网学术搜索"
													class="proName" /> <input type="hidden" value="2"
													class="proId" /> <label class="list wid30"> <span
													class="labt">状态：</span>
													<div class="sc_selbox sc_selboxhalf">

														<c:if test="${p.status==1 }">
															<span id="section_lx">购买</span>
														</c:if>
														<c:if test="${p.status==2 }">
															<span id="section_lx">试用</span>
														</c:if>
														<c:if test="${p.status==0 }">
															<span id="section_lx">停用</span>
														</c:if>
														<input type="hidden" value="" class="status">
													</div>
												</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
													<div class="datebox">
														<i class="inc uv13"></i> <input type="text"
															class="tbSearch datechoose startDate"
															value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
															readonly="readonly">
													</div> <span class="labm">结束日期：</span>
													<div class="datebox">
														<i class="inc uv13"></i> <input type="text"
															class="tbSearch datechoose endDate"
															value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
															readonly="readonly">
													</div>
												</label>
												<c:if test="${not empty p.endDate }">
													<c:set var="interval"
														value="${(p.endDate.time - now.time)/1000/60/60/24+1}" />
												</c:if>
												<%-- <label for="" class="data-type">
											<c:if test="${interval > 0}">
												<span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
											</c:if>
											<c:if test="${interval <= 0}">
												<span class="labm">剩余有效期：</span>0 天
											</c:if>
										</label> --%>
											</div>
										</c:if>

									<c:if test="${hasAC==0 }">
										<div class="chooseline">
											<label>蛛网学术搜索</label> <input type="hidden" value="蛛网学术搜索"
												class="proName" /> <input type="hidden" value="2"
												class="proId" /> <label class="list wid30"> <span
												class="labt">状态：</span>
												<div class="sc_selbox sc_selboxhalf">
													<i class="inc uv21"></i> <span id="section_lx">没有购买</span>
													<input type="hidden" value="" class="status">
												</div>
											</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
												<div class="datebox">
													<i class="inc uv13"></i> <input type="text"
														class="tbSearch datechoose startDate"
														value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
														readonly="readonly">
												</div> <span class="labm">结束日期：</span>
												<div class="datebox">
													<i class="inc uv13"></i> <input type="text"
														class="tbSearch datechoose endDate"
														value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
														readonly="readonly">
												</div>
											</label>
											<c:if test="${not empty p.endDate }">
												<c:set var="interval"
													value="${(p.endDate.time - now.time)/1000/60/60/24+1}" />
											</c:if>

										</div>
									</c:if>
									</c:forEach>
								</div>
								<div class="clear"></div>
							</div>

							<div class="infochoose">
								<input type="hidden" name="ipRanges" id="ipRanges"
									value="${org.ipRanges }" />
								<div class="clear"></div>
								<table class="fixedwidth">
									<tr>
										<th width="50px">序号</th>
										<th>IP地址</th>
									</tr>
								</table>
							</div>
							<c:if test="${org.flag=='wdkj' }">
								<div class="tl">
									<input type="submit" class="downOut fr" value="保存">
								</div>
							</c:if>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>



<script>
/**
 * 提示消息
 * @param text 提示消息
 * @param func 回调函数
 */
(function($){
 	$(document).ready(function(){
 		//初始化IP范围
 		var ipRanges=$('#ipRanges').val(),ipRangesArr;
 		if(!ipRanges==""){
 			ipRangesArr=ipRanges.split(";");
 	 		for(var i=0;i<ipRangesArr.length;i++){
 	 			$('.fixedwidth').append('<tr><td class="index" value='+(i+1)+'>'+(i+1)+'</td><td><p class="ips">'+ ipRangesArr[i]+'</p><input class="updateInput" type="text" style="display: none;width:100%" value="'+ipRangesArr[i]+'"></td></tr>');
 	 		}	
 		}
 		/**
 		 * 表单提交验证
 		 */
		$('form[name="qq_form"]').bind('submit',function(e){
			var province = $('#province span').text();
			$('input[name="province"]').val(province);
			var city = $('#city span').text();
			$('input[name="city"]').val(city);
		})
    }); 
 })(jQuery) 
 var err = '${error}';
 if(err!='') {
	 alert(err); 
 }

</script>

</body>
</html>
