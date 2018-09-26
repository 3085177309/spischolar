var createCatalog=function(ele){
	var editor='<div class="">'+ele+'</div>'
	var jquery_h1_list=$(editor).find("h1");
	if(jquery_h1_list.length==0){ return;}
	var content="";
	    content='<div id="navCategory">';
	//一级目录
	content+='<ul class="first_class_ul">';
	for(var i=0;i<jquery_h1_list.length;i++){
		var li_content='<li>'+$(jquery_h1_list[i]).text()+'</li>';
		var nextH1Index=i + 1;
		if(nextH1Index==jquery_h1_list.length){
			//alert(2)
			nextH1Index= 0;
		}
		var jquery_h2_list=$(jquery_h1_list[i]).nextUntil(jquery_h1_list[nextH1Index],"h2")
		//二级目录
		if(jquery_h2_list.length>0){
			li_content+='<ul class="second_class_ul">';
		}
		for (var j = 0; j < jquery_h2_list.length; j++) {
			//二级目录第一条
			li_content+='<li>'+$(jquery_h2_list[j]).text()+'</li>';
			var nextH2Index=j+1;
			var next;
			if(nextH2Index==jquery_h2_list.length){
				if(i+1==jquery_h1_list.length){
					next=jquery_h1_list[0];
				}else{
					next=jquery_h1_list[i+1];
				}
			}else{
				next=jquery_h2_list[nextH2Index];
			}
			var jquery_h3_list=$(jquery_h2_list[j]).nextUntil(next,"h3");
			//三级目录
			if(jquery_h3_list.length>0){
				li_content+='<ul class="thrid_class_ul">';
			}
			for(var k=0;k<jquery_h3_list.length;k++){
				li_content+='<li>'+$(jquery_h3_list[k]).text()+'</li>';
			}
			if(jquery_h3_list.length>0){
				li_content+='</ul>';
			}
			li_content+='</li>';
		}
		if(jquery_h2_list.length>0){
			li_content+='</ul>';
		}
		li_content+='</li>';
		content+=li_content;
	}	
	content+='</ul>';
	content+='</div>';
	$("#abstract").html("");
	$("#abstract").prepend(content);
}