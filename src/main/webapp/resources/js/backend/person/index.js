// 人员管理首页js

$('#prepare_add_person_btn').bind('click', function() {
	var orgId = $('#person_org_id').val();
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + orgId;
		$('#person_detail_container').load(action_target);
		$('#person_list_container').hide();
		$('#person_detail_container').show();
	}
	return false;
});

//机构人员列表获取开始
$('#person_list_btn').bind('click', function() {
	// 获取所属机构
	var orgId = $('#person_org_id').val();
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + orgId;
		menuItemClickListener(this, '#person_list_container', action_target);
		$('#person_detail_container').hide();
		$('#person_list_container').show();
	}
	return false;
});
// 机构人员列表获取结束

$('#person_list_btn').click();