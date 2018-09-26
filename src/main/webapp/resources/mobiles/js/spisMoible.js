;!function(win){        
  "use strict";

  var doc = document, query = 'querySelectorAll', claname = 'getElementsByClassName', S = function(s){
      return doc[query](s);
  };

  //默认配置
  var config = {
       type: 0,
       shade: true,
       shadeClose: true,
       fixed: true,
       anim: true
  };

  var ready = {
      extend: function(obj){
          var newobj = JSON.parse(JSON.stringify(config));
          for(var i in obj){
              newobj[i] = obj[i];
          }
          return newobj;
      }, 
      timer: {}, end: {}
  };
  
  //点触事件
  ready.touch = function(elem, fn){
      var move;
      if(!/Android|iPhone|SymbianOS|Windows Phone|iPad|iPod/.test(navigator.userAgent)){
          return elem.addEventListener('click', function(e){
              fn.call(this, e);
          }, false);
      }
      elem.addEventListener('touchmove', function(){
          move = true;
      }, false);
      elem.addEventListener('touchend', function(e){
          e.preventDefault();
          move || fn.call(this, e);
          move = false;
      }, false); 
  };

  var index = 0, classs = ['layermbox'], Layer = function(options){
      var that = this;
      that.config = ready.extend(options);
      that.view();
  };

  Layer.prototype.view = function(){
      var that = this, config = that.config, layerbox = doc.createElement('div');

      that.id = layerbox.id = classs[0] + index;
      layerbox.setAttribute('class', classs[0] + ' ' + classs[0]+(config.type || 0));
      layerbox.setAttribute('index', index);

      var title = (function(){
          var titype = typeof config.title === 'object';
          return config.title
          ? '<h3 style="'+ (titype ? config.title[1] : '') +'">'+ (titype ? config.title[0] : config.title)  +'</h3><button class="layermend"></button>'
          : '';
      }());
      
      var button = (function(){
          var btns = (config.btn || []).length, btndom;
          if(btns === 0 || !config.btn){
              return '';
          }
          btndom = '<span type="1">'+ config.btn[0] +'</span>'
          if(btns === 2){
              btndom = '<span type="0">'+ config.btn[1] +'</span>' + btndom;
          }
          return '<div class="layermbtn">'+ btndom + '</div>';
      }());
      
      if(!config.fixed){
          config.top = config.hasOwnProperty('top') ?  config.top : 100;
          config.style = config.style || '';
          config.style += ' top:'+ ( doc.body.scrollTop + config.top) + 'px';
      }
      
      if(config.type === 2){
          config.content = '<i></i><i class="laymloadtwo"></i><i></i>';
      }
      
      layerbox.innerHTML = (config.shade ? '<div '+ (typeof config.shade === 'string' ? 'style="'+ config.shade +'"' : '') +' class="laymshade"></div>' : '')
      +'<div class="layermmain" '+ (!config.fixed ? 'style="position:static;"' : '') +'>'
          +'<div class="section">'
              +'<div class="layermchild '+ (config.className ? config.className : '') +' '+ ((!config.type && !config.shade) ? 'layermborder ' : '') + (config.anim ? 'layermanim' : '') +'" ' + ( config.style ? 'style="'+config.style+'"' : '' ) +'>'
                  + title
                  +'<div class="layermcont">'+ config.content +'</div>'
                  + button
              +'</div>'
          +'</div>'
      +'</div>';
      
      if(!config.type || config.type === 2){
          var dialogs = doc[claname](classs[0] + config.type), dialen = dialogs.length;
          if(dialen >= 1){
              layer.close(dialogs[0].getAttribute('index'));///??????
          }
      }
      
      document.body.appendChild(layerbox);
      var elem = that.elem = S('#'+that.id)[0];
      config.success && config.success(elem);
      
      that.index = index++;
      that.action(config, elem);
  };

  Layer.prototype.action = function(config, elem){
      var that = this;
      
      //自动关闭
      if(config.time){
          ready.timer[that.index] = setTimeout(function(){
              layer.close(that.index);
          }, config.time*1000);
      }
      
      //关闭按钮
      if(config.title){
          var end = elem[claname]('layermend')[0], endfn = function(){
              config.cancel && config.cancel();
              layer.close(that.index);
          };
          ready.touch(end, endfn);
      }
      
      //确认取消
      var btn = function(){
          var type = this.getAttribute('type');
          if(type == 0){
              config.no && config.no();//执行config.no()，点取消按钮触发的回调函数
              layer.close(that.index);
          } else {
              config.yes ? config.yes(that.index) : layer.close(that.index);
          }
      };
      if(config.btn){
          var btns = elem[claname]('layermbtn')[0].children, btnlen = btns.length;
          for(var ii = 0; ii < btnlen; ii++){
              ready.touch(btns[ii], btn);
          }
      }
      
      //点遮罩关闭
      if(config.shade && config.shadeClose){
          var shade = elem[claname]('laymshade')[0];
          ready.touch(shade, function(){
              layer.close(that.index, config.end);
          });
      }

      config.end && (ready.end[that.index] = config.end);
  };

  win.layer = {
      v: '1.7',
      index: index,
      
      //核心方法
      open: function(options){
          var o = new Layer(options || {});
          return o.index;
      },
      
      close: function(index){
          var ibox = S('#'+classs[0]+index)[0];
          if(!ibox) return;
          ibox.innerHTML = '';
          doc.body.removeChild(ibox);
          clearTimeout(ready.timer[index]);
          delete ready.timer[index];
          typeof ready.end[index] === 'function' && ready.end[index]();
          delete ready.end[index]; 
      },
      
      //关闭所有layer层
      closeAll: function(){
          var boxs = doc[claname](classs[0]);
          for(var i = 0, len = boxs.length; i < len; i++){
              layer.close((boxs[0].getAttribute('index')|0));
          }
      }
  };

  'function' == typeof define ? define(function() {

      return layer;
  }) : function(){
      var js = document.scripts, script = js[js.length - 1], jsPath = script.src;
      var path = jsPath.substring(0, jsPath.lastIndexOf("/") + 1);
      
      //如果合并方式，则需要单独引入layer.css
      if(script.getAttribute('merge')) return; 
      
      document.head.appendChild(function(){
          var link = doc.createElement('link');
          link.href = path + 'need/layer.css';
          link.type = 'text/css';
          link.rel = 'styleSheet';
          link.id = 'layermcss';
          return link;
      }());
      
  }();
}(window);

