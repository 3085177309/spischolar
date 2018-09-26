(function($){   
            var i=0
            var str="<div class='sc_line_box box_group'> <span class='sc_s'> " +
            		"<select name='field' class='select select-p'>"+
            		"<option value='keyword'>关键词</option><option value='author'>作者</option><option value='title'>标题</option><select><select name='logic' class='select select-p'><option value='0'>与</option><option value='1'>或</option><option value='2'>非</option></select></span>"+
            		"<input type='text' name='value' class='txt sc_put' /> " +
            		"<a class='addsenior-con t' title='删除'></a> </div>"
            //必应高级检索		
            var strBing="<div class='sc_line_box box_group'> <span class='sc_s'> " +
             		"<select name='field' class='select select-p'>"+
             		"<option value='keyword'>关键词</option>" +
             		"<option value='title'>标题</option><select><select name='logic' class='select select-p'><option value='0'>与</option><option value='1'>或</option><option value='2'>非</option></select></span>"+
             		"<input type='text' name='value' class='txt sc_put' /> " +
             		"<a class='addsenior-con t' title='删除'></a> </div>"
            $('.z').click(function(){
                //var clone=$(this).parents("div").clone();
                //$(this).attr("class","addsenior-con t");
                //$(this).parents("div").eq(0).after(str);
            	var source=$(this).attr("source");
                var spanid=$(this).parents("div").eq(0).next().find('.sc_selbox > span');
                $('.t').click(function(){    
                    $(this).parents("div").eq(0).remove();
                });
                
                
                var hiddenId=$(this).parents("div").eq(0).next().find("input[type='hidden']");
                    for (var v = 0; v < spanid.length; v++) {
                            spanid.eq(v).attr({
                                id: 'section_s'+v
                            })
                            hiddenId.eq(v).attr({
                                id:'value_h'+v
                            })
                        select_('section_s'+v,'value_h'+v);    
                    };
                
                i++;
                var obox_group = $(".sc_line_box.box_group").length;
                if (obox_group>=6) {
                	$(this).parents("div").eq(0).after();
                }else if(obox_group>=1&&obox_group<6){
                	if(source == 0) {
                		$(this).parents("div").eq(0).after(str);
                	} else {//如果是必应
                		$(this).parents("div").eq(0).after(strBing);
                	}
                	 $('.t').click(function(){    
                         $(this).parents("div").eq(0).remove();
                     });
                }
            })
            $('.t').click(function(){    
                $(this).parent(".sc_line_box.box_group").eq(0).remove();
            })
            function select_(id,hider,values){
               if(!document.getElementById(id)){return false;}
               var Red=document.getElementById(id),
                   inhide=document.getElementById(hider),
                   Redparent=Red.parentNode,
                   times=Red.nextElementSibling?Red.nextElementSibling:get_nextsibling(Red),
                  timea=times.getElementsByTagName("a");
                  Red.onclick=function(){
                      times.style.display="block";
                      event.stopPropagation();
                      return false;
                  }
                  for (var i = 0; i < timea.length; i++) 
                      timea[i].onclick=function(){
                          Red.innerHTML="";
                          Red.innerHTML=this.innerHTML;
                          if(values){
                             inhide.value=this.getAttribute(values);
                          }else{
                              inhide.value=this.innerHTML;
                          }
                          times.style.display="none";
                      }
                  Redparent.onmouseleave=function(){
                        times.style.display="none";
                  }
    }

})(jQuery);