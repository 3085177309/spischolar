//人员详细页js

$('#add_person_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		var data = $('#person_form').serializeArray();
		$('#person_detail_container').load(action_target, data);
	}
});

// 准备编辑人员信息
$('#prepare_person_edit').bind('click', function() {
	$('#person_edit').show();
	return false;
});

$('#person_edit').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		var data = $('#person_form').serializeArray();
		$('#person_detail_container').load(action_target, data);
	}
	return false;
});

// 人员删除
$('#del_person').bind('click', function() {
	var user_id = $(this).attr('user_id');
	var org_id = $(this).attr('org_id');
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + org_id + '/' + user_id;
		$('#person_list_container').load(action_target, function() {
			$('#person_list_container').show();
			$('#person_detail_container').hide();
		});
	}
	return false;
});