var myScroll=null;
$(function(){
	$('body,html').height($(window).height()).css({'overflow':'hidden'});
	$('.mui-content').height($(window).height());
	$(window).resize(function(){
		$('.mui-content').height($(window).height());
		$('body,html').height($(window).height()).css({'overflow':'hidden'});
	})
	myScroll = new IScroll('.mui-content', {
	    mouseWheel: true,
	    scrollbars: false,
	    click:true
	});
	
	var toTopDom=document.createElement("div");
    $(toTopDom).addClass("toTop");
    $(toTopDom).html('<i class="icon iconfont">&#xe612;</i>');
    $('body').append($(toTopDom));
    $(toTopDom).bind('tap',function(){
    	myScroll.scrollTo(0, 0, 500,IScroll.utils.ease.circular)
    })
    myScroll.on('beforeScrollStart',function(){
      $('.input-text').blur();
      $('.user-info-input input').blur();
    })
    myScroll.on('scrollEnd',function(){
		if(myScroll.y<-280){
			$(toTopDom).show()
		}else{
			
			$(toTopDom).hide();
		}
	})
})


;(function(){

  /*$("body").height($(window).height());
  $(".ui-scroller").height($(window).height()-$(".fix-nav").height())*/

  /*if($('.ui-scroller').length){
    var scroll = new fz.Scroll('.ui-scroller', {
        scrollY: true,
        bounce:false
    });
  }*/
  
  //window.scroll=scroll;
  /*$("#search-tab-box .input-text,.common-search .input-text").focus(function(){
    $(".fix-nav").hide();
  }).blur(function(){
    $(".fix-nav").show();
  })*/



  $(".input-submit").bind("click",function(e){
    if($(this).siblings(".input-text").val()==""){
      e.stopPropagation();
      e.preventDefault();
    	alert('请输入检索词');
      /*layer.open({content:'请输入检索词',time: 2});*/
      return false;
    }
  })
 

	var searchTap=function(){
		var $searchTab=$("#search-tab-btn a");
		var $searchBox=$("#search-tab-box dd");
    var $searchSpan=$("#search-tab-btn span");
    var $searchP=$("#search-tab-btn p");
    $searchSpan.bind("tap",function(){
      if($(this).parents('#search-tab-btn').hasClass("active")){
        $(this).parents('#search-tab-btn').removeClass("active");
      }else{
        $(this).parents("#search-tab-btn").addClass("active");
        $searchTab.bind("tap",function(){
          $(this).parents("#search-tab-btn").removeClass("active")
          var index=$(this).index();
          $searchSpan.text($(this).text());
          $(this).addClass("active").siblings().removeClass("active");
          $searchBox.eq(index).show().siblings().hide();
        })
      }
    })
		
	}();


	var search_condi=function(){
		var $radio = $('#radio_js_in');
    var $radioPar=$radio.parents("label");
		$radioPar.bind("touchend",function(){
       alert(1);
			var	sval=$radio.val();
			if(sval==0){
				$radio.val(1);
			    $radio.addClass("in")
			}else if(sval==1){
				$radio.val(0);
				$radio.val(0).removeClass("in");
			}
		})
	}();

 var userselect=function(){
  var $userselect=$(".userSelect");
  var $lay_bj_div=$(".lay_bj_div");
  $userselect.bind("touchend",function(){
    $lay_bj_div.show();
    $(".userSelectbox").show();
    $(document).bind("touchmove",function(event){
      event.preventDefault();
    })
  })
  $lay_bj_div.bind("touchend",function(event){
      $(".userSelectbox").hide();
      $lay_bj_div.hide();
      $(document).unbind();
  })
 }() 

 /*下拉切换*/
  var dataSelect=function(){
    var $dataSelect=$(".data-sort-hd li");
    var $databd=$(".data-sort-bd");
    var $lay_bj_div=$(".lay_bj_div");
    var i;
    $dataSelect.bind("tap",function(){
      $('.mui-content').bind("touchmove",function(e){
            e.preventDefault();
            e.stopPropagation();
      })
      i=$(this).index();
      if($(this).hasClass("in")&&$databd.find("ul").eq(i).css("display")=='block'){
        $databd.hide();
        $(this).removeClass("in");
         $lay_bj_div.hide().css("top","")
        $(".mui-content").unbind();
      }else{
        $(this).parents(".data-sort-hd").find("li").removeClass("in");
        $(this).addClass("in");
        $databd.show();
        var boxOffset=$dataSelect.offset().top+$(".data-sort-hd").height();
        $lay_bj_div.show().css({"top":boxOffset,"height":$('body').height()-boxOffset});
        $databd.css({"top":boxOffset,"height":"auto"});
        $databd.find("ul").hide().eq(i).show()
      }
      
    })
    $lay_bj_div.bind("touchend",function(event){
      $databd.find("ul").eq(i).hide();
      $databd.css({"top":0}).hide();
      $lay_bj_div.hide().css("top","");
      $(".mui-content").unbind();
    })
    $(".bgborder span").bind("tap",function(){
      if($(this).hasClass("in")){
    	  $(this).find('input').removeAttr("checked");
        $(this).removeClass("in")
      }else{
    	  $(this).find('input').attr("checked",true);
        $(this).addClass("in");
      }
    })  
  }()


  //期刊筛选
  var qkSelect=function(){
      var $current=$(".curent-chosen");
      var $curentsubdata=$(".item-section");
      var $lay_bj_div=$(".lay_bj_div");
      var $qkchosenp=$(".qkchosen p");
      var $qkyearsel=$(".qkyearsel a");
      var $lay_bj=$(".lay_bj_div");
      var chosenscroll=null;
      
      $current.bind("tap",function(){

		 if($(this).hasClass('subject')){
	    	  var $qkchoose = $('.qkchosen.subject');
	    	   $('.qkchosen.db').hide();
	      }else{
	    	  var $qkchoose = $('.qkchosen.db');
	    	  $('.qkchosen.subject').hide();
	      }
	      

        $('.mui-content').bind("touchmove",function(e){
            e.preventDefault();
            e.stopPropagation();
        })

        
        if($qkchoose.css("display") == "none"){
          $(this).addClass("in").siblings().removeClass("in");
          var offset=$curentsubdata.offset().top;
          $lay_bj.show().css("top",offset);
          $qkchoose.show().css({
            'height':$('body').height()-offset,
            'top':offset
          });
          chosenscroll = new IScroll('.qkchosen', {
              mouseWheel: true,
              scrollbars: false,
              click:true
          });
        }else{
          $lay_bj.hide()
          $(this).removeClass("in");
          $qkchoose.hide();
          $(".mui-content").unbind();
        }
        
      })





      
      $lay_bj.bind("tap",function(event){
        $lay_bj.hide().css("top",0);
        $current.removeClass("in");
        $qkchoose.hide();
        $(".mui-content").unbind();
      })

      $qkchosenp.bind("tap",function(){
    	  if($(this).hasClass("li_no")) {
      		  return;
      	  	}
        if($(this).parents("li").hasClass('in')){
          $(this).parents("li").removeClass('in');
          $(this).siblings("ul").hide();
        }else{
          $(this).parents("ul").find("li").removeClass("in");
          $(this).parents("li").addClass("in");
          $(this).siblings("ul").show();
        }
        
        chosenscroll.refresh()
      })
      $qkyearsel.bind("tap",function(){
        $(this).parents("li").find("a").removeClass("in");
        $(this).addClass("in");
        
      })
  }()
  

  var abstract=function(el){
      var that=$(el);
      if(that.hasClass('active')){
        that.removeClass('active');
        myScroll.refresh();
      }else{
        that.addClass('active');
        myScroll.refresh();
      }
  }

  window.abstract=abstract;
  var factors=function(){
    $('.factors-head').bind('tap',function(){
      var that=$(this);
      if(that.parents('.factors').hasClass('active')){
        that.parents('.factors').removeClass('active');
      }else{
        that.parents('.factors').addClass('active');
      }
      that.find('li').bind('tap',function(){
        that.find('span').text($(this).text());
        console.log($(this).index());
        that.parents('.factors').find('.factors-con').eq($(this).index()).show().siblings().hide();
        myScroll.refresh();
      })
    })
  }
  factors();
//  var toTop=function(){
//    var toTopDom=document.createElement("div");
//    $(toTopDom).addClass("toTop");
//    $(toTopDom).html('<i class="icon iconfont">&#xe612;</i>');
//    $('body').append($(toTopDom));
//    $(toTopDom).tap(function(){
//    	myScroll.scrollTo(0, 0, 500, myScroll.utils.ease.elastic)
//    })
//    myScroll.on('scrollEnd',function(){
//		if(myScroll.y<-280){
//			$(toTopDom).show()
//		}else{
//			
//			$(toTopDom).hide();
//		}
//	})
//  }()
  /*var options={
    searchType:"http://spischolar.com:80/scholar/list"
  }
  function scrollSearch(options){
    var searchDom=document.createElement("div");
    $(searchDom).addClass("scrollsearch");
    $(searchDom).html('<div class="scrollshadow"></div>'+
    '<div class="scrollsWrap">'+
      '<form method="get" action="http://spischolar.com:80/scholar/list">'+
        '<input type="hidden" name="batchId" value="3241a365-81bb-42e1-a511-50e05cdc2d93">'+
          '<input type="text" class="input-text" value="" autocomplete="off" name="value" id="jounal_kw" placeholder="期刊">'+
          '<input type="hidden" name="batchId" value="07fe871d-3c3a-488d-8632-2425790c015c">'+
          '<input type="submit" class="input-submit" id="quick_search_btn" value="检索">'+
      '</form>'+
    '</div>');
    $(document.body).append($(searchDom));
    var p=0,t=0;
    var csstop=parseInt($(searchDom).css("top"));
    var cssOriginal=csstop;
    var scrollPos=$(document.forms[0]).parents("div").siblings("div").offset().top;
    $(window).bind('scroll',function(){ 
          p = $(document.body).scrollTop();
          var csstop=parseInt($(searchDom).css("top")); 
          if(t<=p){//下滚  
              if(csstop==0){
                $(searchDom).css({
                'top':cssOriginal+t-p+"px"
                })
              }  
          }else{//上滚//手指向下滑动//返回上部内容
            if(p>scrollPos){
              if(csstop<0&&p-t>csstop){
                $(searchDom).css({
                  'top':csstop+(t-p)+"px";
                }).addClass("show");
                $(searchDom).find(".scrollsWrap").addClass("shadow");
              }else{
                $(searchDom).css({
                  'top':0
                })
                $(searchDom).find(".scrollsWrap").addClass("shadow");
              }
            }else{
              $(searchDom).css({'top':cssOriginal,'-webkit-transition':'all .5s'});
              $(searchDom).find(".scrollsWrap").removeClass("shadow");
            }
          }  
          setTimeout(function(){t = p;},0);
    })
    $(searchDom).find(".input-text").bind('focus',function(event){
      event.preventDefault();
    })
  }

  scrollSearch(options);*/

/*  $(".docdelivery").click(function(){
    var title=$(this).attr("d-title");
    layer.open({
    	  shadeClose:'false',
        btn: ['提交'],
        content:'<p class="deltitle">'+title+'</p><div class="docdelbox"><label>邮箱:<input type="text" /></label></div>'
    })
  })*/


  /*$('#search-tab-box .input-text').bind('focus',function(){
    $(window).scrollTop($(".lg").offset().top-20)
  })*/

  /*seach*/
/*$(".input-text").bind('click',function(event){
    $(document).bind("touchmove",function(event){
          event.preventDefault();
      })
    document.body.scrollTop=0;
    $(this).parents(".stab").addClass("topfixed");
    $(".radio_js").hide();
    $(".topfixed .input-submit").addClass("icon iconfont search");
    $(".searchfix").css({"-webkit-transform":"translate(0,0)"})
    $(".searchCancle").show();
    $(".searchCancle").bind("click",function(){
      $(".searchfix").css({"-webkit-transform":"translate(100%,0)"});
      $(".topfixed").removeClass("topfixed");
      $(".searchCancle").hide();
      $(".radio_js").show();
      $(document).unbind();
    });
    
    $(this).on('input',function(){
      var val=$(this).val();
      console.log(val);
      $.ajax({
        type:'get',
        url:'',
        data:val,
        dataType:'json',
        beforeSend:function(){
          //$(".artlist-bd-list").append(loading);
        },
        success:function(data){
          $("#serchDatalist").html()
        },
        error:function(){
          //alert("dd")
        }
      })
    })
})*/


})(window);


