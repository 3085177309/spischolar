// 机构管理首页js

/**
 * 加载机构列表
 */
function loadOrgList() {
	var orgListPanel = $('#org_list_panel');
	if (null != orgListPanel) {
		var action_target = $(orgListPanel).attr('action_target');
		if (null != action_target && '' != $.trim(action_target)) {
			// 加载机构列表
			$(orgListPanel).load(action_target, function() {
				// 机构列表加载完毕之后，自动查看第一个机构的详细信息，和人员列表
				$('#org_list_grid tbody tr:eq(0)').click();
			});
		}
	}
}

loadOrgList();

function loadMyOrgInfo(){
	var myOrgDom = $('#my_org_id').get(0);
	if (undefined != myOrgDom) {
		var detail_action_target = $(myOrgDom).attr('detail_action_target');
		var orgId = $(myOrgDom).val();
		//加载机构详细
		if (null != detail_action_target && '' != $.trim(detail_action_target)) {
			detail_action_target = $.trim(detail_action_target) + orgId;
			menuItemClickListener(myOrgDom, '#org_detail_panel', detail_action_target);
		}
		//加载人员列表
		var persons_action_target = $(myOrgDom).attr('persons_action_target');
		if (null != persons_action_target && '' != $.trim(persons_action_target)) {
			persons_action_target = $.trim(persons_action_target) + orgId;
			menuItemClickListener(myOrgDom, '#org_person_list', persons_action_target);
		}
	}
}

loadMyOrgInfo();