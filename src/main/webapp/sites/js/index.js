$(function() {


	
	//检索框切换
	$('.s-btn').hover(function() {
		var index = $(this).index();
		//按钮切换
		$(this).addClass('active').siblings('.s-btn').removeClass('active');
		//输入框切换
		$('.search-tab').eq(index).show().siblings('.search-tab').hide();
	})

	/*服务骑繁忙状态下 文章高级检索*/
	$(".article-search .gjs-box-c").click(function(){
		$(".senior-search").toggle();
	});

	$("#senior-search-btn").click(function(){
		$(".search-history").hide();
	});

	$("body").bind("click",function(evt){ 
		var evt = evt || window.event; //浏览器兼容性
		if($(evt.target).parents(".search-box").length==0){ //不需要触发的父级元素 
			$(".senior-search").hide();//隐藏的元素
		}
	});



	/*检索历史页面 判断没有检索历史列表 则不显示时间*/
	/*！！转给后台处理了 */

	/*function isHistoryLi(){
		var history_list = $(".history-box");

		if(history_list.find("li").length==0){
			$(".history-box h3").hide();
			$(".user-man-hd").hide();
		}
	}

	isHistoryLi();

	$(".user-man-wraper .delete").click(function(){
		isHistoryLi();
	});*/

	
		//获取url参数
	$.getUrlParam = function(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
			var r = decodeURIComponent(window.location.search).substr(1).match(reg);
			if (r != null) return unescape(r[2]);
			return null;
		}
	//同步检索后的检索词
	var searchValue = $.getUrlParam('value')||$.getUrlParam('val');
		//scholarVal = ;
	if (searchValue) {
		/*//将空格检索‘+’还原为空格
		var splitValue=searchValue.split('+');
		if($.isArray(splitValue)){
			for(var i=0;i++;i<splitValue.length){
				if(splitValue[i]=="") return false;
			}
			$('.textInput').val(splitValue.join(' '))
		}else{
			$('.textInput').val(splitValue)
		}*/

	}
	//同步两个输入框内容,检索历史记录查询显示
//	var ajaxhisbox = $('.search-history'),textInputDom=$('.textInput'),len=textInputDom.length;
//	$('.textInput').on('keyup change',function() {
//		var val = $(this).val(),
//			index =$(this).index('.textInput');
//		var type = $(this).attr("type_index");
//		
//		if(val!=" "){
//			$(this).parent('div').find('.c-i').show();
//		}
//		//排除悬浮检索框输入时候请求ajax
//		if(!$(this).parents('.top-search').length && val.length>=2){
//			//ajax检索历史
//			$.ajax({
//				url: SITE_URL + 'user/historyForSearch?keyword=' + val + "&type=" + type,
//				type: 'post',
//				dataType: 'json',
//				success: function(data) {
//					
//					ajaxhisbox.html(' ');
//					var message = data.message,
//						str = '',
//						searchdata;
//
//					var searchdata = $.parseJSON(message);
//					if (searchdata.length) {
//						for (var i = 0; i < searchdata.length; i++) {
//							str += '<p class="search-his-item "><a  class="his-item-text textOver" href="javascript:void(0)">' + searchdata[i].keyword + '</a></p>';
//						}
//						ajaxhisbox.show().html(str);
//						//绑定点击事件
//						$('.search-his-item').on('click', function() {
//							var text = $(this).find('a').text();
//							$('.textInput').val(text);
//							ajaxhisbox.hide();
//						}).hover(function() {
//							$(this).parents('.search-history').find('a').removeClass('in');
//							$(this).find('a').addClass('in');
//						})
//					}
//
//				}
//			})
//
//			//检索框内容同步
//			$('.textInput').not($('.textInput').eq(index)).val(val);
//			
//		}else{
//			//同步输入框内容
//			$('.textInput').not($('.textInput').eq(index)).val(val);
//		}	
//		
//	})



	//登陆后tab切换
	$('.menus-index a').bind('hover', function() {
		var index = $(this).index();
		$(this).addClass('in').siblings().removeClass('in');
		$('.i-content-tab').eq(index).show().siblings().hide();
	});
	//tab内切换
	$('.i-con-intab a').bind('hover', function() {
			var index = $(this).index();
			$(this).addClass('in').siblings().removeClass('in');
			$(this).parents('.i-content-tab').find('.i-con-box').eq(index).show().siblings().hide();
	})

	// 搜索框 value 值同步
	;(function(){
		var isInputZh = false;
		var textInputSerh = $("input.textInput");
		textInputSerh.val(textInputSerh.val());
		
		textInputSerh.on({
			compositionstart:function(){
				isInputZh = true;
			},
			compositionend:function(){
				isInputZh = false;
				textInputSerh.val($(this).val());
			},
			input:function(){
				var $this = $(this);
				setTimeout(function(){
					if (isInputZh) return;
					textInputSerh.val($this.val());
				},20)
			}
		})
	}())


	//期刊按钮检索绑定、空值判断
	$('.journal_search_btn').bind('click', function() {
			//console.log(1);
			var target = $('.qk-search .textInput');
			if (!target.val()) {

				alert('请输入关键词');
				//target.focus();
				return false;
			} else {
				$('.journal_hide_btn').eq(0).click();
			}
		})
	//文章按钮、
	$('.article_search_btn').bind('click', function() {
		var target = $('.article-search .textInput');
		if (!$.trim(target.val())) {
			alert('请输入关键词');
			//target.focus();
			return false;
		} else {
			$('.article_hide_btn').eq(0).click();
		}
	})

	//开放资源筛选
	$('.oafirst').click(function(){
		if($(this).hasClass('in')){
			$(this).removeClass('in');
			$('#sort_form input[name="oaFirst"]').val(0);
		}else{
			$(this).addClass('in');
			$('#sort_form input[name="oaFirst"]').val(1);
		}
		$('#sort_form').submit();
	})
	//开放资源
	$("#lan_panel span").eq(0).click(function() {
		if ($(this).attr("id") == "radio_js_in") {
			$('#kfzydes').html('取消即可获取更多检索结果');
		} else {
			$('#kfzydes').html("勾选即可获取全部开放资源结果");
		}
	})
	var searchJs = {
		init:function(){
			this.bodyEvent();
			this.clearValue();
		},
		el: {

		},
		bodyEvent: function(callback) {
			//绑定到body上
			$('body').on("click", function(e) {
				//如果点击元素不是search-box的子元素，检索历史隐藏
				while (e.target.className != 'search-box') {
					if (e.target.parentNode) {
						e.target = e.target.parentNode
					} else {
						break;
					}
				}
				if (e.target.className == 'search-box') {
					//return false;
				} else {
					$('.search-history').hide()
				}
			}).keydown(function(event) { //键盘事件 
				var t = -1;
				if ($.trim($('.search-history').text()))
					//console.log($.trim($('.search-history').text()));
					switch (event.keyCode) {
						case 38: //键盘up--检索历史记录
							$('.search-history a').each(function(i, item) {
								if ($(item).hasClass('in')) {
									t = i;
									return false;
								}
							})
							t--;
							if (t < 0) {
								t = $('.search-history a').length - 1;
							}
							if (t >= 0) {
								$('.search-history a').removeClass('in').eq(t).addClass('in');
							}
							//同步检索值
							$('.textInput').val($('.search-history a').eq(t).text())
							break;
						case 40: //键盘down
							$('.search-history a').each(function(i, item) {
								if ($(item).hasClass('in')) {
									t = i;
									return false;
								}
							})
							t++;
							if (t > $('.search-history a').length) {
								t = 0;
							}
							if (t >= 0) {
								$('.search-history a').removeClass('in').eq(t).addClass('in');
							}
							//同步检索值
							$('.textInput').val($('.search-history a').eq(t).text())
							break;
						case 27: //键盘esc 检索历史记录退出
							$('.search-history').hide(); //清除检索下拉框
							break;
				}
			})
		},
		clearValue: function() {
			if($.browser.msie&& ($.browser.version==9||$.browser.version==8||$.browser.version==7)){
				$('.c-i').hide();
			}
			//点击清除输入框
			$('.c-i').click(function() {
				$('.textInput').val('');
				$(this).hide();
			});
		}

	}
	searchJs.init();
	
	/* login placeholer polyfill */
	/*var doc = window.document, input = doc.createElement('input');
    if( typeof input['placeholder'] == 'undefined' ) // 如果不支持placeholder属性
    {
        $('input').each(function( ele ){
            var me = $(this);
            var ph = me.attr('placeholder');
            me.parent('li').find('span.placeholder-poill').show();
            me.parent('li').find('span.placeholder-poill').click(function(){
          	  me.focus();
            })
            me.on('focus', function(){
              me.parent('li').find('span.placeholder-poill').hide();
     
            }).on('blur', function(){
                if( !me.val() )
                {
                    me.parent('li').find('span.placeholder-poill').show();
                }
            });
        });
    }*/
    //中英文字符长度
    String.prototype.gblen = function() {  
		var len = 0;  
		for (var i=0; i<this.length; i++) {  
			if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {  
				len += 2;  
			} else {  
				len ++;  
			}  
		}  
		return len;  
	} 
	// if($.trim($('#usernameText').text()).gblen()>10){
    //
	// 	var userStart=$('#usernameText').text().slice(0, 3);
	// 	var userEnd=$('#usernameText').text().slice($('#usernameText').text().gblen()-2, $('#usernameText').text().gblen())
	// 	$('#usernameText').text(userStart+'...'+userEnd)
	// }

	$(document).on('click',".letter-list a",function(){	
		console.log(1);
		$(this).addClass('in').siblings('a').removeClass('in');
		var target = $(this).attr('href');

		if(target){
			var ids = target;
			var targetEle=$(ids);
			if(targetEle.length==1){ 
				var top = targetEle.offset().top-70;
				if(top > 0){ 
					$('html,body').animate({scrollTop:top}, 1000); 
				} 
			} 
		}
	});


	$(".index-wraper .btn-blue").click(function(){
		$(".index-wraper .chosen-single span").text("Select an Option");
	});


	
	/*限制输入框字数*/
	var text_input = $(".user-man-info li .textarea");
	var zongzishu =200;//限制的总字数
	text_input.after("<p class='zishu'>还可以输入<span class='zs' style='color:red'>"+zongzishu+"</span>个字符></p><p class='zishu2' style='display:none'>已超过<span class='zs' style='color:red'></span>字符，<span style='color:red'>请重新编辑！</span></p>");
	

	text_input.keyup(function(){
		
		var text_input_len =zongzishu-text_input.val().length;

		if(text_input_len>=0){
			$(".zishu .zs").text(text_input_len);
			$(".zishu2").hide().siblings(".zishu").show();

			$(".user-man-info .btn-ensave").removeClass("hui").removeAttr("disabled");
		}else{
			$(".zishu").hide().siblings(".zishu2").show();
			$(".zishu2 .zs").text(zongzishu-text_input_len);

			$(".user-man-info .btn-ensave").addClass("hui").attr("disabled","disabled");
		}
	});





	/*
	* 登录注册弹窗 NEW
	*（出现各种兼容问题 重写弹窗事件 2017-05-08）
	*/

	/*登录框显示函数*/
	function loginBoxShow(){
		$(".showWin-new").show(0);
		$(".loginTabbox").show(0);
		$(".regTabbox").hide(0);
		$(".showWin-new .Win-cont").css("height","380px");
		$(".showWin #Win-T .loginTab .line").css("left","20px");
	}

	/*注册框显示函数*/
	function regBoxShow(){
		
		$(".showWin-new").show(0);
		$(".loginTabbox").hide(0);
		$(".regTabbox").show(0);
		$(".showWin-new .Win-cont").css("height","480px");
		$(".showWin #Win-T .loginTab .line").css("left","90px");
	}

	/*回到默认显示框状态*/
	function regloginBox(){
		$(".loginTabbox").show(0);
		$(".regTabbox").hide(0);
		$(".showWin-new .Win-cont").css("height","380px");
		$(".showWin #Win-T .loginTab .line").css("left","20px");
	}


	$("#login-btn").click(function(){
		loginBoxShow();
	});
	
	$("#modal-reg").click(function(){
		regBoxShow();
	});
	
	$(".register-btn").click(function(){
		regBoxShow();
	});


	$(".showWin-new .log").click(function(){
		loginBoxShow();
	});
	$(".showWin-new .re").click(function(){
		regBoxShow();
	});


	/*关闭弹窗*/
	$(".showWin-new .Win-close").click(function(){
		$(".showWin-new").hide();
		regloginBox();
	});

	/*点击空白处隐藏*/
	$(".Win-bj").bind("click",function(evt){ 
		var evt = evt || window.event; //浏览器兼容性
		if($(evt.target).parents(".showWin-new .Win-cont").length==0){ 
			$(".showWin-new").hide();
		}
	}); 




	/*文献传递弹窗 登录 click*/
	$("#login-btn-dilivery").live('click',function(){
		/*隐藏文献传递弹窗*/
		$(".deliveryAlert-moadl").hide();
		/*弹出登录框*/
		loginBoxShow();

    });

	function changeYear(){
		var endVal = $('.sc_selbox_n_end input[type="hidden"]').val();
			starVal = $('.sc_selbox_n_star input[type="hidden"]').val();
			
		if(endVal<starVal){
    		$('.sc_selbox_n_end input[type="hidden"]').val(starVal);
    		$('.sc_selbox_n_star input[type="hidden"]').val(endVal);

			scSelboxN('.sc_selbox_n_end');
			scSelboxN('.sc_selbox_n_star');
		}
	}

    /*主题分析--主题频次 年份段选择*/
    (function(){
    	var $star = $('.sc_selbox_n_star'),
    	    $end = $('.sc_selbox_n_end');

    	$('.sc_selbox_n_end .sc_selopt a').live('click',changeYear);
    	
    	$('.sc_selbox_n_star .sc_selopt a').live('click',changeYear);
    	
    })();

});

