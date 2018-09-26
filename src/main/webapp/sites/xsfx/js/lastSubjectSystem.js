/**
 * 学科点击
 * 
 * @returns {Boolean}
 */
function disciplineItemClick(evt) {
	$('#discipline_system_list .boxSrroll a').removeClass('in');
	$(evt).addClass('in');
	var more_authority_journal_url = $(evt).attr('more_authority_journal_url');
	$('#authority_journal_doc_more').attr('href', more_authority_journal_url);
	var hot_url = $(evt).attr('hot_url');
	if (null != hot_url && '' != hot_url) {
		$('#picShow_1').load(hot_url, function() {
			picShow(document.getElementById('picShow_1'), 6, 114, true, true);
		});
	}
	var authority_url = $(evt).attr('authority_url');
	if (null != authority_url && '' != authority_url) {
		$('#picShow_2').load(authority_url, function() {
			picShow(document.getElementById('picShow_2'), 6, 114, true, true);
		});
	}
	return false;
}

$('#discipline_system_list .boxSrroll a:eq(0)').click();