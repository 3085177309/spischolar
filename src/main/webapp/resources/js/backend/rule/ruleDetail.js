//规则详细页面js

function saveOrEditRule(evt) {
	var action_target = $(evt).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		var data = $('#rule_form').serializeArray();
		$('#rule_list_container').load(action_target, data);
	}
}