/*IE8提示升级*/
var isIE8Upgrade= function(sta){
	
	var ie = function(){
		var agent = navigator.userAgent.toLowerCase();
		return (!!window.ActiveXObject || "ActiveXObject" in window) ? (
	      (agent.match(/msie\s(\d+)/) || [])[1] || '11' //由于ie11并没有msie的标识
	    ) : false;
	}()

	if(ie>'8' || ie==false || sta==false)	return false;

	$(function(){
		$('body').append(
			'<div class="ie8-upgrade-wrap">'+
				'<div class="ie8-upgrade-box">'+
					'<span class="ie8-upgrade-close"></span>'+
					'<a target="_blank" href="https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads" class="ie8-upgrade-button"></a>'+
				'</div>'+
				'<div class="ie8-upgrade-shade"></div>'+
			'</div>'
		);

		//关闭弹窗
		$('.ie8-upgrade-close').click(function(){
			$('.ie8-upgrade-wrap').hide();
		});
		$('.ie8-upgrade-shade').click(function(){
			$('.ie8-upgrade-wrap').hide();
		});
	});
};


/*主题分析模拟下拉列表 模拟*/
var scSelboxN = function(elem){
	var $that = $('.sc_selbox_n');

	if(elem)  $that = $(elem);

	$that.each(function(){
		var $this = $(this),
			$opt = $(this).find('.sc_selopt'),
			dVal = $(this).find('input[type="hidden"]').val();

		//默认值
		$(this).find('#section_qk').text(dVal);
		$(this).find('.sc_selopt a').each(function(){
			if($(this).text()==dVal){
				$(this).attr('selected','selected').siblings('a').removeAttr('selected');
			}
		});

		//点击展开
		$(this).find('#section_qk').live('click',function(){
			$(this).next('.sc_selopt').show();
		});
		$(this).mouseleave(function(){
			$(this).find('.sc_selopt').hide();
		});

		$(this).find('.sc_selopt a').live('click',function(){
			var val = $(this).text();
			$(this).attr('selected','selected').siblings('a').removeAttr('selected');
			$(this).parents('.sc_selbox_n').find('#section_qk').text(val);
			$(this).parents('.sc_selbox_n').find('input[type="hidden"]').val(val);
			$(this).parents('.sc_selopt').hide();
		});
	});
};


