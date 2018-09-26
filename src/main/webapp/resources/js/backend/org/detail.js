// 机构详细页js

$('#mgr_site_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var orgId = $(this).attr('org_id');
		action_target = $.trim(action_target) + orgId;
		menuItemClickListener(this, '#center_panel', action_target);
	}
	return false;
});

// ----------------新增机构开始
function prepareAddOrgListener() {
	var prepare_add_org_action_target = $(this).attr('prepare_add_org_action_target');
	var empty_person_list_action_target = $(this).attr('empty_person_list_action_target');

	if (null != prepare_add_org_action_target && '' != $.trim(prepare_add_org_action_target)) {
		prepare_add_org_action_target = $.trim(prepare_add_org_action_target);
		menuItemClickListener(this, '#org_detail_panel', prepare_add_org_action_target);
	}

	if (null != empty_person_list_action_target && '' != $.trim(empty_person_list_action_target)) {
		empty_person_list_action_target = $.trim(empty_person_list_action_target);
		menuItemClickListener(this, '#org_person_list', empty_person_list_action_target);
	}
	return false;
}
$('#prepare_add_org_btn').bind('click', prepareAddOrgListener);
$('#add_org_btn').bind('click', function() {
	var action = $('#org_form').attr('action');
	if (null != action && '' != $.trim(action)) {
		// 执行机构新增
		action = $.trim(action);
		var data = $('#org_form').serializeArray();
		$('#org_detail_panel').load(action, data,function(){
			reLoadOrgList();
			$('#prepare_add_person_btn').attr('orgid',$('#cp_org_id').val());
			$('#person_org_id').val($('#cp_org_id').val());
		});
	}
	reLoadOrgList();
});
// ----------------新增机构结束

// 重新加载机构列表
function reLoadOrgList() {
	var action_target = $('#org_list_panel').attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		// 重刷机构列表
		action_target = $.trim(action_target);
		menuItemClickListener(this, "#org_list_panel", action_target);
	}
}

// ----------------编辑机构开始
$('#prepare_edit_org_btn').bind('click', function() {
	$('#edit_org_btn').removeClass('hide');
});
$('#edit_org_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		var data = $('#org_form').serialize();
		var settings = {
			url : action_target,
			dataType : 'JSON',
			data : data,
			type : 'POST',
			success : function(rs) {
				if (null != rs.error) {
					$('.org_error').removeClass('hide');
					$('.org_error span').text(rs.error);
				} else {
					reLoadOrgList();
					$('#edit_org_btn').addClass('hide');
					$('.org_error').addClass('hide');
				}
			}
		};
		$.ajax(settings);
	}
});
// ----------------编辑机构结束

// ----------------删除机构开始
$('#org_delete').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var orgId = $(this).attr('org_id');
		action_target = $.trim(action_target) + orgId;
		$('#org_detail_panel').load(action_target, function() {
			reLoadOrgList();
		});
	}
});
// ----------------删除机构结束

// -------------ip更新开始
$('#add_ip_btn').bind('click', function() {
	var ipInputArr = $('.ip_input');
	if ('' == $.trim($(ipInputArr[0]).val())) {
		alert('ip不能为空!');
		return;
	}
	if ('' == $.trim($(ipInputArr[1]).val())) {
		alert('ip不能为空!');
		return;
	}
	var newIpRange = $(ipInputArr[0]).val() + '---' + $(ipInputArr[1]).val();
	var ipRanges = newIpRange;
	var ipArr = $('#ip_list_panel strong');
	var hasSame = false;
	for (var i = 0; i < ipArr.length; i++) {
		var ips = $(ipArr[i]).text();
		ips = $.trim(ips);
		if (ips == newIpRange) {
			hasSame = true;
			break;
		}
		ipRanges += ';' + ips;
	}
	if (hasSame) {
		alert('该ip范围已添加!');
		return;
	}
	var data = 'ipRanges=' + ipRanges + '&id=' + $(this).attr('org_id');
	var action_target = $(this).attr('action_target');
	if (null == action_target || '' == $.trim(action_target)) {
		return;
	}
	action_target = $.trim(action_target);
	$.ajax({
		url : action_target,
		dataType : 'JSON',
		type : 'POST',
		data : data,
		success : function(rs) {
			if (null != rs.error) {
				alert(rs.error);
			} else {
				$('#ip_list_panel').append("<div><strong>" + newIpRange + "</strong><button class='btn btn-mini btn-warning' onclick='removeIpRange(this)'>删除</button></div>");
			}
		}
	});
});

function removeIpRange(evt) {
	$(evt).parent().remove();
	var ipRangDomArr = $('#ip_list_panel strong');
	var ipRanges = '';
	for (var i = 0; i < ipRangDomArr.length; i++) {
		if (i == (ipRangDomArr.length - 1)) {
			ipRanges += $(ipRangDomArr[i]).text();
		} else {
			ipRanges += $(ipRangDomArr[i]).text() + ';';
		}
	}
	var data = 'ipRanges=' + ipRanges + '&id=' + $('#cp_org_id').val();
	$.ajax({
		url : 'backend/org/editIpRange',
		dataType : 'JSON',
		type : 'POST',
		data : data,
		success : function(rs) {
			if (null != rs.error) {
				alert(rs.error);
			}
		}
	});
}
// -------------ip更新结束

$('#org_cache_reload_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var org_id = $(this).attr('org_id');
		if ('' == $.trim(org_id)) {
			alert('机构信息异常!');
			return false;
		}
		action_target = $.trim(action_target) + org_id;
		$.ajax({
			url : action_target,
			type : 'GET',
			dataType : 'JSON',
			success : function(rs) {

			}
		});
	}
});

$('#mgr_db_rule_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		// 获取机构id
		var org_id = $(this).attr('org_id');
		action_target = $.trim(action_target) + org_id;
		$('#center_panel').load(action_target);
	}
});
