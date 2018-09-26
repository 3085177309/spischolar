<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>权限设置</title>

<jsp:include page="../head.jsp"></jsp:include>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 26 }">class="in"</c:if>>${xtgl.columnName }</a></li>
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
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/delivery/list">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/system/powers" class="in">权限设置</a>
			<a href="<cms:getProjectBasePath/>backend/system/powers/delivery">文献互助请求</a>
		</div>

		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/powers">栏目显示</a>
						<a href="<cms:getProjectBasePath/>backend/system/powers/quota"
							class="in">流量指标显示</a> <a
							href="<cms:getProjectBasePath/>backend/system/powers/delivery">文献互助请求</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="change_form" method="get"
									action="<cms:getProjectBasePath/>backend/system/powers/pvSerach">
									<label class="common"> <input type="text"
										class="tbSearch keyword" name="pvname"
										placeholder="请输入学校名称或指标">
										<button class="tbBtn" type="submit">查询</button>
									</label>
								</form>
							</div>
							<table class="jurisdiction">
								<tr>
									<th width="80px">序号</th>
									<th width="20%">学校</th>
									<th width="80px"></th>
									<th>流量指标</th>
								</tr>
								<c:forEach items="${orgQuotaPager.rows }" var="orgQuota"
									varStatus="status">
									<tr>
										<td class="tc"><span>${status.index+offset+1 }</span></td>
										<td class="tc"><span>${orgQuota.schoolName }</span></td>
										<td class="tc"><a class="opradded"
											data-thickcon="Trafficindex"
											onclick="getFlag('${orgQuota.orgId}','${orgQuota.flag}','${status.index+offset+1 }')"></a></td>
										<td><c:forEach items="${orgQuota.quotaList }" var="quo"
												varStatus="sta">
												<a class="enabledelete">${quo.quotaName }<i
													onclick="delQuota(${quo.id },'${orgQuota.orgId}');"></i></a>
											</c:forEach></td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="page" id="page">
							<a class="a1">${orgQuotaPager.total}条</a>
							<pg:pager items="${orgQuotaPager.total}" url=""
								export="cp=pageNumber" maxPageItems="20" maxIndexPages="5"
								idOffsetParam="offset">
								<pg:first>
									<a href="${pageUrl}">首页</a>
								</pg:first>
								<pg:prev>
									<a href="${pageUrl}" class="a1">上一页</a>
								</pg:prev>
								<!-- 中间页码开始 -->
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
								<pg:next>
									<a class="a1" href="${pageUrl}">下一页</a>
								</pg:next>
								<pg:last>
									<a href="${pageUrl}">末页</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
					<div class="dataTabNr">
						<div class="databody">
							<div>
								<label class="common"> <input type="text"
									class="tbSearch" placeholder="请输入学校名称或IP">
									<button class="tbBtn">查询</button>
								</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
	<div class="tickbox">
		<div id="Trafficindex" class="schoolTick"
			data-tit="流量指标<em>(可多选)</em>">
			<ul>
				<li style="height: auto"><c:forEach items="${quotaList }"
						var="quota" varStatus="status">
						<label for="cl" class="data-type"> <input type="checkbox"
							class="checkbox" name="cl" quotaName="${quota.quotaName }"
							value="${quota.id }"> <span>${quota.quotaName }</span>
						</label>
					</c:forEach></li>
			</ul>
			<div class="tc">
				<a class="btnEnsure btn" id="enSureQuota">确认</a> <a
					class="btnCancle btn">取消</a>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//点击取消
$(".btnCancle").click(function(){
	$(".thickWarp").hide();
});
	var quotaFlag="",orgId="";
	function getFlag(schoolid,flag,num){
		$('.checkbox').removeAttr("checked");
		quotaFlag=flag;
		orgId=schoolid;
		var txt = $('table.jurisdiction tr:eq('+num+') td:eq(3)').text();
		
		if(txt.indexOf("浏览量（PV）") != -1) {
			$('.checkbox[quotaname=浏览量（PV）]').attr("checked",true);
		}
		if(txt.indexOf("访客数（UV）") != -1) {
			$('.checkbox[quotaname=访客数（UV）]').attr("checked",true);
		}
		if(txt.indexOf("IP数") != -1) {
			$('.checkbox[quotaname=IP数]').attr("checked",true);
		}
		if(txt.indexOf("平均访问时长") != -1) {
			$('.checkbox[quotaname=平均访问时长]').attr("checked",true);
		}
		if(txt.indexOf("平均访问页数") != -1) {
			$('.checkbox[quotaname=平均访问页数]').attr("checked",true);
		}
		if(txt.indexOf("跳出率") != -1) {
			$('.checkbox[quotaname=跳出率]').attr("checked",true);
		}
		if(txt.indexOf("期刊") != -1) {
			$('.checkbox[quotaname=期刊]').attr("checked",true);
		}
		if(txt.indexOf("文章") != -1) {
			$('.checkbox[quotaname=文章]').attr("checked",true);
		}
	}
	function delQuota(id,schoolid){
		
		var index=layer.confirm('确定要删除?', {
		    btn: ['确定','取消']
		}, function(){
			$.ajax({
	            async : true,
	            cache : false,
	            type : 'POST',
	            url : "<cms:getProjectBasePath/>backend/system/powers/delQuota",
	            data : {"id":id,"orgId":schoolid},
	            success : function(data) {
	              data = eval("("+data.message+")");
	              window.location.reload();
	            }
	        });
			layer.close(index);
		}, function(){
			layer.close(index);
		    return false;
		});
	}
	(function($){
    	$("#enSureQuota").click(function(){
    		var qids='';
    		$("#Trafficindex input:checked").each(function(i) {
            	if(0 == i){
            		qids = $(this).val();
                }else{
                	qids += (";" + $(this).val());
                }
            });
    		$("#Trafficindex input").attr("checked",false);
    		$(".thickWarp").hide();
    		$.ajax({
                async : true,
                cache : false,
                type : 'POST',
                url : "<cms:getProjectBasePath/>backend/system/powers/addQuota",
                data : {"qids":qids,"flag":quotaFlag,"orgId":orgId,"type":"1"},
                success : function(data) {
                  data = eval("("+data.message+")");
                  window.location.reload();
                }
            });
    	});
    })(jQuery);
	//（关键字查询）
	$('#change_form').submit(function(){
		var val=$('.keyword').val();
		if(val ==''||val==$('.keyword').attr("placeholder")) {
			$('.keyword').focus();
			return false;
		}
	});
</script>
</body>
</html>