/* 
 * 解决 Placeholder 兼容问题 
 */
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a("object"==typeof module&&module.exports?require("jquery"):jQuery)}(function(a){function b(b){var c={},d=/^jQuery\d+$/;return a.each(b.attributes,function(a,b){b.specified&&!d.test(b.name)&&(c[b.name]=b.value)}),c}function c(b,c){var d=this,f=a(this);if(d.value===f.attr(h?"placeholder-x":"placeholder")&&f.hasClass(n.customClass))if(d.value="",f.removeClass(n.customClass),f.data("placeholder-password")){if(f=f.hide().nextAll('input[type="password"]:first').show().attr("id",f.removeAttr("id").data("placeholder-id")),b===!0)return f[0].value=c,c;f.focus()}else d==e()&&d.select()}function d(d){var e,f=this,g=a(this),i=f.id;if(!d||"blur"!==d.type||!g.hasClass(n.customClass))if(""===f.value){if("password"===f.type){if(!g.data("placeholder-textinput")){try{e=g.clone().prop({type:"text"})}catch(j){e=a("<input>").attr(a.extend(b(this),{type:"text"}))}e.removeAttr("name").data({"placeholder-enabled":!0,"placeholder-password":g,"placeholder-id":i}).bind("focus.placeholder",c),g.data({"placeholder-textinput":e,"placeholder-id":i}).before(e)}f.value="",g=g.removeAttr("id").hide().prevAll('input[type="text"]:first').attr("id",g.data("placeholder-id")).show()}else{var k=g.data("placeholder-password");k&&(k[0].value="",g.attr("id",g.data("placeholder-id")).show().nextAll('input[type="password"]:last').hide().removeAttr("id"))}g.addClass(n.customClass),g[0].value=g.attr(h?"placeholder-x":"placeholder")}else g.removeClass(n.customClass)}function e(){try{return document.activeElement}catch(a){}}var f,g,h=!1,i="[object OperaMini]"===Object.prototype.toString.call(window.operamini),j="placeholder"in document.createElement("input")&&!i&&!h,k="placeholder"in document.createElement("textarea")&&!i&&!h,l=a.valHooks,m=a.propHooks,n={};j&&k?(g=a.fn.placeholder=function(){return this},g.input=!0,g.textarea=!0):(g=a.fn.placeholder=function(b){var e={customClass:"placeholder"};return n=a.extend({},e,b),this.filter((j?"textarea":":input")+"["+(h?"placeholder-x":"placeholder")+"]").not("."+n.customClass).not(":radio, :checkbox, [type=hidden]").bind({"focus.placeholder":c,"blur.placeholder":d}).data("placeholder-enabled",!0).trigger("blur.placeholder")},g.input=j,g.textarea=k,f={get:function(b){var c=a(b),d=c.data("placeholder-password");return d?d[0].value:c.data("placeholder-enabled")&&c.hasClass(n.customClass)?"":b.value},set:function(b,f){var g,h,i=a(b);return""!==f&&(g=i.data("placeholder-textinput"),h=i.data("placeholder-password"),g?(c.call(g[0],!0,f)||(b.value=f),g[0].value=f):h&&(c.call(b,!0,f)||(h[0].value=f),b.value=f)),i.data("placeholder-enabled")?(""===f?(b.value=f,b!=e()&&d.call(b)):(i.hasClass(n.customClass)&&c.call(b),b.value=f),i):(b.value=f,i)}},j||(l.input=f,m.value=f),k||(l.textarea=f,m.value=f),a(function(){a(document).delegate("form","submit.placeholder",function(){var b=a("."+n.customClass,this).each(function(){c.call(this,!0,"")});setTimeout(function(){b.each(d)},10)})}),a(window).bind("beforeunload.placeholder",function(){var b=!0;try{"javascript:void(0)"===document.activeElement.toString()&&(b=!1)}catch(c){}b&&a("."+n.customClass).each(function(){this.value=""})}))});

