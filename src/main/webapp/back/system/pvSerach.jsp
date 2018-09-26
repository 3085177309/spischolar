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
					<div class="dataTabNr" style="display: block">
						<div class="databody">
							<div class="mb10">
								<form id="quota_form" name="quota_form" method="get"
									action="<cms:getProjectBasePath/>backend/system/powers/pvSerach">
									<label class="common"> <input type="text"
										class="tbSearch keyword" name="pvname" value="${name }"
										placeholder="请输入学校名称或指标"> <input id="name"
										type="hidden" value="${name }" />
										<button class="tbBtn" onclick="submit()">查询</button>
									</label>
								</form>
							</div>
							<c:if
								test="${empty resutlmap.schoolQuotaList && empty resutlmap.quoList && empty resutlmap.orgs}">
								<div class="nosearchesult">找不到相关结果</div>
							</c:if>
							<c:if test="${not empty resutlmap.orgs }">
								<div class="nosearchesult">
									找不到结果，是否新建下列相关学校的指标权限？
									<div>
										<c:forEach items="${resutlmap.orgs }" var="org" varStatus="st">
											<label id="${org.flag}"><a
												onclick="build(${org.id},'${org.flag}','${org.name}')">${org.name}</a></label>
										</c:forEach>
									</div>
								</div>
							</c:if>
							<!-- 检索学校流量指标 -->
							<c:if test="${not empty resutlmap.schoolQuotaList}">
								<div class="jurisdiction">
									<table class="jurisdiction">
										<tr>
											<th width="20%">学校</th>
											<th style="text-align: center">已选指标</th>
											<th width="25%"></th>
										</tr>
										<c:forEach items="${resutlmap.schoolQuotaList }" var="schools"
											varStatus="statu">
											<tr>
												<td class="tc" width="20%"><span>${schools.schoolName }</span></td>
												<td><c:forEach items="${schools.quotaList }"
														var="quota" varStatus="status">
														<span class="widthseting"><a class="enabledelete"
															onclick="delQuota('${quota.id }','${schools.orgId }');">${quota.quotaName }<i></i></a></span>
														<%-- <a onclick="delQuota('${quota.id }','${schools.orgId }');" class="enabledelete">${quota.quotaName }<i></i></a> --%>
													</c:forEach></td>
												<td class="tc" style="width: 10%"><span
													class="opradded" data-thickcon="Trafficindex"
													onclick="getFlag('${schools.flag}','${schools.orgId }','${statu.index+1 }')"></span></td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</c:if>
							<!-- 检索指标查询结果结果-->
							<c:if test="${not empty resutlmap.quoList }">
								<div class="jurisdiction">
									<table>
										<tr>
											<th colspan="3" class="tl"><span class="pl10">${resutlmap.quoList.get(0).quotaName }</span></th>
										</tr>
									</table>
									<table class="jurisdiction">
										<tr>
											<td class="tc" width="15%"><span>地区</span></td>
											<td class="tc"><span>学校</span></td>
											<td width="15%"></td>
										</tr>
										<c:forEach items="${resutlmap.quoList }" var="quo"
											varStatus="statu">
											<tr>
												<td class="tc"><span>${quo.province }</span></td>
												<td><c:forEach items="${quo.orglist }" var="org"
														varStatus="stat">
														<span class="widthseting"><a id="${org.flag}"
															class="enabledelete"
															onclick="delQuota('${org.remark }','${org.id }');">${org.name }<i></i></a></span>
														<%-- <a onclick="delQuota('${org.remark }','${org.id }');" class="enabledelete">${org.name }<i></i></a> --%>
													</c:forEach></td>
												<c:if test="${statu.index==0 }">
													<td class="tc" rowspan="${quo.size()+1 }"
														style="width: 10%"><a class="opradded"
														data-thickcon="addAccount" onclick="getQid(${quo.qid });"></a></td>
												</c:if>
											</tr>
										</c:forEach>
									</table>
								</div>
							</c:if>
							<!-- 新建流量指标 -->
							<div class="newjurisdiction" style="display: none">
								<table>
									<tbody>
										<tr>
											<th colspan="2" class="tl"><span class="pl10 fb"
												id="schoolname"></span></th>
										</tr>
										<tr>
											<td width="10%" class="tc"><span class="pl10">流量指标</span></td>
											<td>
												<div>
													<c:forEach items="${quotaList }" var="quota"
														varStatus="status">
														<em class="zhibiao"><input type="checkbox"
															class="checkboxSig" value="${quota.id }">${quota.quotaName }</em>
													</c:forEach>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="databottom clearfix">
									<input id="flag" name="flag" type="hidden" value="" /> <input
										id="orgId" name="orgId" type="hidden" value="" /> <a href="#"
										class="downOut fl">新建</a>
								</div>
								<div class="clear"></div>
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
					<div class="tickbox" style="display: none">
						<div id="Trafficindex" class="schoolTick"
							data-tit="流量指标<em>(可多选)</em>">
							<ul>
								<li><c:forEach items="${quotaList }" var="quota"
										varStatus="status">
										<label for="cl" class="data-type"> <input
											type="checkbox" class="checkbox"
											quotaName="${quota.quotaName }" name="cl"
											value="${quota.id }"> <span>${quota.quotaName }</span>
										</label>
									</c:forEach></li>
							</ul>
							<div class="tc">
								<a class="btnEnsure btn" id="enSureQuota">确认</a> <a
									class="btnCancle btn">取消</a>

							</div>
						</div>
						<div id="addAccount" class="schoolTick"
							data-tit="选择学校<em>(可多选)</em>">
							<input type="hidden" name="school">
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
								<a class="btnEnsure btn" id="enSureSchool">确认</a> <a
									class="btnCancle btn">取消</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>
