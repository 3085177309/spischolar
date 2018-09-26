/**
 * 获取期刊主页地址
 * 
 * @param journalFlag
 *            期刊标识
 * @param url
 *            请求地址
 */
function loadJournalMainLink(siteFlag, title, postFix, journalFlag, url, txt, liContainer) {
	$.ajax({
		url : url + '?type=2&journalFlag=' + journalFlag,
		type : "GET",
		dataType : 'JSON',
		success : function(rs) {
			if (null != rs) {
				if (liContainer) {
					$('#' + journalFlag + postFix).prepend(
							"<li><a href='javascript:return false' onclick=\"javascript:latWinOpen('" + rs.titleUrl + "',this)\" docTitle='" + title + "' siteFlag='" + siteFlag + "'>" + txt + "</a></li>");
				} else {
					$('#' + journalFlag + postFix).prepend(
							"<a href='javascript:return false' onclick=\"javascript:latWinOpen('" + rs.titleUrl + "',this)\" docTitle='" + title + "' siteFlag='" + siteFlag + "'>" + txt + "</a>");
				}
			}
		}
	});
}

function loadJournalMainUrl(journalFlag, url) {
	$.ajax({
		url : url + '?type=2&journalFlag=' + journalFlag,
		type : "GET",
		dataType : 'JSON',
		success : function(rs) {
			if (null != rs) {
				$('#journal_name').attr('href', rs.titleUrl);
			}
		}
	});
}

/**
 * 获取期刊所属数据库主页地址
 * 
 * @param journalFlag
 *            期刊标识
 * @param url
 *            请求地址
 */
function loadDbLink(postFix, journalFlag, url) {
	$.ajax({
		url : url + '?type=1&journalFlag=' + journalFlag,
		type : "GET",
		dataType : 'JSON',
		success : function(rs) {
			if (null != rs && rs.length > 0) {
				for (var i = 0; i < rs.length; i++) {
					$('#' + journalFlag + postFix).append("<li><a onclick=\"javascript:latWinOpen('" + rs[i].titleUrl + "',this)\" href='javascript:return false'>数据库地址" + (i + 1) + "</a></li>");
				}
			}
		}
	});
}