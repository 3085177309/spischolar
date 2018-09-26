<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<div class="search png">
	<form id='quick_search_form' method="get"
		action="<cms:getProjectBasePath/>list/result">
		<div class="topBox">
			<input type="hidden" id="fieldFlag" value="全部V" />
			<div class="select_ png" id='field_panel'>
				<a href="javascript:void(0)" onclick="show_list(this)"
					class="png select_box" id="select_box" value='all'>全部</a>
				<p style="min-width: 31px; display: none;" id='field_list'>
					<a href="javascript:void(0)" v='全部V'
						onclick='index_js_setFl(this,"select_box","fieldFlag");return false;'
						value='all'>全部</a> <a href="javascript:void(0)" v='刊名V'
						onclick='index_js_setFl(this,"select_box","fieldFlag");return false;'
						value='title'>刊名</a> <a href="javascript:void(0)" v='ISSNV'
						onclick='index_js_setFl(this,"select_box","fieldFlag");return false;'
						value='issn'>ISSN</a> <a href="javascript:void(0)" v='学科V'
						onclick='index_js_setFl(this,"select_box","fieldFlag");return false;'
						value='disciplineName'>学科</a>
				</p>
			</div>
			<input type="text" class="text" autocomplete="off" value=""
				id='keyword_text' name='value' /> <input type="submit" value=""
				class="submit png" id='quick_search_btn'> <input
				type="hidden" id='docTypeHide' value="9" name='docType' /> <input
				type="hidden" id='docLanHide' value="0" name='lan' /> <input
				type="hidden" id='fieldHide' value="all" name='field' /> <input
				type="hidden" value="list" name='viewStyle' /> <input type="hidden"
				value="1" name='limit' />
		</div>
		<div class="radio_js" id='lan_panel'>
			<input type="hidden" id="radio_js" value="全部V" /> <span
				id="radio_js_in" v="全部V"
				onclick='search_lang(this,"radio_js","radio_js_in");return false'
				value='0'>全部</span> <span v="中文V"
				onclick='search_lang(this,"radio_js","radio_js_in");return false'
				value='1'>中文</span> <span v="外文V"
				onclick='search_lang(this,"radio_js","radio_js_in");return false'
				value='2'>外文</span>
		</div>
	</form>
</div>
<script type="text/javascript">
(function($){
	var rlaceholders=['请输入刊名、ISSN查找期刊','请输入刊名查找期刊','输入ISSN查找期刊','请输入关键词查找学科','请输入关键词'];
	function checkIn(val){
		for(var i=0;i<rlaceholders.length;i++){
			if(rlaceholders[i]==val){
				return true;
			}
		}
		return false;
	}
	$('#quick_search_btn').bind('click', function() {
		var key = $.trim($('#keyword_text').val());
		if ('' == key||checkIn(key)) {
			alert('请输入关键词!');
			return false;
		}
	});
	$('#keyword_text').focus(function(){
		var key = $.trim($('#keyword_text').val());
		$(this).removeClass('shadow');
		if(checkIn(key)){
			$('#keyword_text').val('');
		}
	}).blur(function(){
		var key = $.trim($('#keyword_text').val());
		if(key==''){
			setFieldField();
		}
	});
	function setFieldField(){
		$('#keyword_text').addClass('shadow');
		var field=$.trim($('#fieldHide').val());
		if(field=='all'){
			$('#keyword_text').val(rlaceholders[0]);
		}else if(field=='title'){
			$('#keyword_text').val(rlaceholders[1]);
		}else if(field=='issn'){
			$('#keyword_text').val(rlaceholders[2]);
		}else if(field=='disciplineName'){
			$('#keyword_text').val(rlaceholders[3]);
		}else{
			$('#keyword_text').val(rlaceholders[4]);
		}
	}
	function fieldClick() {
		var field = $(this).attr('value');
		$('#fieldHide').val(field);
		var val=$.trim($('#keyword_text').val());
		if(!val||checkIn(val)){
			setFieldField();
		}
		return false;
	}
	$('#field_panel p a').bind('click', fieldClick);

	var defaultFeild = $('#fieldHide').val();
	var aJqObj = $('#field_list a');
	$.each(aJqObj, function(k, v) {
		if (defaultFeild == $(v).attr('value')) {
			$(v).click();
			return;
		}
	});
	function lanClick() {
		var lan = $(this).attr('value');
		$('#docLanHide').val(lan);
	}

	$('#lan_panel span').bind('click', lanClick);

	var defaultLan = $('#docLanHide').val();
	var spanJqObj = $("#lan_panel span");
	$.each(spanJqObj, function(k, v) {
		if (defaultLan == $(v).attr('value')) {
			$(v).click();
			return false;
		}
	});
})(jQuery);
</script>