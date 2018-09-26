//权威数据库分区列表页js

$('.del_db_partition').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + $(this).attr('db_partition_id');
		$.ajax({
			url : action_target,
			dataType : 'JSON',
			type : 'GET',
			success : function(rs) {
				$('#authority_db_list_btn').click();
			}
		});
	}
	return false;
});

$('.db_partition_pagination a').bind('click', function() {
	var href = $(this).attr('href');
	$('#dbPartition_list_container').load(href, {
		keyword : $("#hidden_keyword").val()
	});
	return false;
});

$('.edit_db_partition').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + $(this).attr('db_partition_id');
		$('#dbPartition_list_container').load(action_target);
	}
	return false;
});