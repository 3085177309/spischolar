/**
 * 纬度工具集
 */
(function(global,$){
	//日期格式化,扩展原型对象
	Date.prototype.format = function(format){ 
		var o = { 
			"M+" : this.getMonth()+1, //month 
			"d+" : this.getDate(), //day 
			"h+" : this.getHours(), //hour 
			"m+" : this.getMinutes(), //minute 
			"s+" : this.getSeconds(), //second 
			"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
			"S" : this.getMilliseconds() //millisecond 
		} 

		if(/(y+)/.test(format)) { 
			format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		} 

		for(var k in o) { 
			if(new RegExp("("+ k +")").test(format)) { 
				format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
			} 
		} 
		return format; 
	} 
	
	var _chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
	
	/**
	 * 生成一个UUID
	 */
	Math.uuid = function (len, radix) {
	    var chars = _chars, uuid = [], i;
	    radix = radix || chars.length;
	 
	    if (len) {
	      // Compact form
	      for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
	    } else {
	      // rfc4122, version 4 form
	      var r;
	 
	      // rfc4122 requires these characters
	      uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
	      uuid[14] = '4';
	 
	      // Fill in random data.  At i==19 set the high bits of clock sequence as
	      // per rfc4122, sec. 4.1.5
	      for (i = 0; i < 36; i++) {
	        if (!uuid[i]) {
	          r = 0 | Math.random()*16;
	          uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
	        }
	      }
	    }
	 
	    return uuid.join('');
	  };
	
	/**
	 * 检测Weidu在命名空间内是否存在，如果存在，将之前的重命名
	 */
	if(!!global.Weidu){
		global._weidu=global.Weidu;
	};
	
	/**
	 * 构建一个全局的对象
	 */
	var Weidu=function(){}
	
	/**
	 * 将Weidu替换成成之前的
	 */
	Weidu.noConflict=function(){
		if(!!global._weidu){
			global.Weidu=global._weidu;
			global._weidu=null;
			delete global._weidu;
		}
	}
	
	/**
	 * 判断是否支持CSS3
	 * @return boolean
	 * Weidu.supportCss3("animation");
	 */
	function supportCss3(style){
		var prefix = ['webkit', 'Moz', 'ms', 'o'],  
	    i,  
	    humpString = [],  
	    htmlStyle = document.documentElement.style,  
	    _toHumb = function (string) {  
	    	return string.replace(/-(\w)/g, function ($0, $1) {  
	    		return $1.toUpperCase();  
	    	});  
	    };  
	    for (i in prefix){
	    	humpString.push(_toHumb(prefix[i] + '-' + style));
	    }
	    humpString.push(_toHumb(style));  
	    for (i in humpString){ 
	    	if (humpString[i] in htmlStyle) return true;
	    }
	    return false;  
	}
	Weidu.supportCss3=supportCss3;

	/**
	 * 添加Cookie
	 */
	Weidu.addCookie=function(objName,objValue,objHours){//添加cookie
		var str = objName + "=" + escape(objValue);
		if(objHours > 0){//为0时不设定过期时间，浏览器关闭时cookie自动消失
			var date = new Date();
			var ms = objHours*3600*1000;
			date.setTime(date.getTime() + ms);
			str += "; expires=" + date.toGMTString();
		}
		document.cookie = str;
	}

	/**
	 * 获取指定名称的cookie的值
	 */
	Weidu.getCookie=function(objName){
		var arrStr = document.cookie.split("; ");
		for(var i = 0;i < arrStr.length;i ++){
			var temp = arrStr[i].split("=");
			if(temp[0] == objName) return unescape(temp[1]);
		} 
	}

	/**
	 * 为了删除指定名称的cookie，可以将其过期时间设定为一个过去的时间
	 */
	Weidu.delCookie=function(name){
		var date = new Date();
		date.setTime(date.getTime() - 10000);
		document.cookie = name + "=a; expires=" + date.toGMTString();
	}
	
	global.Weidu=Weidu;
	
})(typeof window !== "undefined" ? window : this,jQuery);