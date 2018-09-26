// 人员列表页js

//详细按钮点击
$('.user_detail_btn').bind('click', function() {
	var userId = $(this).attr('user_id');
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + userId;
		$('#person_detail_container').load(action_target, function() {
			$('#person_list_container').hide();
			$('#person_detail_container').show();
		});
	}
	return false;
});

// 分页链接点击
$('.person_pagination a').bind('click', function() {
	var href = $(this).attr('href');
	$('#person_list_container').load(href);
	return false;
});

function resetPwd(evt){
	var action_target = $(evt).attr('action_target') ;
	if(null!=action_target && ''!=$.trim(action_target)){
		$.ajax({
			url:action_target+$(evt).attr('user_id'),
			dataType:'JSON',
			type:'GET',
			success:function(){
				alert('密码已重置!');
			}
		})
	}
}