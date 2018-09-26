//数据库列表页js

/**
 * 数据库检索
 */
$('#db_search_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var searchKey = $('#db_search_key').val();
		searchKey = $.trim(searchKey);
		action_target = $.trim(action_target)+$(this).attr('org_id');
		$('#db_list_container').load(action_target, {
			key : searchKey
		});
	}
});

/**
 * 查看数据库规则的列表
 */
$('#db_list_panel table .rule_list_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var dbId = $(this).attr('db_id');
		var orgId = $(this).attr('org_id');
		action_target = $.trim(action_target) + dbId+'/'+orgId;
		$('#db_rules_container').load(action_target,function(){
			$('#db_list_container').hide();
			$('#db_rules_container').show();
		});
	}
});

$('#db_list_panel .db_pagination li a').bind('click', function() {
	if (!$(this).hasClass('current_page')) {
		var href = $(this).attr('href');
		$('#db_list_container').load(href);
	}
	return false;
});