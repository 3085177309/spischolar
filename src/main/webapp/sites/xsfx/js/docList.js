$('#search_submit').bind('click', function() {
	var val = $.trim($('#kw_txt').val());
	var jouarnl=$.trim($('#search_journal').val());
	if ('' == val) {
		alert('请输入关键词!');
		return false;
	}
});

$('#hidden_form li a').bind('click', function() {
	var val = $(this).attr('target_val');
	var id = $(this).attr('target_id');
	$('#' + id).val(val);
	$('#hidden_form').submit();
	return false;
});

$('#hidden_form li input').bind('change', function() {
	$('#hidden_form').submit();
	return false;
});

$('#time_form ul li a').bind('click', function() {
	if ('自定义范围' == $(this).text()) {
		return false;
	}
	$('#as_ylo').val($(this).attr('val'));
	$('#time_form').submit();

	return false;
});

if (!$('#time_form ul li').hasClass('in')) {
	$('#all_time').addClass('in');
}

$('.doc_link_title').bind('click',function(){
	$.ajax({
		url : 'writeLog/'+$(this).attr('siteFlag')+'?type=2&field=link&value=' + encodeURIComponent($(this).text()),
		dataType : 'JSON',
		type : 'GET',
		success : function() {
		}
	});
}) ;