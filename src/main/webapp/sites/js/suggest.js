$(function(){
        var resdateStr=new Date();
        var sug={
            c:"active",
            emailflag:true,
            sughistory:'',
            eventInit:function(){
                var  that=this;
                that.sugcontentHeight();
                that.appShow();
                that.sugOpen();
                that.sugtoogle();
                that.wblink();
                that.textarea();
                $('.sug-swin').click(function(){
                    that.sugClose();
                });
                that.sugtoogleClose();
                that.newSug();
                that.contextVal();
                $(window).resize(function(){
                    that.sugcontentHeight();
                })
            },
            getDateTimeStamp:function(dateStr) {
                //parse解析一个日期函数并返回1970/1/1午夜句日期时间的毫秒数。
                return Date.parse(dateStr.replace(/-/gi,"/"));
            },
            getDateDiff:function(interval,dateYear) {//interval 时间间隔  //dateYear时间戳
            	
                // 处理时间返回多分钟/小时、天之前
                var that=this;
                var publishTime =interval/1000,
                    d_seconds,
                    d_minutes,
                    d_hours,
                    d_days,
                    timeNow = parseInt(new Date().getTime()/1000),//getTime() 方法可返回距 1970 年 1 月 1 日之间的毫秒数。
                    d,

                    date = new Date(dateYear),
                    Y = date.getFullYear(),
                    M = date.getMonth() + 1,
                    D = date.getDate(),
                    H = date.getHours(),
                    m = date.getMinutes(),
                    s = date.getSeconds();
                	
                    //小于10的在前面补0
                    if (M < 10) {
                        M = '0' + M;
                    }
                    if (D < 10) {
                        D = '0' + D;
                    }
                    if (H < 10) {
                        H = '0' + H;
                    }
                    if (m < 10) {
                        m = '0' + m;
                    }
                    if (s < 10) {
                        s = '0' + s;
                    }

                d = interval;
                d_days = parseInt(d/86400);
                d_hours = parseInt(d/3600);
                d_minutes = parseInt(d/60);
                d_seconds = parseInt(d);

                if(d_days > 0 && d_days < 10){
                    return d_days + '天前';
                }else if(d_days <= 0 && d_hours > 0){
                    return d_hours + '小时前';
                }else if(d_hours <= 0 && d_minutes > 0){
                    return d_minutes + '分钟前';
                }else if (d_seconds < 60) {
                    if (d_seconds <= 0) {
                        return '刚刚发表';
                    }else {
                        return d_seconds + '秒前';
                    }
                }else if (d_days >= 10 && d_days < 30){
                    return M + '-' + D + ' ' + H + ':' + m;
                }else if (d_days >= 30) {
                    return Y + '-' + M + '-' + D + ' ' + H + ':' + m;
                }
            },
            appShow:function(){
                // app按钮的显示隐藏
                var that=this;
                $('.sug-app').click(function(){
                    that.wblinkhide();
                    if($(this).hasClass('active')){
                        $(this).removeClass('active').parents('.sug-app-box').addClass('apphide');
                        
                        
                        
                    }else{
                        
                        $(this).addClass('active').parents('.sug-app-box').addClass('active').removeClass('apphide').css('width','auto');
                        /*clearTimeout(st);*/
                    }
                    $('.sug-chart').bind('webkitAnimationEnd','AnimationEnd',function(){
                    	if($(this).parents('.sug-app-box').hasClass('apphide')){
                    		$('.sug-app-box').css('width',37); 
                    	} 
                    })
                })
                
            },
            sugOpen:function(){
                //建议反馈窗口的打开
                var that=this,c=that.c;
                that.hisSuggeste();
                
                $('.sug-chart').click(function(){
                    that.wblinkhide();//微信微博点击了的隐藏
                    // 当有反馈记录的时候进入反馈列表页，没有的时候进入新建反馈页
                    $.get(SITE_URL+"user/findFeedbacks", function(result){
                        result = eval("("+result.message+")");
                        that.sughistory=result?result.length:0;
                        
                        if($(this).hasClass(c)){
                            $(this).removeClass(c);
                            $('.suggestwrap').removeClass(c);
                            $('body').removeClass('modal-sug-open');
                        }else{
                            $(this).addClass(c);
                            $('.suggestwrap').addClass(c);
                            $('body').addClass('modal-sug-open');
                            
                            if(that.sughistory){
                                $('.sug-toggle-box').eq(0).hide(0).removeClass(c).siblings().addClass(c).show(300);
                                //返回列表拼接显示
                                suggestHistoryShow();                        
                            }
                        }
                    })

                    
                })
            },
            sugtoogle:function(){
                //反馈列表的切换
                var that=this,c=that.c;
                $('.sug-toggle').click(function(){
                    $(this).parents('.sug-toggle-box').hide(0).removeClass(c).siblings().addClass(c).show(300);
                    that.sugcontentHeight()  
                })
            },
            sugClose:function(){
                var  that=this,c=that.c;
                $('.sug-chart').removeClass(c);
                $('.suggestwrap').removeClass(c);
                $('body').removeClass('modal-sug-open');
            },
            sugtoogleClose:function(index){
                var  that=this,c=that.c;
                //关掉整个对话窗口
                $('.sug-close').click(function(){
                    that.sugClose()
                })
                /*$('.sug-close').eq(1).click(function(){//回到新建窗口
                    $(this).parents('.sug-toggle-box').hide().siblings().show(300);
                });
                $('.sug-close').eq(0).click(function(){
                    that.sugClose()
                })*/
            },
            wblink:function(){
                var that=this,c=that.c;
                $('.wb-link,.wx-box').click(function(){
                    if($(this).hasClass('wbshow')){
                        $('.wb-link,.wx-box').removeClass('wbshow');
                        $(this).next('.wb-wrap').removeClass(c);

                    }else{
                        $('.wb-link,.wx-box').removeClass('wbshow');
                        $('.wb-wrap').removeClass(c);
                        $(this).addClass('wbshow');
                        $(this).next('.wb-wrap').addClass(c);
                    }
                })        
            },
            wblinkhide:function(){
                var that=this,c=that.c;
                $('.wb-link,.wx-box').removeClass('wbshow');
                $('.wb-wrap').removeClass(c);

            },
            textarea:function(){
                var that=this,c=that.c;
                $('.sug-textarea-box textarea').bind('focus',function(){
                    $('.sug-textarea-box').addClass(c);
                    //高度改变的时候响应中间列表的高度
                    that.sugcontentHeight();
                }).blur(function(){
                    if(!$(this).val()&&!$('.upload-text').text()){
                        $('.sug-textarea-box').removeClass(c);
                        $('.sug-upload-files').css('margin-bottom','0')
                    }
                    that.sugcontentHeight();
                })
                that.fileuploadbind();
            },
            fileuploadbind:function(){
                var that=this,c=that.c;
                var s=null;
                //上传绑定
                    $('#uploadfile').live('click',function(e){
                        if(!$(this).val()){
                            $(this).change(function(){
                                s=$(this).val();
                                s=s.split('\\');
                                
                                $('.upload-file-box').show().find('.upload-text').text(s[s.length-1]);
                                $('.sug-upload-files').css('margin-bottom','30px')
                            })
                            $('.sug-textarea-box').addClass(c).find('textarea').addClass(c);
                        }else{
                            alert("每次只能上传一个附件！");
                            e.preventDefault();//阻止弹出窗口
                        }
                    });
                //}

                that.bindEnterUpload();
                that.delUploadbtn();
            },
            ajaxUploadfile:function(){
                var that=this,s=null;
                //that.bindEnterUpload();
                //DOM
                var text=$.trim($('.textreabox textarea').val());
                var file=$('#uploadfile').val();
                var str='',dateStr=that.getDateDiff(0);
                    $('input[name="contents"]').val(text);
                	s=file.split('\\');
	                if(file&&!that.isImageWord(that.fileType(file))){
	                	alert("只能上传,图片和word文件！");
	                	if($.browser.msie){
	                        $('.sug-upload-files').html('<input type="file" hidden="hidden" name="file" id="uploadfile" accept="image/gif,image/jpeg,image/jpg,image/png">'); 
	                    }else{
	                        $('#uploadfile').val('');
	                    }
	                	$('.upload-file-box').hide().find('.upload-text').text('');
	                	$('.sug-upload-files').css('margin-bottom','0')
	                	return false;
	                }
                    

                    if(text){
                    	
                    	$('#fb_form').ajaxSubmit({
                    		 dataType:  'text',
                             type: "POST",
                             data : $('#fb_form').serialize(),
                             cache:false,
                             beforeSend:function(){
                            	 //console.log($('#fb_form').serialize());
                             },
                             success: function(msg){
                            	 var msg=eval("("+msg+")");
                            	 var time=[];
                            	 for(var i=0; i<msg.length;i++){
                            		 time.push([msg[i].interval,msg[i].time]);
                            	 }

                            	 var id,file=null;
                            	 var msgLast =msg[msg.length-1];
                            	 
                            	 id = msgLast.feedbackId;
                            	 file = msgLast.options;
                            	 str+='<div class="sug-user-item">'
                                     +'<div class="sug-user-text clearfix">'
                                     +'<i class="sug-arrow"></i>';
		                             if(text){
		                                 str+='<div class="sug-u-body">'
		                                         +'<p>'+text+'</p>'
		                                     +'</div>';     
		                             }
		                             if(text&&file){
		                                 str+='<div class="sug-seg-line"></div>'
		                             }
		                             if(file){
		                                 
		                                 var files=file.split('\/');
		                                 str+='<div class="sug-u-bottom">'
		                                         +'<span class="upload-icon"></span>'
		                                         +'<span><a target="_blank" href="/user/showFile?filename=/'+files[1]+'/'+files[2]+'/'+s[s.length-1]+'">'+s[s.length-1]+'</a></span>'
		                                     +'</div>';
		                             }
		                                 
		                             str+='</div>'
		                                     +'<div class="clear"></div>'
		                                     +'<div class="s-input-time">'+dateStr+'</div>'
		                                 +'</div>';
		                        //返回的的中文乱码，只更新每条的时间
		                        for(var j=0;j<time.length;j++){
		                        	$('.s-input-time').eq(j).text(that.getDateDiff(time[j][0],time[j][1]));
		                        }   
		                             
                            	$('#feedback_id').val(id);
                            	$('#feedId').val(id);
                                $('#sug-content').append(str);
                                //锁定返回类型
                                $('.sug-bot-head,.sug-bot-head #section_fknr,.sug-bot-head i').addClass('disabled').attr('disabled',true);
                                $('.textreabox textarea').blur();
                                
                                //清空ie input file value
                                if($.browser.msie){
                                    $('.sug-upload-files').html('<input type="file" hidden="hidden" name="file" id="uploadfile" accept="image/gif,image/jpeg,image/jpg,image/png">'); 
                                }else{
                                    $('#uploadfile').val('');
                                }
                             }
                          });
                        
                        if(that.emailflag){
                            setTimeout(function(){
                                that.emaildomShow();
                            },600);
                        }
                        
                        that.clearTextarea();
                        //$('.sug-textarea-box textarea').focus();
                    
                    }else{
                    	alert("请输入反馈内容！");
                    	return false;
                    }
            },
            emaildomShow:function(){
                var that=this,c=that.c;
                //if(that.emailflag){
                    $('.email-colect').addClass('email-colectShow');
                //}
                
            },
            clearTextarea:function(){
                $('.sug-textarea-box textarea').val('');
                if($.browser.msie){
                    $('.sug-upload-files').html('<input type="file" hidden="hidden" name="file" id="uploadfile" accept="image/gif,image/jpeg,image/jpg,image/png">'); 
                }else{
                    $('#uploadfile').val('');
                }
                $('.upload-file-box').hide().find('.upload-text').text('');

            },
            contextVal:function(){
            	$('.textreabox textarea').bind('input propertychange',function(){
            		$('input[name="content"]').val($(this).val());
            	})
            },
            delUploadbtn:function(){
                var that=this,c=that.c;
                $('.upload-del').click(function(e){
                    e.preventDefault();
                    e.stopPropagation();
                    $(this).parents('.upload-file-box').hide();
                    $('.upload-text').text('');
                    if($.browser.msie){
                        $('.sug-upload-files').html('<input type="file" hidden="hidden" name="file" id="uploadfile" accept="image/gif,image/jpeg,image/jpg,image/png">'); 
                    }else{
                        $('#uploadfile').val('');
                    }
                    $('.sug-upload-files').css('margin-bottom','0')
                    if(!$('.sug-textarea-box textarea').val()){
                        $('.sug-textarea-box').removeClass(c)
                    }
                    
                })
            },
            bindEnterUpload:function(){
                var that=this;
                $('.suggestwrap').keypress(function(e) {  
                   // 回车键事件  
                   if(e.which == 13) {
                    e.preventDefault();
                    e.stopPropagation();
                    $('.textreabox textarea').blur();
                    that.ajaxUploadfile();
                   }
                })
                //上传按钮绑定
                $('.sug-submit').click(function(){
                    $('.textreabox textarea').blur();
                    that.ajaxUploadfile();
                });
            },
            hisSuggeste:function(){
                var that=this;
                

            },
            newSug:function(){
                var that=this,c=that.c;
                $('.new-sug-btn a').click(function(e){
                    e.stopPropagation();
                    e.preventDefault();
                    //新建信息初始化
                    $('.sug-bot-head,.sug-bot-head #section_fknr,.sug-bot-head i').removeClass('disabled').attr('disabled',false);
                    $('#sug-content').html('');
                    $('#feedback_id').val('');
                    $('#feedId').val('');
                    $('.email-colectShow').removeClass('email-colectShow');

                    $(this).parents('.sug-toggle-box').hide().removeClass(c).siblings().addClass(c).show();
                })
            },
            sugcontentHeight:function(){
                var windowH=$(window).height();
                $('#sug-content-wrap').height(windowH-418);
                $('.sug-his-list').height(windowH-120)
            },
            isImageWord:function(str){
            	//function isImage(str){
            		var str=str.toLocaleLowerCase();
            		if(str=="bmp"||str=="png"||str=="jpg"||str=="jpeg"||str=="gif"||str=="doc"||str=="docx"){
            			return true;
            		}else{
            			return false
            		}
            	//}
            },
            fileType:function(fileOptions){
            	var fileOptions=fileOptions.split('\\');
            	var fileType=fileOptions[fileOptions.length-1].split('.');
            	fileType=fileType[fileType.length-1];
            	return fileType;
            },
            init:function(){
                var that=this;
                that.eventInit();
            }
        }
        window.sug=sug;
        sug.init();
});

$(function(){
	var index_wraper_lii =$(".index-wraper .ll_nr");
	if(index_wraper_lii.height()<150){
		$(this).addClass(".lii_lii");
	}
});