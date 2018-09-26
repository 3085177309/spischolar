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
						<a href="<cms:getProjectBasePath/>backend/system/powers"
							class="in">栏目显示</a> <a
							href="<cms:getProjectBasePath/>backend/system/powers/quota">流量指标显示</a>
						<a href="<cms:getProjectBasePath/>backend/system/powers/delivery">文献互助请求</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="change_form" method="get"
									action="<cms:getProjectBasePath/>backend/system/powers/powerSerach">
									<label class="common"> <input type="text"
										class="tbSearch keyword" name="name" placeholder="请输入学校名称或栏目">
										<button class="tbBtn" type="submit">查询</button>
									</label>
								</form>
							</div>
							<table class="jurisdiction">

								<tr>
									<th width="12%">栏目名称</th>
									<th width="50px" style="text-align: center"></th>
									<th>学校</th>
								</tr>
								<c:forEach items="${powers.nodes }" var="pows"
									varStatus="status">
									<tr>
										<td><span>&nbsp;&nbsp;${pows.columnName}</span></td>
										<td class="tc"><a class="opradded"
											data-thickcon="addAccount"
											onclick="getId(${pows.id},${pows.pid})"></a></td>
										<td><c:forEach items="${pows.org }" var="org"
												varStatus="status">
												<span class="widthseting" id="${org.flag}"><a
													class="enabledelete">${org.name}<i
														onclick="del(${pows.id},${pows.pid},${org.id},'${org.flag}')"></i></a></span>
											</c:forEach></td>
									</tr>
									<c:forEach items="${pows.nodes }" var="pow" varStatus="stat">
										<tr>
											<td><span>&nbsp;&nbsp;&nbsp;&nbsp;${pow.columnName}</span></td>
											<td class="tc"><a class="opradded"
												data-thickcon="addAccount"
												onclick="getId(${pow.id},${pow.pid})"></a></td>
											<td><c:forEach items="${pow.org }" var="org"
													varStatus="status">
													<span class="widthseting" id="${org.flag}"><a
														class="enabledelete">${org.name}<i
															onclick="del(${pow.id},${pow.pid},${org.id},'${org.flag}')"></i></a></span>
												</c:forEach></td>
										</tr>
									</c:forEach>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
	<div class="tickbox">
		<div id="addAccount" class="schoolTick" data-tit="选择学校<em>(可多选)</em>">
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
<script type="text/javascript">
	var flags="",id="",pid="";
	function getId(sid,parentid){
		id = sid;
		pid=parentid;
	}
	function department(){
		$(".schoolChecked .list span").each(function(i){
			if(0==i){
				flags =$(this).attr("v");
			}else{
				flags += ("," + $(this).attr("v"));
			}
		});
		if(''==flags){
			layer.alert("请选择学校机构！");
			return;
		}
		$(".thickWarp").hide();
		$.ajax({
            async : true,
            cache : false,
            type : 'POST',
            url : "<cms:getProjectBasePath/>backend/system/powers/add",
            data : {"id":id,"pid":pid,"flags":flags},
            success : function(data) {
              data = eval("("+data.message+")");
              window.location.reload();
            }
        });
	}
	function del(cid,parid,schoolid,flag){
		id = cid;
		pid=parid;
		flags = flag;
		
		var index=layer.confirm('确定要删除?', {
		    btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
	            async : true,
	            cache : false,
	            type : 'POST',
	            url : "<cms:getProjectBasePath/>backend/system/powers/del",
	            data : {"id":id,"pid":pid,"flag":flags,"orgId":schoolid},
	            success : function(data) {
	              data = eval("("+data.message+")");
	              window.location.reload();
	            }
	        });
		}, function(){
			layer.close(index);
		    return false;
		});
		
		/* if (gnl!=true){
			return false;
		} */
		
	}
	(function($){
    	var schoolselect=$(".schoolselect"),
    		provinceBox=$(".provinceBox"),
    		schoolChecked=$(".schoolChecked .list");
    	schoolselect.find("ul").eq(0).show();
    	provinceBox.find("span").eq(0).addClass("in");
    	tab(provinceBox[0].getElementsByTagName("span"),schoolselect[0].getElementsByTagName("ul"));
    	
    	schoolselect.find("ul li").bind("click",function(){
    		var classtext = $(this).attr("class");
    		if(classtext=='schdisable'){
    			return false;
    		}
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
    				layer.alert("不可重复选择！")
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
    	
    	
    	$(".opradded").click(function(){
    		$("div.schoolselect ul li").each(function(){
    			$(this).removeAttr("class");
    		});
    		var data = $(this).parent().next().find("span");
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
