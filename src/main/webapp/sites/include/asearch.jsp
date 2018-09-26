<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="senior-search-box">
	<form action="<cms:getProjectBasePath/>scholar/list" method="get"
		id="advance-search-form">
		<input type="hidden" name="batchId" value="<cms:batchId />" />
		<div class="sc_line_box">
			<span class="sc_s">检索：</span>
			<div class="sc_selbox">
				<i></i> <span id="section_sy"> <c:if
						test="${empty condition.queryType || condition.queryType==0 }">模糊搜索</c:if>
					<c:if test="${condition.queryType==1 }">精确搜索</c:if>
				</span>
				<div class="sc_selopt">
					<a href="javascript:chooseQueryType(0)">模糊搜索</a> <a
						href="javascript:chooseQueryType(1)">精确搜索</a>
				</div>
				<input type="hidden" name="queryType"
					value="${empty condition.queryType ? 0 :condition.queryType }">
			</div>
			<div class="clear"></div>
		</div>
		<c:set var="hasGroup" value="false"></c:set>
		<c:forEach var="g" items="${condition.groups }" begin="0" end="0">
			<c:set var="hasGroup" value="true"></c:set>
			<div class="sc_line_box box_group">
				<span class="sc_s"></span> <select name="field" class="select">
					<option value="keyword"
						<c:if test="${g.field=='keyword' }">selected="selected"</c:if>>关键词</option>
				<c:if test="${source == 0 }">
					<option value="author"
						<c:if test="${g.field=='author' }">selected="selected"</c:if>>作者</option>
				</c:if>
					<option value="title"
						<c:if test="${g.field=='title' }">selected="selected"</c:if>>标题</option>
				</select> <input type="text" name="value" class="txt sc_put sc_keyword"
					value="${g.value }"> <a href="javascript:;;"
					class="addsenior-con z" source="${source}" title="添加"></a>
				<div class="clear"></div>
			</div>
		</c:forEach>
		<c:if test="${hasGroup==false }">
			<div class="sc_line_box box_group">
				<span class="sc_s"><select name="field" class="select fr"
					style="width: 70px;">
						<option value="keyword">关键词</option>
					<c:if test="${source == 0 }">	
						<option value="author">作者</option>
					</c:if>	
						<option value="title">标题</option>
				</select></span> <input type="text" name="value" class="txt sc_put"> <a
					href="javascript:;;" class="addsenior-con z" source="${source}" title="添加"></a>
				<div class="clear"></div>
			</div>
		</c:if>
		<c:forEach var="g" items="${condition.groups }" begin="1"
			varStatus="index">
			<div class='sc_line_box box_group'>
				<span class='sc_s'></span> <select class="select select-p">
					<option value="0"
						<c:if test="${g.logic==0 }">selected="selected"</c:if>>与</option>
					<option value="1"
						<c:if test="${g.logic==1 }">selected="selected"</c:if>>或</option>
					<option value="2"
						<c:if test="${g.logic==2 }">selected="selected"</c:if>>非</option>
				</select><select name="field" class="select select-p">
					<option value="keyword"
						<c:if test="${g.field=='keyword' }">selected="selected"</c:if>>关键词</option>
				<c:if test="${source == 0 }">		
					<option value="author"
						<c:if test="${g.field=='author' }">selected="selected"</c:if>>作者</option>
				</c:if>	
					<option value="title"
						<c:if test="${g.field=='title' }">selected="selected"</c:if>>标题</option>
				</select><input type='text' name="value" class='txt sc_put sc_keyword'
					value="${g.value }" /> <a class='addsenior-con t' title='删除'></a>
				<div class="clear"></div>
			</div>
		</c:forEach>
		<div class="sc_line_box">
			<span class="sc_s">年份：</span> <input type="text" name="start_y"
				class="txt sc_put time" value="${condition.start_y }"
				onkeyup="clearNotInt(this)"> <span class="sc_line">--</span>
			<input type="text" name="end_y" class="txt sc_put time"
				value="${condition.end_y}" onkeyup="clearNotInt(this)"> <a
				href="" class="t" title="在指定出版物中检索文章"></a>
			<div class="clear"></div>
		</div>
	<c:if test="${source == 0 }">	
		<div class="sc_line_box">
			<span class="sc_s">出版物：</span> <input type="text" name="journal"
				class="txt sc_put" value="${condition.journal }"> <a href=""
				class="t" title="在指定出版物中检索文章"></a>
			<div class="clear"></div>
		</div>

		<div class="sc_line_box">
			<span class="sc_s">来源网站：</span>
			<c:set value="" var="site"></c:set>
			<c:forEach var="s" items="${condition.sites }" begin="0" end="0">
				<c:set var="site" value="${s }"></c:set>
			</c:forEach>
			<input type="text" name="sites[0]" class="txt sc_put" value="${site}">
			<a href="" class="t" title="在指定出版物中检索文章"></a>
			<div class="clear"></div>
		</div>
		<div class="sc_line_box">
			<span class="sc_s">文档类型：</span>
			<div class="sc_selbox">
				<i></i> <span id="section_lx">所有类型</span>
				<div class="sc_selopt">
					<a href="javascript:chooseFileType('')">所有类型</a> <a
						href="javascript:chooseFileType('pdf')">PDF</a> <a
						href="javascript:chooseFileType('doc')">DOC</a> <a
						href="javascript:chooseFileType('txt')">TXT</a> <a
						href="javascript:chooseFileType('xls')">XLS</a> <a
						href="javascript:chooseFileType('ppt')">PPT</a>
				</div>
				<input type="hidden" name="fileType" value="20">
				<script type="text/javascript">
			function chooseFileType(v){
				jQuery('#advance-search-form input[name="fileType"]').val(v);
			}
			function chooseQueryType(v){
				jQuery('#advance-search-form input[name="queryType"]').val(v);
			}
			</script>
			</div>
			<div class="clear"></div>
		</div>
</c:if>
		<script type="text/javascript">
		function chooseField(field){
			var selbox=$(target).parent().parent();
			selbox.find('input[name="field"]').val(field);
		}
		function chooseLogic(logic,target){
			var selbox=$(target).parent().parent();
			selbox=selbox.find('input[name="logic"]').val(logic);
		}
	</script>


		<div class="sc_line_box">
			<span class="sc_s" style="text-indent: -9999px;">&nbsp;</span> <input
				type="submit" class="submit-btn" value="检索"
				style="display: block; float: left">
			<div class="clear"></div>
		</div>
	</form>
	<script type="text/javascript">
$(function(){
	$('#advance-search-form').submit(function(e){
		var i=0;
		var falg = false;
		$('.box_group').each(function(){
			$(this).find('select[name$="logic"]').attr('name','groups['+i+'].logic');
			$(this).find('select[name$="field"]').attr('name','groups['+i+'].field');
			$(this).find('input[name$="value"]').attr('name','groups['+i+'].value');
			i++;
		});
		$('.txt.sc_put').each(function(){
			var txt = $(this).val();
			if(txt != "") {
				falg = true;
			}
		});
		if(!falg) {
			shake();
		}
		return falg;
	});
	
	function shake(){
	    var style=document.getElementById("senior-search").style;
	    p=[3,7,3,0,-3,-7,-3,0]
	    fx=function(){
	        style.marginLeft = p.shift() + 'px';
	        if (p.length <= 0) {
	                style.marginLeft = 0;
	                clearInterval(timerId);
	        };
	    }
	    p = p.concat(p.concat(p));
	    timerId = setInterval(fx, 13);
	}

});
</script>
</div>