//数据库规则管理首页 js

$('#db_list_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var orgId = $(this).attr('orgId');
		action_target = $.trim(action_target)+orgId;
		$('#db_list_container').load(action_target, {
			key : ''
		},function(){
			$('#db_list_container').show();
			$('#db_rules_container').hide();
		});
	}
	return false;
});

$('#db_list_btn').click();