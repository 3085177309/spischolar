//权威数据库分区编辑页js

$('#authority_db_edit_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target) {
		action_target = $.trim(action_target);
		var data = $('#authority_db_form').serializeArray();
		$('#dbPartition_list_container').load(action_target, data);
	}
	return false;
});