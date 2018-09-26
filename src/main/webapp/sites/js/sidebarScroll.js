
new sidebarScroll();
function sidebarScroll(){
    var _this = this;
    this.obj = document.getElementById("gc_form_sub");
	    if(document.getElementById("checkbox-con")){
	    	var targetEle = document.getElementById("checkbox-con")
	    }else {
	    	return 
	    }
        if(targetEle.getElementsByTagName("li").length<5){
            return false;
        }
    var targetHeight=targetEle.currentStyle ? targetEle.currentStyle["height"] : getComputedStyle(targetEle,false)["height"];
    var offseTarget=targetEle.offsetTop+targetEle.offsetHeight;
    
    this.clientheight = document.documentElement.clientHeight;
    this.obj.style.top =targetEle.offsetTop+1 + "px";
    this.init = function(){
        var scrolltop = 0;
        if(document.documentElement.scrollTop){
            scrolltop = document.documentElement.scrollTop;
        }
        else{
            scrolltop = document.body.scrollTop;
        }
        var target = Math.round(scrolltop + this.clientheight/3)-10;
        //alert(targetEle.offsetHeight)
        this.move(target,offseTarget);

    }
    this.getStyle = function(obj,attr){
        return obj.currentStyle ? obj.currentStyle[attr] : getComputedStyle(obj,false)[attr];
    }
    this.move = function(target,offseTarget){
        clearInterval(this.obj.timer);
        this.obj.timer = setInterval(function(){
            var cur = parseInt(_this.getStyle(_this.obj,"top"));
            var speed = (target - cur) / 5;
            speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);
            if(cur >offseTarget){
                //alert(1)
                //_this.obj.style.display="none";
                _this.obj.style.top = offseTarget-1 + "px";
                clearInterval(_this.obj.timer);
            }
            else if(cur<targetEle.offsetTop){
                _this.obj.style.top=targetEle.offsetTop + "px";
                clearInterval(_this.obj.timer);
            }
            else{
                cur += speed;
                _this.obj.style.display="block";
                _this.obj.style.top = cur-18 + "px";
                
            }
        },10);
    }
    
    /*window.onscroll = function(){
        _this.init();
    }*/
    
    $(window).bind("scroll",function(){
        _this.init();   
    });
}