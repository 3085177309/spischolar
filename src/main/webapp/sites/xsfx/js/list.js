$('#sort_select').change(function() {
	$('#hide_form').submit();
});
$('#view_select').change(function() {
	$('#hide_form').submit();
});

var defaultSort = $('#hide_sort').val();
var optionJqObj = $('#sort_select option');
$.each(optionJqObj, function(k, v) {
	if ($(v).val() == defaultSort) {
		$('#sort_select option').removeAttr('selected');
		$(v).attr('selected', true);
		return;
	}
});

$('#shou_lu_form ul li input').change(function() {
	$('#shou_lu_form').submit();
});

var optionObj = $('#view_select option:selected');
if (null != optionObj && optionObj.length == 1) {
	if ('list' == $(optionObj).attr('value')) {
		$('#qk_LB_view').hide();
		$('#qk_LB_table').show();
	} else {
		$('#qk_LB_view').show();
		$('#qk_LB_table').hide();
	}
}