$('#db_list a').bind('click', function() {
	// 获取权威数据库名字
	var selectDb = $(this).attr('value');
	var selectArr = $('#version_panel select');
	$.each(selectArr, function(k, v) {
		var db = $(v).attr('db');
		if (selectDb == db) {
			$('#version_panel select').addClass('hide');
			$(v).removeClass('hide');
			var url = $(v).find('option:selected').attr('url');
			if (null != url)
				$('#content').load(url);
			return false;
		}
	});
	$('#db_list a').removeClass('in');
	$(this).addClass('in');
	return false;
});

$('#version_panel select').change(function() {
	var url = $(this).find('option:selected').attr('url');
	if (null != url)
		$('#content').load(url);
});
var selectArr = $('#version_panel select');
$.each(selectArr, function(k, v) {
	if (!$(v).hasClass('hide')) {
		var url = $(v).find('option:selected').attr('url');
		if (null != url)
			$('#content').load(url);
	}
});
$('#db_list a:eq(0)').click();

// 构建学科url
function buildSubjUrl(evt) {
	var liDom = $(evt).parent('li');
	var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
	var year = $('#year').val();
	var discRepEncode = $(liDom).attr('discRepEncode');
	var discEncode = $(liDom).attr('discEncode');
	var siteFlag = $('#siteFlag').val();
	var sort = $(liDom).attr('sort');

	var key = authorityDatabaseEncode + "^" + year + "^" + discRepEncode + '&viewStyle=list&authorityDb=' + authorityDatabaseEncode + '&subject=' + discEncode;
	var url = "list/result?queryCdt=shouLuSubjects_3_1_" + key + sort+'&detailYear='+year;
	$(evt).attr('href', url);
}

// 构建分区url
function buildPartitionUrl(evt) {
	var liDom = $(evt).parent().parent().parent('li');
	var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
	var year = $('#year').val();
	var discRepEncode = $(liDom).attr('discRepEncode');
	var discEncode = $(liDom).attr('discEncode');
	var siteFlag = $('#siteFlag').val();
	var sort = $(liDom).attr('sort');
	var partition = $(evt).attr('partition');

	var partitionUrl = "&authorityDb=" + authorityDatabaseEncode + "&subject=" + discEncode + "&queryCdt=partition_3_1_" + authorityDatabaseEncode + "^" + year + "^" + discRepEncode;
	var url = "list/result?" + partitionUrl + "^" + partition + "&partition=" + partition + sort + "&viewStyle=list&detailYear=" + year;
	$(evt).attr('href', url);
}