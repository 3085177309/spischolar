(function(){  
	var doc=document;
	function isCompatible(other) {
		//使用能力监测来检查必要条件
		if(other===false 
			||!Array.prototype.push 
			||!Object.hasOwnProperty 
			||!document.createElement 
			||!document.getElementsByTagName 
		){
			return false;
		}
		return true;
	};
	var addLoadEvent=function(loadEvent,waitForImages){
		if(!isCompatible()) return false;

		//如果等待标记是true则使用常规的添加事件的方法
		if(waitForImages){
			return addEvent(window,'load',loadEvent)
		}
		//否则使用一些不同的方式包装loadEvent
		
		var init=function(){
			//如果这个函数已经被调用过了则返回
			if(arguments.callee.done) return;
			//标记这个函数以便检验它是否运行
			arguments.callee.done=true;

			//在document的环境中运行载入事件
			loadEvent.apply(document,arguments)
		}

		//为DOMContentLoaded事件注册事件侦听器
		if(document.addEventListener){
			document.addEventListener("DOMContentLoaded",init,false);
		}
		//对safair，使用setInterval()函数监测
		//documnet是否载入完成
		if (/WebKit/i.test(navigator.userAgent)) {
			var _timer=setInterval(function(){
				if(/loaded|complete/.test(document.readyState)){
					clearInterval(_timer);
					init()
				}
			},10);
		}

		//对于IE使用条件注释
		// 附加一个在载入过程最后执行的脚本
		//并监测该脚本是否载入完成
		document.write("<script id=__ie_onload defer src=javascript:void(0)></script>");
		var script=document.getElementById("__ie_onload");
		script.onreadystatechange=function(){
			if(this.readyState=="complete"){
				init();
			}
		}

		return true;
	}
	function addEvent( node, type, listener ) {
	    // Check compatibility using the earlier method
	    // to ensure graceful degradation
	    //if(!isCompatible()) { return false }
	    //if(!(node = $(node))) return false;
	    
	    if (node.addEventListener) {
	        // W3C method
	        node.addEventListener( type, listener, false );
	        return true;
	    } else if(node.attachEvent) {
	        // MSIE method
	        node['e'+type+listener] = listener;
	        node[type+listener] = function(){node['e'+type+listener]( window.event );}
	        node.attachEvent( 'on'+type, node[type+listener] );
	        return true;
	    }
	    
	    // Didn't have either so return false
	    return false;
	};

	//删除这个class
	function removeClass(ele,cls) {if(hasClass(ele,cls)){var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');ele.className=ele.className.replace(reg,' ');}} 
	//添加class
	function addClass(ele,cls) {if(!hasClass(ele,cls)) ele.className += " "+cls;}
	/***获取class****/
	function getByClass(classStr,tagName){ 
		if (document.getElementsByClassName) { 
			return document.getElementsByClassName(classStr) 
		}else { 
			var nodes = document.getElementsByTagName(tagName),ret = []; 
			for(i = 0; i < nodes.length; i++) { 
				if(hasClass(nodes[i],classStr)){ 
					ret.push(nodes[i]) 
				} 
			} 
			return ret; 
		} 
	} 
	//判断是否有这个class
	function hasClass(node,className){ 
	var names = node.className.split(/\s+/); 
	for(var i=0;i<names.length;i++){ 
	if(names[i]==className) 
	return true; 
	}return false; 
	} 
	//下一个兄弟元素
	function getNextSibling(startBrother){endBrother=startBrother.nextSibling;while(endBrother.nodeType!=1){endBrother = endBrother.nextSibling;}return endBrother;}
	function sibling( elem ) {
	  var r = [];
	  var n = elem.parentNode.firstChild;
	  for ( ; n; n = n.nextSibling ) {
	   if ( n.nodeType === 1 ) {
	    r.push( n );
	   }
	  }
	  return r;
	 }
	function isMouseLeaveOrEnter(e,handler,eleName) {if (e.type != 'mouseout' && e.type != 'mouseover') return false;var reltg = e.relatedTarget ? e.relatedTarget : e.type == 'mouseout' ? e.toElement : e.fromElement;while (reltg && reltg != handler && reltg.nodeName!=eleName)reltg = reltg.parentNode;return (reltg != handler);}  
	function getDocSize(){
	   if(doc.compatMode == 'BackCompat')//BackCompat和CSS1Compat
	   return {width:Math.max(doc.body.clientWidth,doc.body.scrollWidth),
	           height:Math.max(doc.body.clientHeight,doc.body.scrollHeight)
	       };
	   //opare9.0在有滚条时 client 和scroll都是文档高度  没滚条时client为文档高度 scroll为可视区高度 和其他浏览器相反  
	   return {width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),
	           height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)
	       };
	}
	function getCoords(el){
	  var box = el.getBoundingClientRect(),
	  doc = el.ownerDocument,
	  body = doc.body,
	  html = doc.documentElement,
	  clientTop = html.clientTop || body.clientTop || 0,
	  clientLeft = html.clientLeft || body.clientLeft || 0,
	  top  =Math.floor( box.top  + (self.pageYOffset || html.scrollTop  ||  body.scrollTop ) - clientTop ),
	  left =Math.floor( box.left + (self.pageXOffset || html.scrollLeft ||  body.scrollLeft) - clientLeft )
	  return { 'top': top, 'left': left };
	}
	//-----------------------------------------------------------------------------------------------
	getViewport = function(){
		if(window.innerHeight)
			return {width:window.innerWidth,height:window.innerHeight};
		if(doc.compatMode == 'BackCompat')
			return {width:doc.body.clientWidth,height:doc.body.clientHeight};
		return {
			width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),
			height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)
		};
	}


	css = function(obj, attr, value){
	    switch (arguments.length)
	    {
	        case 2:
	            if(typeof arguments[1] == "object")
	            {
	                for (var i in attr) i == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + attr[i] + ")", obj.style[i] = attr[i] / 100) : obj.style[i] = attr[i];
	            }else{  //currentStyle ie  getComputedStyle ff 单位始终是 px
	                if(attr == "opacity"){return obj.currentStyle ? obj.currentStyle[attr]*100 : getComputedStyle(obj, null)[attr]*100}
	                else{
	                    return obj.currentStyle ? (function(){
	                       //ie下在获取宽高时 是否为auto
	                       var v = obj.currentStyle[attr];
	                       if(attr.toUpperCase()=='WIDTH' && v=='auto'){
	                           var lefBor = parseFloat(obj.currentStyle['borderLeftWidth']),
	                               rigBor = parseFloat(obj.currentStyle['borderRightWidth']),
	                               borW = lefBor ? lefBor : 0 + rigBor ? rigBor : 0;
	                           return v = obj.offsetWidth - parseFloat(obj.currentStyle['paddingLeft']) - parseFloat(obj.currentStyle['paddingRight']) - borW;
	                       }
	                       else if(attr.toUpperCase()=='HEIGHT' && v=='auto'){
	                           var topBor = parseFloat(obj.currentStyle['borderTopWidth']),
	                               botBor = parseFloat(obj.currentStyle['borderBottomWidth']),
	                               borH = topBor ? topBor : 0 + botBor ? botBor : 0;
	                           return  v = obj.offsetHeight - parseFloat(obj.currentStyle['paddingTop']) - parseFloat(obj.currentStyle['paddingBottom']) - borH;
	                       }else{return v;}
	                    })() :  getComputedStyle(obj, null)[attr];
	                }
	            }
	            break;
	        case 3:
	            attr == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + value + ")", obj.style[attr] = value / 100) : obj.style[attr] = value;
	            break;
	    }
	};

	animate = function(obj, sStyleName, nNedV, time, fn){
	    var nStartTime = + new Date(),
	        nStartV = parseFloat(css(obj, sStyleName)),
	        sUnit = sStyleName == 'opacity' ? '' : 'px',
	        nDistance = nStartV - nNedV;
	        
	        function easeInOutCubic(pos){
	          if ((pos/=0.5) < 1) return 0.5*Math.pow(pos,3);
	          return 0.5 * (Math.pow((pos-2),3) + 2);
	        }
	        
	     if(obj['_' + sStyleName]){clearInterval(obj['_'+sStyleName])};
	     
	     obj['_'+sStyleName] = setInterval(function (){
	           var nFraction = easeInOutCubic((+new Date() - nStartTime) / time), 
	               thisV = nStartV - nDistance * nFraction,
	               oCss = {};
	           if(nFraction < 1){
	               oCss[sStyleName] = (thisV) + sUnit;
	               css(obj, oCss);
	           }else if(nFraction > 1){
	               oCss[sStyleName] = (nNedV) + sUnit;
	               css(obj, oCss);
	               if(fn) fn();
	               clearInterval(obj['_' + sStyleName]);
	               obj = null;
	           }
	    }, 20);
	}
	/////////////////////////////////////////////////第一个子元素
	function getFirstChild(startBrother){
	  endBrother=startBrother.firstChild;
	  while(endBrother.nodeType!=1){
	    endBrother = endBrother.nextSibling;
	  }
	  return endBrother;
	}
	
	////////////////////////////////////////js节流
	var throttle = function(func, wait, options) {
	    /* options的默认值
	     *  表示首次调用返回值方法时，会马上调用func；否则仅会记录当前时刻，当第二次调用的时间间隔超过wait时，才调用func。
	     *  options.leading = true;
	     * 表示当调用方法时，未到达wait指定的时间间隔，则启动计时器延迟调用func函数，若后续在既未达到wait指定的时间间隔和func函数又未被调用的情况下调用返回值方法，则被调用请求将被丢弃。
	     *  options.trailing = true; 
	     * 注意：当options.trailing = false时，效果与上面的简单实现效果相同
	     */
	    var context, args, result;
	    var timeout = null;
	    var previous = 0;
	    if (!options) options = {};
	    var later = function() {
	      previous = options.leading === false ? 0 : _.now();
	      timeout = null;
	      result = func.apply(context, args);
	      if (!timeout) context = args = null;
	    };
	    return function() {
	      var now = _.now();
	      if (!previous && options.leading === false) previous = now;
	      // 计算剩余时间
	      var remaining = wait - (now - previous);
	      context = this;
	      args = arguments;
	      // 当到达wait指定的时间间隔，则调用func函数
	      // 精彩之处：按理来说remaining <= 0已经足够证明已经到达wait的时间间隔，但这里还考虑到假如客户端修改了系统时间则马上执行func函数。
	      if (remaining <= 0 || remaining > wait) {
	        // 由于setTimeout存在最小时间精度问题，因此会存在到达wait的时间间隔，但之前设置的setTimeout操作还没被执行，因此为保险起见，这里先清理setTimeout操作
	        if (timeout) {
	          clearTimeout(timeout);
	          timeout = null;
	        }
	        previous = now;
	        result = func.apply(context, args);
	        if (!timeout) context = args = null;
	      } else if (!timeout && options.trailing !== false) {
	        // options.trailing=true时，延时执行func函数
	        timeout = setTimeout(later, remaining);
	      }
	      return result;
	    };
  	};

	addLoadEvent(function(){
		docSet();
		sidebar("side-menue");
	})
	function docSet(){
		var docSeted=function(){
			var Viewport=getViewport();
			document.getElementById("content").style.height=Viewport.height-115+'px';
			document.getElementById("side-menue").style.height=Viewport.height-115+"px";
			document.getElementById("rightMain").style.height=Viewport.height-115-80-23+"px";
		}
		docSeted();
		window.onresize=function(){
			throttle(docSeted(),200,{
				leading:true,
				trailing:true
			})
		}
	}

	function sidebar(ele){
		var sidenav=document.getElementById(ele).getElementsByTagName("a");
		for (var i = 0; i < sidenav.length; i++) {
			sidenav[i].onclick=function(){
				resetClassName()
				this.className="in"
			}
		};
		function resetClassName(){
			for (var i = 0; i < sidenav.length; i++) {
				sidenav[i].className=""
			};
		}
	}
})()
