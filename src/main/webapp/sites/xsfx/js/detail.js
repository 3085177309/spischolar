var first = true;
var data = $('#update_click_count_form').serialize();
// 更新点击量
$.ajax({
	url : 'updateClickCount',
	data : data,
	dataType : 'JSON',
	type : 'GET',
	success : function(rs) {

	}
});

// 获取期刊最近文章
/*
var action_target = $('#doc_container').attr('action_target');
if (null != action_target && '' != $.trim(action_target)) {
	var journalName = $.trim($('#journal_name').text());
	if ('' != journalName) {
		action_target = $.trim(action_target) + "?val=" + $('#journal_name').text().replace(/&/g,'%26') + "&field=journal&start_y=" + new Date().getFullYear();
		$('#doc_container').load(encodeURI(action_target));
	}
}*/

// 记录日志
var log_url = $('#logUrl').val();
if (null != log_url && '' != $.trim(log_url)) {
	log_url = $.trim(log_url)+'?field=id&type=1&value='+encodeURI($('#journal_name').text());
	$.ajax({
		url : log_url,
		type : 'GET',
		dataType : 'JSON',
		success : function() {
		}
	});
}

$('#journal_name').bind('click',function(){
	$.ajax({
		url : 'writeLog?type=1&field=link&value=' + encodeURIComponent($(this).text()),
		dataType : 'JSON',
		type : 'GET',
		success : function() {
		}
	});
}) ;