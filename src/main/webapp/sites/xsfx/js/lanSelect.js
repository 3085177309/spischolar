/**
 * 语言点击
 */
function lanClick() {
	var lan = $(this).attr('value');
	$('#docLanHide').val(lan);
}

$('#lan_panel span').bind('click', lanClick);

var defaultLan = $('#docLanHide').val();
var spanJqObj = $("#lan_panel span");
$.each(spanJqObj, function(k, v) {
	if (defaultLan == $(v).attr('value')) {
		$(v).click();
		return false;
	}
});