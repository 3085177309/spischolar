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
						<label class="data-type"> <span class="labt">状态:</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<span id="section_lx">全部</span>
								<div class="sc_selopt" style="display: none;">
									<p class="type" value="">全部</p>
									<p class="type" value="false">未复用</p>
									<p class="type" value="true">已复用</p>
								</div>
								<input type="hidden" name="reusing" >
							</div>
						</label>
						<div class="input-s-w">
							<input type="text" class="tbSearch subselect keyword"
								autocomplete="off" name="keyword" placeholder="请输入标题查询"
								value="${keyword }" /> 
								<input class="tbBtn submit" id="search" value="查询"
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

					<div id="docdeliver" class="docdeliver" style="width: 550px;"
						data-tit="处理">
						<form method="post" action="list/process"
							enctype="multipart/form-data" id="reuse_form">
							<input type="hidden" name="id" /> 
							<input type="hidden" name="giverId" value="${front_member.id }" /> 
							<input type="hidden" name="giverName" value="${front_member.username }" /> 
							<table>
								<thead>
									<tr><td>标题：</td><td width="70%"><a class="labcon" target="_blank" id="title_div" ></a></td><td></td></tr>
								</thead>
								<tbody id="docFile">
								</tbody>
							</table>
						</form>
					</div>
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
	
	
	var ajaxHand = function(data,pageUrl){
		console.log(pageUrl);
		// 分页条插件配置项
		$('.pagination').pagination({
		    coping: true,
		    totalData:data.totalElements?data.totalElements:1, // 数据总数
		    isData:true, // 显示数据条数按钮
		    current:data.number+1, // 当前页
		    showData:20, // 每页20条
		    isHide:true,
		    jumpBtn:"GO",
		    prevContent: '上一页',
		    homePage:"首页",
		    nextContent: '下一页',
		    endPage:"末页",
		    callback: function (api) {
		    	var page = api.getCurrent() - 1;
		    	$.ajax({
		    		url:pageUrl+'?page='+page+'&size=20',
					type:'get',
					success:function(data2){
						renderHtml(data2.body.content);
					}
		    	})
		    }
		});
		renderHtml(data.content);
	}
    
	window.onload=function(){
		searchList();
	}
	
	function searchList() {
		var reusing = $('#change_form input[name=reusing]').val();
		var keyword = $('#change_form input[name=keyword]').val();
		$.ajax({
			type:"get",
			dataType:"json",
			url: realmName+"/backend/literature/list",
			data: {"reusing": reusing,"keyword": keyword,"page":0,"size":20} ,
			success:function (result){
				var pageUrl = realmName+'/backend/literature/list/';
				ajaxHand(result.body,pageUrl);
				
			},
			error:function(){
			}
		})
	}
	
	var renderHtml = function(data){
		$('#data-table').empty();
		$('#data-table').append("<tr><th width='8%'><span>序号</span></th><th width='70%'><span>标题</span></th><th><span>操作人</span></th><th width='10%'><span>操作</span></th></tr>"); 
   		if(data.length != 0) {
   			for ( var i = 0; i < data.length; i++) {
   				var jsAr = new Array();
			 	var literature = data[i];
			 	
			 	var tr = "<tr><td>"+(i+1)+"</td><td>"+literature.docTitle+"</td>";
			 	button = "<a href='javascript:void(0);' data-thickcon='docdeliver' class='oprbtn btngreen handle' literature_id='"+literature.id+"' data_title='"+literature.docTitle+"' data_url='"+literature.docHref+"' >处理</a>";
			 	
			 	var person = "";
			 	var files = literature.docFiles;
			 /* 	for(var j = 0; j < files.length; j++) {
			 		if(files[j].reusing) {
			 			person = files[j].auditorName;
			 		}
			 	} */
			 	if(files[0].auditorName != null) {
			 		person = files[0].auditorName;
   				}
			 	tr = tr + "<td>"+person+"</td>";
			 	tr = tr + "<td>"+button+"</td></tr>";
			 	
			 	jsAr.push(tr);
				$('#data-table').append(jsAr);
   			}
   		 }
	}
	
	//状态下拉框
	$('.type').click(function(){
		var vals=$(this).attr("value");
		$('input[name=reusing]').val(vals);
		searchList();
	});
	
	$('#search').click(function(){
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
        	return false;
        }
    });
	
	/**处理按钮*/
	$("#data-table").on('click','.handle',function(){
		var id=$(this).attr("literature_id");
		var title=$(this).attr("data_title");
		var url=$(this).attr("data_url");
		var status=$(this).attr("helpRecord_status");
		$(this).parents("td").addClass("self-chuli");
		$('#reuse_form input[name=id]').val(id);
		$('#reuse_form #title_div').html(title.replace('<b>','').replace('</b>',''));
		$('#reuse_form #title_div').attr('href',url);
		getDocFiles(id);
	});
	
	
	var getDocFiles = function(literatureId){
		$.ajax({
			type:"get",
			dataType:"json",
			url: realmName+"/backend/docFile/list",
			data: {"literatureId": literatureId} ,
			success:function (result){
				docFilesHtml(result.body,literatureId);
			},
			error:function(){
			}
		})
	}
	
	var docFilesHtml = function(data,literatureId){
		$('#docFile').empty();
   		if(data.length != 0) {
   			for ( var i = 0; i < data.length; i++) {
   				var jsAr = new Array();
			 	var docFiles = data[i];
			 	var button = "";
				if(docFiles.reusing) {
					button = "<a reuse='2' literature_id='"+literatureId+"' docFile_id='"+docFiles.id+"' class='oprbtn btngreen reuse'>取消复用</a>";
			 	} else {
			 		button = "<a reuse='1' literature_id='"+literatureId+"' docFile_id='"+docFiles.id+"' class='oprbtn btngreen reuse'>复用</a>";
			 	}
			 	var tr = "<tr><td>docFile:</td><td><a href="+ realmName +"/backend/download/"+docFiles.id+">"+docFiles.fileName + "." + docFiles.fileType +"</a></td><td>"+button+"</td></tr>";
			 	jsAr.push(tr);
				$('#docFile').append(jsAr);
   			}
   		 }
	}
	
	/**复用-取消复用*/
	$("#reuse_form").on('click','.reuse',function(){
		var selfButton = $(this);
		var id = $(this).attr("docFile_id");
		var reuse = $(this).attr("reuse");
		var reuseUserName = '${front_member.username }';
		var reuseUserId = '${front_member.id }';
		var literatureId = $(this).attr("literature_id");
        var url;
        if(reuse == 1) {
        	url = realmName+"/backend/reusing/pass/"+id;
        } else {
        	var reMark = "错误";
        	url = realmName+"/backend/reusing/nopass/"+id;
        }

        $.ajax({
			type:"get",
			dataType:"json",
			url:url,
			data: {"reuse":reuse,"reMark":reMark,"reuseUserName":reuseUserName,"reuseUserId":reuseUserId,"literatureId":literatureId},
			success:function (result){

				if(result.code == 200){
					if(reuse == 1) {
						selfButton.attr("reuse",2);
						selfButton.text("取消复用");
					} else {
						selfButton.attr("reuse",1);
						selfButton.text("复用");
					}
				} else if(result.code == 0) {
					layer.msg(result.msg);
				}
			},
			error:function(){
			}
		})
	});
	
	
	//取消按钮
	$(".btnCancle").click(function(){
		$(".thickWarp").hide();
	})
		
	</script>
	</body>
	</html>