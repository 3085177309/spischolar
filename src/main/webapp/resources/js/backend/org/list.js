// 机构列表页js

if($('#org_list_grid tbody tr').length>0){
	$('#org_list_grid tbody tr').bind('click', function() {
		// 获取机构详细
		var detail_action_target = $(this).attr('detail_action_target');
		var orgId = $(this).attr('orgId');
		if (null != detail_action_target && '' != $.trim(detail_action_target)) {
			detail_action_target = $.trim(detail_action_target) + orgId;
			menuItemClickListener(this, '#org_detail_panel', detail_action_target);
		}

		// 获取人员列表
		var persons_action_target = $(this).attr('persons_action_target');
		if (null != persons_action_target && '' != $.trim(persons_action_target)) {
			persons_action_target = $.trim(persons_action_target) + orgId;
			menuItemClickListener(this, '#org_person_list', persons_action_target);
		}
	});
}else{
	var tr = $('#org_list_grid thead tr:eq(0)');
	// 获取机构详细
	var detail_action_target = $(tr).attr('detail_action_target');
	var orgId = $(tr).attr('orgId');
	if (null != detail_action_target && '' != $.trim(detail_action_target)) {
		detail_action_target = $.trim(detail_action_target) + orgId;
		menuItemClickListener(tr, '#org_detail_panel', detail_action_target);
	}

	// 获取人员列表
	var persons_action_target = $(tr).attr('persons_action_target');
	if (null != persons_action_target && '' != $.trim(persons_action_target)) {
		persons_action_target = $.trim(persons_action_target) + orgId;
		menuItemClickListener(tr, '#org_person_list', persons_action_target);
	}
}

// 机构列表翻页事件
$('.org_pagination ul a').bind('click', function() {
	if (!$(this).hasClass('current_page')) {
		var href = $(this).attr('href');
		$('#org_list_panel').load(href);
	}
	return false;
});