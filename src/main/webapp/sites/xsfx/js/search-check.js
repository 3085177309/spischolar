/*$('#quick_search_btn').bind('click', function() {
	var key = $('#keyword_text').val();
	if ('' == $.trim(key)) {
		alert('请输入关键词!');
		return false;
	}
});*/

function latWinOpen(openURL, evt) {
	if ($.browser.chrome) {
		var arg = '\u003cscript\u003elocation.replace("' + openURL + '")\u003c/script\u003e';
		window.open('javascript:window.name;', arg);
	} else if ($.browser.msie) {
		window.open(openURL);
	} else if ($.browser.opera) {
		window.open(openURL, '_blank');
	} else if ($.browser.mozilla) {
		window.open(openURL, '_blank');
	} else if ($.browser.safari) {
		var open = window.open(openURL);
		if (open == null || typeof (open) == 'undefined')
			alert("Turn off your pop-up blocker!\n\nWe try to open the following url:\n" + openURL);
	}
	if (null != evt) {
		$.ajax({
			url : 'writeLog?type=1&field=link&value=' + encodeURIComponent($(evt).attr('docTitle')),
			dataType : 'JSON',
			type : 'GET',
			success : function() {
			}
		});
	}
};