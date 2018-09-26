var boxArr = $('.box');
console.log(boxArr);
$.each(boxArr, function(k, v) {
	var action_target = $(v).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		$(this).load(action_target);
	}
});

$('#log_time_sel').bind('change', function() {
	var opt = $(this).find('option:selected');
	$('#log_btn').attr('time', opt.val());
	$('#log_btn').click();
});