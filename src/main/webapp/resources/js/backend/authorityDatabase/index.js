//权威数据库分区管理首页js

$('#db_partition_search_btn').bind('click',function(){
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var key = $('#db_partition_key').val();
		key = $.trim(key) ;
		action_target = $.trim(action_target);
		$('#dbPartition_list_container').load(action_target, {
			"keyword" : key
		});
	}
}) ;

$('#addDbPartitionModal').on('hidden',function(){
	$('#db_partition_form input').val('');
}) ;

$('#add_db_partion_btn').bind('click', function() {
	var action_form = $(this).attr('action_form');
	if (null != action_form && '' != $.trim(action_form)) {
		action_form = $.trim(action_form);
		var data = $('#db_partition_form').serialize();
		$.ajax({
			url : action_form,
			dataType : 'JSON',
			type : 'POST',
			data : data,
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				}else{
					$('#authority_db_list_btn').click();
					$('#addDbPartitionModal').modal('hide');
				}
			}
		});
	}
});

$('#authority_db_list_btn').bind('click',function(){
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		$('#dbPartition_list_container').load(action_target, {
			"keyword" : ""
		});
	}
	return false;
}) ;

$('#authority_db_list_btn').click();