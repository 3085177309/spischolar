<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 高级检索 -->
<div class="showin-bj"></div>
<div class="Win_bj pop so">
	<div class="panel-login">
		<i></i>
		<div class="login-social">
			<form action="<cms:getProjectBasePath/>docList" method="get"
				name="from_gj">
				<p>
					<span class="ck_n">出版物：</span> <input type="text" name="journal"
						class="txt ck_t" value="${condition.journal }"
						style="width: 70%; margin-right: 0px;" /> <a href="javascript:;;"
						class="t" title="在指定出版物中检索文章"></a>
				</p>
				<p>
					<span class="ck_n">文档类型：</span> <select name="fileType"
						class="ck_s">
						<option value="">所有类型</option>
						<option value="pdf"
							<c:if test="${condition.fileType=='pdf' }">selected="selected"</c:if>>PDF</option>
						<option value="doc"
							<c:if test="${condition.fileType=='doc' }">selected="selected"</c:if>>DOC</option>
						<option value="txt"
							<c:if test="${condition.fileType=='txt' }">selected="selected"</c:if>>TXT</option>
						<option value="xls"
							<c:if test="${condition.fileType=='xls' }">selected="selected"</c:if>>XLS</option>
						<option value="ppt"
							<c:if test="${condition.fileType=='ppt' }">selected="selected"</c:if>>PPT</option>
					</select> <a href="javascript:;;" class="t" title="筛选搜索到的文档类型"></a>
				</p>
				<p>
					<span class="ck_n">来源网站：</span>
					<c:set value="" var="site"></c:set>
					<c:forEach var="s" items="${condition.sites }" begin="0" end="0">
						<c:set var="site" value="${s }"></c:set>
					</c:forEach>
					<input type="text" name="sites[0]" class="txt ck_t" value="${site}"
						style="width: 70%; margin-right: 0px;" /> <a href="javascript:;;"
						class="t" title="从指定网站中搜索数据，建议不要与出版物筛选重合使用"></a>
				</p>
				<p>
					<span class="ck_n">年份：</span> <input type="text" name="start_y"
						class="txt ck_t year" value="${condition.start_y }"
						style="margin-right: 0px;" /> <span class="cx">--</span> <input
						type="text" name="end_y" class="txt ck_t year"
						value="${condition.end_y}" style="margin-right: 0px;" /> <a
						href="javascript:;;" class="t" title="筛选年度范围内文章"></a>
				</p>
				<p>
					<span class="ck_n">检索：</span> <select class="ck_s l"
						name="queryType">
						<option value="0"
							<c:if test="${condition.queryType==0 }">selected="selected"</c:if>>模糊检索</option>
						<option value="1"
							<c:if test="${condition.queryType==1 }">selected="selected"</c:if>>精确检索</option>
					</select>
				</p>
				<c:set var="hasGroup" value="false"></c:set>
				<c:forEach var="g" items="${condition.groups }" begin="0" end="0">
					<c:set var="hasGroup" value="true"></c:set>
					<p class="c_type groups_list">
						<select name="groups[0].logic" class="ck_s l"
							style="display: none;">
							<option value="0"
								<c:if test="${g.logic==0 }">selected="selected"</c:if>
								selected="selected">与</option>
							<option value="1"
								<c:if test="${g.logic==1 }">selected="selected"</c:if>>或</option>
							<option value="2"
								<c:if test="${g.logic==2 }">selected="selected"</c:if>>非</option>
						</select> <select name="groups[0].field" class="ck_s">
							<option value="author"
								<c:if test="${g.field=='author' }">selected="selected"</c:if>>作者</option>
							<option value="keyword"
								<c:if test="${g.field=='keyword' }">selected="selected"</c:if>>关键词</option>
							<option value="title"
								<c:if test="${g.field=='title' }">selected="selected"</c:if>>标题</option>
						</select> <input type="text" name="groups[0].value" class="txt"
							value="${g.value }" />
					</p>
				</c:forEach>
				<c:if test="${hasGroup==false }">
					<p class="c_type groups_list">
						<select name="groups[0].logic" class="ck_s l"
							style="display: none;">
							<option value="0" selected="selected">与</option>
							<option value="1">或</option>
							<option value="2">非</option>
						</select> <select name="groups[0].field" class="ck_s">
							<option value="author">作者</option>
							<option value="keyword">关键词</option>
							<option value="title">标题</option>
						</select> <input type="text" name="groups[0].value" class="txt" />
					</p>
				</c:if>
				<c:forEach var="g" items="${condition.groups }" begin="1"
					varStatus="index">
					<p class="c_type groups_list">
						<select name="groups[${index.index }].logic" class="ck_s l">
							<option value="0"
								<c:if test="${g.logic==0 }">selected="selected"</c:if>>与</option>
							<option value="1"
								<c:if test="${g.logic==1 }">selected="selected"</c:if>>或</option>
							<option value="2"
								<c:if test="${g.logic==2 }">selected="selected"</c:if>>非</option>
						</select> <select name="groups[${index.index }].field" class="ck_s">
							<option value="author"
								<c:if test="${g.field=='author' }">selected="selected"</c:if>>作者</option>
							<option value="keyword"
								<c:if test="${g.field=='keyword' }">selected="selected"</c:if>>关键词</option>
							<option value="title"
								<c:if test="${g.field=='title' }">selected="selected"</c:if>>标题</option>
						</select> <input type="text" name="groups[${index.index }].value"
							class="txt" value="${g.value }" /> <a href="javascript:;;"
							class="t p" title="删除"></a>
					</p>
				</c:forEach>
				<p class="c_type" id="add">
					<a href="javascript:;;" class="t z" title="删除"></a>
				</p>
				<div class="social-action">
					<div class="action-auto cf">
						<input type="submit" class="action-btns fl" value="提交" /> <input
							type="button" value="取消" class="action-btns close fr" />
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
(function($){
	function $$(id){
		return document.getElementById(id);
	}
	var tmpl='<select name="" class="ck_s l">'+
		'<option value="0">与</option>'+
		'<option value="1">或</option>'+
		'<option value="2">非</option>'+
	'</select>'+
	'<select name=""  class="ck_s">'+
  		'<option value="author">作者</option>'+
  		'<option value="keyword">关键词</option>'+
  		'<option value="title">标题</option>'+
	'</select>'+
	'<input type="text" name="" class="txt"/>'+
	'<a href="javascript:;;" class="t p" title="删除"></a>';
	function resetNames(){
		var index=0;
		jQuery('p.groups_list').each(function(){
			$(this).find('select:eq(0)').attr('name','groups['+index+'].logic');
			$(this).find('select:eq(1)').attr('name','groups['+index+'].field');
			$(this).find('input').attr('name','groups['+index+'].value');
			index++;
		});
	}
	$(function(){
		$$("add").onclick=function(){
        	var op=this.parentNode,
            myDiv=document.createElement("p");
            myDiv.className="c_type groups_list";
            myDiv.innerHTML=tmpl;
     		op.insertBefore(myDiv,this);
           	delects();
           	resetNames();
    	}
	});
    function delects(){
    	if(!getByClass($$("add").parentNode,"p")[0]){return false}
        var ode=getByClass($$("add").parentNode,"p");
        for (var i = 0; i < ode.length; i++) {
        	ode[i].onclick=function(){
            	$$("add").parentNode.removeChild(this.parentNode);
                resetNames();
            }
        };
    	i=0;
    }
})(jQuery)
</script>
<!-- 高级检索End -->
