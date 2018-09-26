//Javascript
/**
 * 去除两端空白
 */
function trim(val){
	return val.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * 获取Input的值
 * @param name
 * @returns
 */
function val(name){
	var val=$('input[name="'+name+'"]').val()
	if(!!val){
		return trim(val);
	}
	return false;
}

function cleanVal(name){
	$('input[name="'+name+'"]').val('');
}

/**
 * 追加值
 * @param name
 * @param addV
 */
function addVal(name,addV){
	var val=$('input[name="'+name+'"]').val()
	if(!!val){
		$('input[name="'+name+'"]').val(val+" "+addV);
	}else{
		$('input[name="'+name+'"]').val(addV);
	}
}

/**
 * 分割字符串，使用空白分割，使用引号包含的字符串不分割
 * @param str
 */
function splitToArr(str){
	var _str=str.replace(/”|“/g,'"');//替换中文引号
	var char,word='';
	var auArr=[];
	for(var i=0;i<_str.length;i++){
		char=_str.charAt(i);//获取位置i的字符
		if(char==' '||char=='\t'){//遇到空白
			if(word.charAt(0)=='"'){
				word+=char;
			}else{
				if(trim(word)!=''){
					auArr.push(word);
					word='';
				}
			}
		}else if(char=='"'){//遇到引号
			if(word==''||trim(word)==''){
				word=char;
			}else if(word.charAt(0)=='"'){
				word+=char;
				auArr.push(word);
				word='';
			}else {
				auArr.push(word);
				word=char;
			}
		}else{
			word+=char;
		}
	}
	if(word!=''||trim(word)!=''){
		auArr.push(word);
	}
	return auArr;
}
	
	/**
	 * 高级检索
	 */
	function advancedQuery(){
		var value="";
		//包含全部字词
		var q=val('as_q');
		if(!!q){
			value=q;
		}
		//包含完整字句
		var epq=val('as_epq');
		if(!!epq){
			value+=" \""+epq+"\"";
		}
		//包含至少一个字词
		var oq=val('as_oq');
		if(!!oq){
			var strs=splitToArr(oq);
			for(var i=0;i<strs.length;i++){
				if(i!=0){
					value+=" OR"
				}
				value+=" "+strs[i];
			}
		}
		//不包含字词
		var eq=val('as_eq');
		if(!!eq){
			var strs=splitToArr(eq);
			for(var i=0;i<strs.length;i++){
				value+=" -"+strs[i];
			}
		}
		//显示以下作者所出现的文章
		var authors=val('as_sauthors');
		if(!!authors){
			var auArr=splitToArr(authors);
			for(var i=0;i<auArr.length;i++){
				value+=" 作者:"+auArr[i];
			}
		}
		//设置检索位置
		var occt=$('select[name="as_occt"]').val();
		$('#search_field').val(occt);
		//检索刊物
		var journal=$('input[name="as_publication"]').val();
		$('#search_journal').val(journal);
		//设置开始年
		var ylo=val('as_ylo');
		if(!!ylo){
			$('#search_start_y').val(ylo);
		}
		//设置结束年
		var yhi=val('as_yhi');
		if(!!yhi){
			$('#search_end_y').val(yhi);
		}
		if(val!=''){
			//$('#kw_txt').val(value.replace(/\s{1,}/g,"+"));
			$('#kw_txt').val(value);
		}
	}
//检索,为按钮绑定事件
$('#search_submit_').bind('click',function(){
	advancedQuery();
	if($('#kw_txt').val()==''&&trim($('#search_journal').val())==''){
		alert('请输入检索关键词!');
	}else{
		$('#doc_search_form').get(0).submit();//表单提交
	}
});