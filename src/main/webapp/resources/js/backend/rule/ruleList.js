//规则列表页 js

function delRule(evt) {
	var action_target = $(evt).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var url = action_target + $(evt).attr('ruleId');
		$.ajax({
			url : url,
			dataType : 'JSON',
			type : 'GET',
			success : function() {
				$('#db_rule_list_btn').click();
			}
		});
	}
}

function editRule(evt) {
	var action_target = $(evt).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var url = action_target + $(evt).attr('ruleId');
		$('#rule_list_container').load(url);
	}
}

$('#rule_list_panel .db_pagination li a').bind('click',function(){
	var href = $(this).attr('href') ;
	$('#rule_list_container').load(href);
	return false ;
}) ;