//收藏与取消收藏
function aa(el,ul) {
//$(el).tap(function(e){
    if($(el).hasClass("favorited")){
       var id = $(el).attr("docId");
       $.get(ul+'user/unfavorite/'+id,function(data){
   		});
       $(el).removeClass("favorited");
       layer.open({content:'<p class="f14 layercolect">您已取消收藏</p>',time: 1})
    }else{
    	 var id = $(el).attr("docId");
    	 $.get(ul+'user/favorite/'+id,function(data){	
    	 });
       $(el).addClass("favorited");
       layer.open({content:'<p class="f14 layercolect">已收藏</p>',time: 1})
    }
}

/*
* el为响应元素
* site地址
* favorited 为收藏样式
* active 未收藏状态
*/

function favoriteAndCancle(el,site,type){
  var docId = $(el).attr('docId');
  var title = $(el).attr('doctitle');
  var type = type ? type : $(el).attr('type');
  if($(el).hasClass('active')){//表示已收藏
    //取消收藏
    $.get(site + 'user/unfavorite/' + docId,function(data){
      console.log(data);
      var data=eval("("+data+")");
      if(data.status==1){
        layer.open({content:'<p class="f14 layercolect">您已取消收藏</p>',time: 1})
        $(el).text('收藏').removeClass('favorited').removeClass('active').attr('title','收藏')
      }else{
        alert(data.message);
      }
    })
  }else{
    //添加收藏
    $.get(site + 'user/favorite/'+docId+"?type=" + type + "&title="+title,function(data){
      console.log(data);
      var data=eval("("+data+")");
        if(data.status==1){
           layer.open({content:'<p class="f14 layercolect">已收藏</p>',time: 2})
          $(el).text('取消收藏').addClass('favorited').addClass('active').attr('title','取消收藏')
      } else {
        alert(data.message);
      }
    })
  }
}

//将事件绑定到document上
$(document).on('tap.wd.favorite','[data-toggle="favorite"]',function(e){
  var $this = $(this);
  //favoriteAndCancle($this,SITE_URL);
})



function llShowBox(){
    
}