<script type="text/javascript">
var quotaFlag="",qid="",orgId="";
function getFlag(flag,orgid,num){
	$('.checkbox').removeAttr("checked");
	quotaFlag=flag;
	orgId=orgid;
	var txt = $('table.jurisdiction tr:eq('+num+') td:eq(1)').text();
	
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
function getQid(quotaId){
	qid=quotaId;
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
	          $("form input[name='pvname']").val($("#name").val());
	          $("form[name='quota_form']").submit(); 
	        }
	    });
		layer.close(index);
	}, function(){
		layer.close(index);
	    return false;
	});
	
	/* var gnl=confirm("确定要删除?");
	if (gnl!=true){
		return false;
	} */
	
}
function department(){
	var flags="";
	$(".schoolChecked .list span").each(function(i){
		if(0==i){
			flags =$(this).attr("v");
		}else{
			flags += (";" + $(this).attr("v"));
		}
	});
	if(''==flags){
		alert("请选择学校机构！");
		return;
	}
	$(".thickWarp").hide();
	$.ajax({
        async : true,
        cache : false,
        type : 'POST',
        url : "<cms:getProjectBasePath/>backend/system/powers/addQuota",
        data : {"qids":qid,"flag":flags,"type":"2"},
        success : function(data) {
          data = eval("("+data.message+")");
          $("form input[name='pvname']").val($("#name").val());
          $("form[name='quota_form']").submit(); 
        }
    });
}
function build(schoolid,flag,name){
	$("#schoolname").html(name);
	$(".newjurisdiction").show();
	$("#flag").val(flag);
	$("#orgId").val(schoolid);
	$(".newjurisdiction input:checked").each(function(i) {
		$(this).attr("checked",false);
    });
}
$(".databottom").on("click", function() {
	var flag = $("#flag").val();
	var orgid = $("#orgId").val();
	var qids='';
	$(".newjurisdiction input:checked").each(function(i) {
    	if(0 == i){
    		qids = $(this).val();
        }else{
        	qids += (";" + $(this).val());
        }
    });
	if(qids==''){
		alert("请选择指标!");
		return false;
	}
	$.ajax({
    	async : true,
    	cache : false,
    	type : 'POST',
    	url : "<cms:getProjectBasePath/>backend/system/powers/addQuota",
    	data : {"qids":qids,"flag":flag,"orgId":orgid,"type":"1"},
    	success : function(data) {
      		data = eval("("+data.message+")");
      		if(data==1){
      			alert("新建成功!");
      			//$("#"+flag+"").hide();
      			//$(".newjurisdiction").hide();
      			window.location.href='<cms:getProjectBasePath/>backend/system/powers/quota';
      		}else{
      			alert("新建失败!");
      		}
    	}
	});
});
(function($){
	var schoolselect=$(".schoolselect"),
		provinceBox=$(".provinceBox"),
		schoolChecked=$(".schoolChecked .list");
	schoolselect.find("ul").eq(0).show();
	provinceBox.find("span").eq(0).addClass("in");
	tab(provinceBox[0].getElementsByTagName("span"),schoolselect[0].getElementsByTagName("ul"));
	
	schoolselect.find("ul li").bind("click",function(){
		var text=$(this).html(),
		    flag=$(this).attr("v"),
		    compareSchoolVal=$('.compareSchool');
		var repChecked=repMaxnumCheck(text);
		var selected=schoolChecked.append(function(){
			return repChecked ? '<span class="schbtn" v='+flag+'>'+text+'<i></i></span>': false;
		});
		removeContrast(text);
	})
	
	$("#enSureSchool").click(function(){
		thickdepartment();
		removeContrast();
	})
	//点击取消
    $(".btnCancle").click(function(){
    	$(".thickWarp").hide();
    });
	function repMaxnumCheck(text){//重复检查
		var checkEle=schoolChecked.find("span"),
			chk=true;
		checkEle.each(function(){
			if($(this).text()==text){
				alert("不可重复选择！")
				chk=false;
			}
		});
		return chk;
	}
	function removeContrast(){ //删除当前已选
		$(".schbtn").find("i").click(function(){
			$(this).parents("span").remove();
		})
	}
	function thickdepartment(){//弹窗确认提交
		department();
	}
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
              $("form input[name='pvname']").val($("#name").val());
              $("form[name='quota_form']").submit(); 
            }
        });
	});
})(jQuery);
//（关键字查询）
$('#quota_form').submit(function(){
	var val=$('.keyword').val();
	if(val ==''||val==$('.keyword').attr("placeholder")) {
		window.location.href="<cms:getProjectBasePath/>backend/system/powers/quota";
		return false;
	/* 	$('.keyword').focus();
		return false; */
	}
});
//已存在学校置灰
$(".opradded").click(function(){
	$("div.schoolselect ul li").each(function(){
		$(this).removeAttr("class");
	});
	var data = $(this).parent().parent().parent().find("span a");
	var orgids,orgflag;
	for(var i=0; i<data.length; i++){
		orgids=data.eq(i).attr("id");
		$("div.schoolselect ul li").each(function(){
			orgflag = $(this).attr("v");
			if(orgids==orgflag){
				$(this).attr("class","schdisable");
			}
		});
	}
});
</script>
</body>
</html>