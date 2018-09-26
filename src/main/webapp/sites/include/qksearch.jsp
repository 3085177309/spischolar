<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <div class="qksearch">
    <div class="qksearch-form"> 
    	<dd class="stab">   
        	<form method="get" action="<cms:getProjectBasePath/>journal/search/list" id="journal_search_form">
        		<input type="hidden" name="batchId" value="<cms:batchId />" />
            	<span class="s-input">
                	<input type="text" placeholder="请输入刊名/ISSN/学科名" id="keyword_text" name="value" value="${cdt.value }">
                  	<a href="javascript:void(0)" class="clearinput" id="clearInput"></a>
                </span>
                <span class="s-submit"><input type="submit" id="quick_search_btn"></span>
                <div class="radio_js" id="lan_panel1">
                	<input type="hidden" id="radio_js1" <c:choose><c:when test="${empty cdt.lan }">value="0"</c:when><c:otherwise>value="${cdt.lan }"</c:otherwise></c:choose> name="lan">
                    <span <c:if test="${cdt.lan==0 || empty cdt.lan }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v='0'>全部</span> 
                    <span <c:if test="${cdt.lan==1 }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v="1">中文</span> 
                    <span <c:if test="${cdt.lan==2 }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v="2">外文</span>
                </div>
            </form>
        </dd>
    </div>
</div>
<script type="text/javascript">
$(function(){
	$('#journal_search_form').submit(function(e){
		var val=$('#keyword_text').val();
		if(!val || val =='请输入刊名/ISSN/学科名'){
			alert('请输入关键词!');
			e.preventDefault();
		}
	});
});
</script> --%>
<div class="qksearch-wrap qksearch-wrap-fm">
	<div class="search-box">
		<div class="search-tab" style="display: block">
			<form method="get"
				action="<cms:getProjectBasePath/>journal/search/list">
				<div class="qk-search">
					<input type="text" class="textInput" name="value"
						value="${cdt.value }" autocomplete="off" type_index="1"
						placeholder="请输入刊名/ISSN/学科名"> <input type="submit"
						class="journal_hide_btn"> <input type="hidden"
						name="batchId"> <i class="c-i"></i>
				</div>

			</form>
		</div>
		<div class="search-tab" style="display: none">
			<form method="get" action="<cms:getProjectBasePath/>scholar/list">
				<div class="article-search">
					<input type="text" class="textInput" value="${cdt.value }"
						name="val" autocomplete="off" type_index="1" placeholder="">
					<input type="submit" class="article_hide_btn">
					<!--<i class="c-i"></i>-->
					<div class="gjs-box-c">
						<i></i>
					</div>
				</div>

				<div class="senior-search senior-search-fm" id="senior-search">
					<jsp:include page="asearch.jsp"></jsp:include>
				</div>

			</form>
		</div>

		<div class="search-btn">
			<button
				class="s-qk s-btn  journal_search_btn <c:if test="${mindex!=1 }">active</c:if>">搜期刊</button>
			<button
				class="s-ar s-btn article_search_btn <c:if test="${mindex==1 }">active</c:if>">搜文章</button>
		</div>
		<div class="search-history"></div>
	</div>
</div>