$(function(){
	$('input, textarea').placeholder();
});






/******
*
*	翻译功能js
* 
******/
$(function(){
	var late=$(".translate-btn a.title"),
		list_tit=$(".artlist-bd-list li h2.ovh a"),
		list_len=list_tit.length,
		bool=true,//保存当前 ‘标题翻译’ 按钮的点击状态
		layer_in;
	late.click(function(){
		if(!bool){return false;}
		if($(this).hasClass("check")){
			$(this).removeClass("check").text("标题翻译");
			list_tit.siblings("p").remove();
			list_len=list_tit.length;
		}else{
			load_prompt();//调用加载效果
			bool=false;
			$(this).addClass("check").text("取消翻译");
			list_tit.each(function(i,v){
				var that = $(this);
                var ss=$(this).text();
                $.ajax({
					url:"/translate/title/",
					data:{title:ss.substring(ss.indexOf("、")+1)},
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
					success:function(e) {
						load_end();
                        that.parent().append("<p>" + e.data + "</p>");
                    }
                })
			})
		}
	})

	// 标题翻译 加载结束
	function load_end(){
		if(--list_len === 0){
			layer.close(layer_in);
			$('.load_prompt').remove();
			bool=true;
		}
	}

	// 标题翻译 加载弹窗
	function load_prompt(){
		$("body").append('<div class="load_prompt"><i></i><p>翻译中...</p></div>');
		layer_in = layer.open({
          type: 1,
          closeBtn: 0, //不显示关闭按钮
          title: false,
          area: ['334px', '86px'],
          shade:false,
          content: $('.load_prompt')
        });
        layer.style(layer_in,{
            boxShadow: '0 0 20px #e5e5e5'
        });
	}
})
