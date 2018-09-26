<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>文献互助</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/pagination.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 23 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统管理</a>>
			<a href="#" class="in">文献互助</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form method="get" id="change_form">
						<c:if test="${org.flag=='wdkj' || org.flag=='ls' }">
							<label class="access-pro"> <span class="labt">学校:</span>
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
										<p class="school">全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolFlag="${org.flag }"
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>
								</div>
							</label>
						</c:if>
						<input type="hidden" id="helperScid" name="helperScid" value="${school }">
						<label class="data-type"> <span class="labt">状态:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:choose>
									<c:when test="${type=='' }">
										<span id="section_lx">全部</span>
									</c:when>
									<c:when test="${type==1 }">
										<span id="section_lx">已成功处理</span>
									</c:when>
									<c:when test="${type==0 }">
										<span id="section_lx">未处理</span>
									</c:when>
									<c:when test="${type==2 }">
										<span id="section_lx">提交第三方处理</span>
									</c:when>
									<c:when test="${type==3 }">
										<span id="section_lx">无结果</span>
									</c:when>
									<c:when test="${type==4 }">
										<span id="section_lx">其他途径</span>
									</c:when>
									<c:when test="${type==5 }">
										<span id="section_lx">无结果(图书)</span>
									</c:when>
									<c:when test="${type==7 }">
										<span id="section_lx">复用</span>
									</c:when>
									<c:when test="${type==6 }">
										<span id="section_lx">已复用</span>
									</c:when>
									<c:otherwise>
										<span id="section_lx">全部</span>
									</c:otherwise>
								</c:choose>
								<div class="sc_selopt" style="display: none;">
									<!-- <p class="type" value="">全部</p>
									<p class="type" value="1">已成功处理</p>
									<p class="type" value="0">未处理</p>
									<p class="type" value="2">提交第三方处理</p>
									<p class="type" value="4">其他途径</p>
									<p class="type" value="3">无结果</p>
									<p class="type" value="5">无结果(图书)</p>
									<p class="type" value="7">复用</p>
									<p class="type" value="6">已复用</p> -->
									<p class="type" value="">全部</p>
									<p class="type" value="1">未处理</p>
									<p class="type" value="3">提交第三方处理</p>
									<p class="type" value="4">已成功处理</p>
									<p class="type" value="5">无结果</p>
									
									
								</div>
								<input type="hidden" name="status" >
							</div>
						</label>
						<!-- 日历 -->
						<label for="" class="data-type"> <span class="labt">日期:</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" id="beginTime"
									class="tbSearch datechoose" name="beginTime"
									onchange="searchList()" value="${beginTime }"
									onfocus="WdatePicker({minDate:'<fmt:formatDate value="${org.registerDate }" pattern="yyyy-MM-dd"/>',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
							</div> <span class="labm">至</span>
							<div class="datebox">
								<i class="inc uv13"></i> <input type="text" id="endTime"
									class="tbSearch datechoose" name="endTime"
									onchange="searchList()" value="${endTime }"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'%y-%M-%d',readOnly:true})">
							</div>
						</label>
						<div class="input-s-w">
							<input type="text" class="tbSearch subselect keyword"
								autocomplete="off" name="keyword" placeholder="请输入标题或邮箱查询"
								value="${keyword }" /> <input class="tbBtn submit" id="search" value="查询"
								type="button" />
						</div>

					</form>
					<div class="clear"></div>
				</div>


				<div class="radius">
					<table class="data-table" id="data-table">
					</table>
				</div>
				<div id="pager" ></div>
				<div class="pagination"></div>
				<div class="oprbtn" style="display:none"></div>	
				
				
				<!-- 弹窗 -->
				<div class="tickbox" style="display:none">

					<div id="docdeliverHelp" class="docdeliverHelp" style="width: 550px;"
						data-tit="审核">
						<form method="post" action="list/diliverHelp" id="aduit_form">
							<input type="hidden" name="id" /> 
							<input type="hidden" name="auditorId" value="${front_member.id }" /> 
							<input type="hidden" name="auditorName" value="${front_member.username }" /> 
							<ul>
								<li><label class="data-type"> <span class="labt">标题：</span>
										<span class="labcon title"></span>
								</label></li>
					
								<li>
										<span class="labt">状态：</span>
									<label class="data-type">
									<input class="processType"
										type="radio" name="auditStatus" value="3" checked="checked" />审核通过&nbsp;
									<input class="processType"
										type="radio" name="auditStatus" value="0" checked="checked" />审核不通过&nbsp;
								</label>
								
							
								</li>

								<li>
										<span class="labt">操作：</span>
										<a id="download" href="" class="labcon path" download>下载</a>
								</li>
							</ul>
							<div class="tc">
								<input type="button" class="btnEnsure btn" value="提交" /> <input
									type="reset" class="btnCancle btn" value="取消" />
							</div>
						</form>
					</div>

					<style>
						.docdeliverHelp ul{
							padding: 20px 26px 0px;
						}
						.docdeliverHelp li{
							padding-bottom: 10px;
						}
					</style>
						
						
					<div id="docdeliver" class="docdeliver" style="width: 550px;"
						data-tit="处理">
						<form method="post" action="list/process"
							enctype="multipart/form-data" id="process_form">
							<input type="hidden" name="id" /> 
							<input type="hidden" name="giverId" value="${front_member.id }" /> 
							<input type="hidden" name="giverName" value="${front_member.username }" /> 
							<ul>
								<li><label class="data-type"> 
										<span class="labt">标题：</span>
										<span class="labcon" id="title_div"></span>
								</label></li>
								<li class="textOver"><label class="data-type"> 
										<span class="labt">URL：</span> 
										<a href="#" id="url_href" target="_blank"></a>
								</label></li>
								<li><label class="data-type" id="aa"> 
									<span class="labt">处理方式：</span> 
									<input class="processType" type="radio" name="status" value="1" checked="checked" />直接处理&nbsp;
									<font class="types"> 
										<input class="processType" type="radio" name="status" value="2" />提交第三方处理&nbsp; 
									</font> 
									<input class="processType" type="radio" name="status" value="3" />无结果&nbsp; 
								</label></li>
								<li id="file_line"><label class="data-type"> <span
										class="labt">文档：</span> <input type="file" id="file_input"
										name="file" class="file">
								</label></li>
							</ul>
							<div class="tc">
								<input type="button" class="btnEnsure btn" value="提交" /> 
								<input type="reset" class="btnCancle btn" value="取消" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
	
	var realmName = $("#realmName").val(), // 域名
	userId = $("#userId").val(), // 用户id
	userName = $("#usernameText").text(); // 用户名称
	
	
	var ajaxHand = function(result,pageUrl,data){
		// 分页条插件配置项
		$('.pagination').pagination({
		    coping: true,
		    totalData:result.totalElements?result.totalElements:1, // 数据总数
		    isData:true, // 显示数据条数按钮
		    current:result.number+1, // 当前页
		    showData:20, // 每页10条
		    isHide:true,
		    jumpBtn:"GO",
		    prevContent: '上一页',
		    homePage:"首页",
		    nextContent: '下一页',
		    endPage:"末页",
		    callback: function (api) {
		    	var page = api.getCurrent() - 1;
		    	$.ajax({
		    		url: pageUrl+'?page='+page+'&size=20',
					type: 'get',
					data: data,
					success:function(result2){
						renderHtml(result2.body.content);
					}
		    	})
		    }
		});

		renderHtml(result.content);
	}
    
	window.onload=function(){
		searchList();
	}
	
	function searchList() {
		var helperScid = $('#change_form input[name=helperScid]').val();
		var status = $('#change_form input[name=status]').val();
		var keyword = $('#change_form input[name=keyword]').val();
		var beginTime = $('#change_form input[name=beginTime]').val();
		var endTime = $('#change_form input[name=endTime]').val();
		var data = {"helperScid": helperScid, "status": status,"keyword": keyword,"beginTime": beginTime,"endTime": endTime};
		$.ajax({
			type:"get",
			dataType:"json",
			url: realmName+"/backend/help/list",
			data: data,
			success:function (result){
				var pageUrl = realmName+'/backend/help/list/';
				ajaxHand(result.body,pageUrl,data);
			},
			error:function(){
			}
		})
	}
	
	var renderHtml = function(data){
		$('#data-table').empty();
		$('#data-table').append("<tr><th width='8%'><span>序号</span></th><th width='30%'><span>标题</span></th><th><span>用户</span></th><th><span>学校</span></th><th><span>申请时间</span></th><th><span>状态</span></th><th><span>处理时间</span></th><th><span>操作人</span></th><th width='8%'><span>操作</span></th></tr>"); 

   		if(data.length != 0) {
				 
   			for ( var i = 0; i < data.length; i++) {

   				var jsAr = new Array();
					// 当前数据
			 		var helpRecord = data[i];
					// 数据处理数量
					var recordsLen = helpRecord.giveRecords.length;
					var rowsapn = recordsLen>0 ? (helpRecord.status==0 ? recordsLen +1 :recordsLen): null;
					var trHtml = '';
					// 序号
					var num = '<td rowspan="'+rowsapn+'">'+(i+1)+'</td>';

					// 标题
					var title = function (){
						var url = helpRecord.literature.docHref.length=='1' ? 'javascript:void(0);' : helpRecord.literature.docHref;
						return '<td rowspan="'+rowsapn+'"><a target="_blabk" href="'+url+'">'+helpRecord.literature.docTitle+'</a></td>';
					}();

					// 用户
					var user = (helpRecord.helperEmail == null)? '<td rowspan="'+rowsapn+'"></td>' : '<td rowspan="'+rowsapn+'">'+helpRecord.helperEmail+'</td>';

					// 学校
					var school = '<td rowspan="'+rowsapn+'">'+helpRecord.helperScname+'</td>';

					// 申请时间
					var createTime = '<td rowspan="'+rowsapn+'">'+helpRecord.gmtCreate+'</td>';

					// 操作按钮
					var operateBtn = '<td></td>';
                    // 按钮
                    var buttonz = '<td></td>';
					// 状态
					var state = function (){
						var typeName = "";
						if(helpRecord.status == 0 || helpRecord.status == 2) {
							typeName = "未处理";
							operateBtn = "<td><a href='javascript:void(0);' data-thickcon='docdeliver' class='oprbtn btngreen handle' helpRecord_id='"+helpRecord.id+"' data_title='"+helpRecord.literature.docTitle+"' data_url='"+helpRecord.literature.docHref+"' helpRecord_status='"+helpRecord.status+"'>处理</a></td>";
							if(helpRecord.status == 2) {
								//待审核
                                typeName = "待审核";
								operateBtn = "<td><a data-thickcon='docdeliverHelp' helpRecord_id='"+helpRecord.id+"' data_title='"+helpRecord.literature.docTitle+"' class='oprbtn btngreen help'>审核</a></td>";
							}
						} else if (helpRecord.status == 1) {
                            typeName = "锁定待上传";
                        }
						else if(helpRecord.status == 3) {
							typeName = "提交第三方处理";
                            buttonz = "<td><a href='javascript:void(0);' data-thickcon='docdeliver' class='oprbtn btngreen handle' helpRecord_id='"+helpRecord.id+"' data_title='"+helpRecord.literature.docTitle+"' data_url='"+helpRecord.literature.docHref+"' helpRecord_status='"+helpRecord.status+"'>处理</a></td>";
						} else if(helpRecord.status == 4) {
							typeName = "已成功处理";
						} else if(helpRecord.status == 5) {
							typeName = "无结果";
						} 


						return '<td>'+typeName+'</td>';
					}();


					// 拼接
                    console.log(helpRecord)
					if(recordsLen==0){
						trHtml +=  '<tr>'+(num + title + user + school + createTime + state + '<td></td><td></td>') + operateBtn+'</tr>';
					}else {
						for ( var n = 0; n < recordsLen; n++) {
							var recordsData =  helpRecord.giveRecords[n];
							// 处理时间
							var dealwith = '<td></td>';
							if (recordsData.giverType != 2 || (recordsData.giverType == 2 && recordsData.auditorName != null)){
                                dealwith = '<td>'+recordsData.gmtModified+'</td>';
							}
							// 处理人
							var operator = '<td></td>';
							if (recordsData.giverType != 2){
                                operator = '<td>'+recordsData.giverName+'</td>';
							}else if (recordsData.auditorName != null){
                                operator = '<td>'+recordsData.auditorName+'</td>';
							}
							// 处理状态
							var statez = function (){
								// 待审核
								if(recordsData.auditStatus == 0){
									buttonz = operateBtn;
									return '<td>待审核</td>';
								}
								// 审核通过
								else if(recordsData.auditStatus == 1){
                                    buttonz='<td></td>';
									return '<td>审核通过</td>';
								}
								// 审核不通过
								else if(recordsData.auditStatus == 2){
                                    buttonz='<td></td>';
									return '<td>审核不通过</td>'
								}
								// 待上传
								else if(recordsData.auditStatus == 4){
                                    buttonz='<td></td>';
									return '<td>待上传</td>'
								}
								// 为空
								else if(recordsData.auditStatus == null && recordsData.giverType!==2){
									return state;
								}

							}();

							
							if(recordsLen>0 && n==0){
								trHtml +=  '<tr>'+(num + title + user + school + createTime + statez + dealwith + operator + buttonz) +'</tr>';
							}else if(recordsLen>0){
								trHtml += '<tr>'+ (statez + dealwith + operator + buttonz) +'</tr>';
							}
                            // 是否添加未处理行
                            var clBtn = "<td><a href='javascript:void(0);' data-thickcon='docdeliver' class='oprbtn btngreen handle' helpRecord_id='"+helpRecord.id+"' data_title='"+helpRecord.literature.docTitle+"' data_url='"+helpRecord.literature.docHref+"' helpRecord_status='"+helpRecord.status+"'>处理</a></td>";

                            if(helpRecord.status==0 && (n==recordsLen-1)){
                                trHtml += '<tr>'+ (state + '<td></td>' + '<td></td>' + clBtn) +'</tr>';
                            }

						}
								
					}

					$('#data-table').append(trHtml);

   			}
   		 }
	}





	
	//学校下拉框
	$('.school').click(function(){
		var vals=$(this).attr("schoolId");
		$('input[name=helperScid]').val(vals);
		searchList();
	});
	//文献互助状态下拉框
	$('.type').click(function(){
		var vals=$(this).attr("value");
		$('input[name=status]').val(vals);
		searchList();
	});
	
	$("#search").click(function(){
		var keyword = $('#change_form input[name=keyword]').val();
		if(keyword== '' || keyword.trim().length == 0) {
			layer.alert("关键词不能为空！");
			return false;
		}
		searchList();
	});
	//回车事件
	$(".keyword").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            $('#search').click();
        }
    });
	
	/**处理按钮*/
	$("#data-table").on('click','.handle',function(){
		var id=$(this).attr("helpRecord_id");
		var title=$(this).attr("data_title");
		var url=$(this).attr("data_url");
		var status=$(this).attr("helpRecord_status");
		$(this).parents("td").addClass("self-chuli");
		$('#process_form input[name=id]').val(id);
		$('#process_form #title_div').text(title.replace('<b>','').replace('</b>',''));
		(url)? $('#process_form #url_href').attr('href',url) : $('.textOver').hide();
		$('#process_form #url_href').text(url);
		$('#process_form #file_input').val("");
		$('.types').show();

		if(status==3){//第三方处理
			$('.types').hide();
		}
	});
	
	//处理方式选择
	$('#process_form .processType').click(function(){
		var value=$(this).val();
		if(value==1){
			$('#file_line').show();
			$('#file_input').attr('disabled',false);
		}else{
			$('#file_line').hide();
			$('#file_input').attr('disabled',true);
		}
	});
	
	// ‘处理’弹窗 同步改为异步
    $("#docdeliver .btnEnsure").on("click",function(e){submitProcess(e)});
	function submitProcess(e){
		e.preventDefault();
		var selfTd = $(".self-chuli");
        var formdata = new FormData($( "#process_form" )[0]);
        var status = $("#process_form input[name=status]:checked").val();
        var id = $("#process_form input[name=id]").val();


        if(!$("#file_input").val() && status=='1'){
        	layer.msg("请选择上传文件！");
					$(".layui-layer-dialog .layui-layer-content").css({
						background:'none'
					})
							return
        }


        var url;
        if(status == 1) {
        	url = realmName+"/backend/upload/"+id;
        } else if(status == 2){
        	url = realmName+"/backend/third/"+id;
        } else {
        	url = realmName+"/backend/fiaied/"+id;
        }
		(function(that,opts){
			$.ajax({
				type:"post",
				dataType:"json",
				url: url,
                processData: false, //需设置为false。因为data值是FormData对象，不需要对数据做处理
                contentType: false, //需设置为false。因为是FormData对象，且已经声明了属性enctype="multipar
                data:formdata ,
				success:function (result){
					if(result.msg === "处理成功" || result.msg === "文件上传成功" || result.msg === "已提交第三方处理，请耐心等待第三方应助结果"){
						selfTd.html('<span><a href="javascript:void(0)" onclick="location.reload()" class="btngreen oprbtn">处理成功</a></span>')
					}else{
						selfTd.html('<span><a href="javascript:void(0)" onclick="location.reload()" class="btngreen oprbtn">处理失败</a></span>')
					}
				},
				error:function(){
                    selfTd.html('<span><a href="javascript:void(0)" onclick="location.reload()" class="btngreen oprbtn">处理失败</a></span>')
				}
			})
			selfTd.html('<span>处理中</span>');
		}(selfTd))
		
		$("#docdeliver .btnCancle").click();
		layer.msg("已提交处理！");
		$(".layui-layer-dialog .layui-layer-content").css({
			background:'none'
		})
		return false;
	}
	
	/**审核按钮*/
	$("#data-table").delegate('.help','click',function(){
		var id=$(this).attr("helpRecord_id");
		var title=$(this).attr("data_title");
		$(this).parents("td").addClass("self-shenhe");
		$('#docdeliverHelp input[name=id]').val(id);
		$('#docdeliverHelp span.title').text(title.replace('<b>','').replace('</b>',''));
		$('#docdeliverHelp a.path').attr("href",realmName+"/front/download/"+id);
	});
	/**审核*/
	 $("#docdeliverHelp .btnEnsure").on("click",function(){audit()});
	function audit() {
		var selfTd = $(".self-shenhe");
        var auditStatus = $("#aduit_form input[name=auditStatus]:checked").val();
        var id = $("#aduit_form input[name=id]").val();
        var auditorId = $("#aduit_form input[name=auditorId]").val();
        var auditorName = $("#aduit_form input[name=auditorName]").val();
        var url;
        if(auditStatus == 3) {
        	url = realmName+"/backend/audit/pass/"+id;
        } else {
        	url = realmName+"/backend/audit/nopass/"+id;
        }
        (function(that){
	        $.ajax({
				type:"patch",
				dataType:"json",
				url:url,
				data: {"auditorId": auditorId, "auditorName": auditorName} ,
				success:function (result){
					if(result.code === 200){
						selfTd.html('<span>审核成功</span>');
					}
				},
				error:function(){
					 selfTd.html('<span><a href="javascript:void(0)" onclick="location.reload()" class="btngreen oprbtn">审核失败</a></span>')
				}
			})
			selfTd.html('<span>审核中</span>');
		}(selfTd))
		selfTd.removeClass('self-shenhe');
		$("#docdeliverHelp .btnCancle").click();
		layer.msg("已提交审核！");
	}
	
	//取消按钮
	$(".btnCancle").click(function(){
		$(".thickWarp").hide();
	})
		
	</script>
	</body>
	</html>