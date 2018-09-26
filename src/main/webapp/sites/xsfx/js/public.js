/* 
* @Author: Mark
* @Date:   2015-01-14 09:41:49
* @Last Modified by:   Mark
* @Last Modified time: 2015-03-19 09:21:30
*/
 var Bstoper=false,
     pat=null,
     mpat=null,
     timers=null;
     //animates=[animatins,animatouts]
/****判断是否支持CSS3*****/
function supportCss3(style) {  
    var prefix = ['webkit', 'Moz', 'ms', 'o'],  
    i,  
    humpString = [],  
    htmlStyle = document.documentElement.style,  
    _toHumb = function (string) {  
      return string.replace(/-(\w)/g, function ($0, $1) {  
      return $1.toUpperCase();  
      });  
    };  
       
    for (i in prefix)  
    humpString.push(_toHumb(prefix[i] + '-' + style));  
       
    humpString.push(_toHumb(style));  
       
    for (i in humpString)  
    if (humpString[i] in htmlStyle) return true;  
    return false;  
}  
//console.log(supportCss3("animation"));
/***获取class****/
function getByClass(oparent,oclass){
    try{
        return oparent.querySelectorAll("."+oclass);
    }catch (ex){
            var reset = [];
            var reg = new RegExp("\\b" + oclass + "\\b");
            var oCur = oparent.all;
            for (var i = 0; i < oCur.length; i++) {
                if (reg.test(oCur[i].className)) {
                    reset.push(oCur[i]);
                }
            };
          return reset;
    }
}
/***获取样式表****/
function getClass(obj,name){
    if(obj.currentStyle){
        return obj.currentStyle[name]//IE
    }else{
         return getComputedStyle(obj,false)[name]//IE
    }
}
!function(){
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x] + 'RequestAnimationFrame'];
        window.cancelAnimationFrame = window[vendors[x] + 'CancelAnimationFrame'] || window[vendors[x] + 'CancelRequestAnimationFrame'];
    }
    if (!window.requestAnimationFrame) window.requestAnimationFrame = function(callback, element) {
        var currTime = new Date().getTime();
        var timeToCall = Math.max(0, 16 - (currTime - lastTime));
        var oid = window.setTimeout(function() {
            callback(currTime + timeToCall);
        }, timeToCall);
        lastTime = currTime + timeToCall;
        return oid;
        alert(timeToCall);
    };
    if (!window.cancelAnimationFrame) window.cancelAnimationFrame = function(oid) {
        clearTimeout(oid);
    };
}();
/****缓冲运动*****/
function Stratmove(obj,json,funEnd){
   clearInterval(obj.timer);
   obj.timer=setInterval(function(){
       for(var attr in json){
           var bStop=true,
               cuur=parseFloat(getClass(obj,attr)),
               speed=0;
           if(attr=="opacity"){
              cuur=Math.round(parseFloat(getClass(obj,attr))*100);
           }else{
              cuur=parseFloat(getClass(obj,attr));
           }
           speed=(json[attr]-cuur)/8;
           speed=speed>0?Math.ceil(speed):Math.floor(speed);
           if(cuur!=json[attr]){
                bStop=false;
           }
           if(attr=="opacity"){
                obj.style["opacity"]=(cuur+speed)/100;
                obj.style["filter"]="alpha(opacity="+cuur+speed+")";

           }else{
                obj.style[attr]=Math.round(cuur+speed)+"px";
           }
           if(bStop){
              clearInterval(obj.timer);
           }
           if(funEnd)funEnd();
       }
   },30)
}
/***宽高属性****/
function getViewport(){
  var w=window.innerWidth||document.documentElement.clientWidth||document.body.clientHeight;
  var h=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
  return {width:w,height:h};
}
/***登陆弹窗****/
    pat=new show(false,"Account","login-ck","animatins","animatouts");
    mpat=new login();
var lessThenIE9 = function () {
    var UA = navigator.userAgent,
        isIE = UA.indexOf('MSIE') > -1,
        v = isIE ? /\d+/.exec(UA.split(';')[1]) : 'no ie';
    return v <= 9;
}();//低于IE9
function show(Bstops,win,obj,animatin,animatout){
    if(Bstops||!document.getElementById(obj)){return false;}
    var _this=this;
        this.Winbj=getByClass(document.body,win)[0];
        this.showins=this.Winbj.parentNode;
        this.iclose=this.Winbj.getElementsByTagName("i")[0];
        this.oclose=(!getByClass(this.Winbj,"close")[0])?(this.Winbj.getElementsByTagName("i")[0]):(getByClass(this.Winbj,"close")[0]);
       // this.Agent=navigator.userAgent;
        if(win=="Account"){
          this.opclass="Win_bj Account";
        }else{
          this.opclass=this.Winbj.className;
        }
        //alert(this.Winbj.className);
     if(!-[1,]&&!window.XMLHttpRequest){
        this.showins.style.height=document.documentElement.clientHeight+"px";
     }  
    document.getElementById(obj).onclick=function(){
               _this.animati(animatin);
              // alert(_this.Winbj);
     };
     this.oclose.onclick=this.iclose.onclick=function(){_this.out(animatout)};
 } 
 show.prototype.out=function(animatout){
    var _this=this;
    if(supportCss3("animation")){
        _this.Winbj.className=_this.opclass+" "+animatout;
        _this.swtime(1000);
    }else{
       _this.swtime(0);
    }
    return false;
 } 
 show.prototype.swtime=function(time){
   var _this=this;
   timers=setTimeout(function(){
           _this.Winbj.style.display="none";
           _this.showins.style.display="none";
    }, time);
   return false;
 }
show.prototype.animati=function(animatin){
    var _this=this;
    _this.showins.style.display="block";
    _this.Winbj.style.display="block";
    _this.Winbj.className=_this.opclass+" "+animatin;
    return false;
 }
 /***移动登陆弹窗***/
 new login();
 function login(){
  if(!document.getElementById("login-ck")){return false}
    var _this=this;
       this.loginc=document.getElementById("login-ck");
       this.asidel=document.getElementById("aside-login");
       this.inpbtn=document.getElementById("inp-back");
       if(lessThenIE9){
    	   if(this.asidel&&this.asidel.style){
    		   this.asidel.style.display="none";
    	   }
       }
  // asidel.style.cssText='-webkit-transform: translateX('+getViewport().width+"px"+')';
    window.onresize=function(){
         _this.port();
    }
     login.prototype.port=function(){
        var _this=this;
        if(getViewport().width<=640&&supportCss3("animation")){
              Bstoper=true;
              new show(true);
              this.loginc.onclick=function(){_this.doneout()};
              this.inpbtn.onclick=function(){_this.donein()};

          }else{
              this.loginc.onclick=function(){
                  pat.animati("animatins");
                  return false;
              }
       } 
       return Bstoper;
     }
   // return Bstoper;
   _this.port();
 }

login.prototype.doneout=function(){
     var _this=this;
      _this.asidel.className="aside-login doneout";
      document.body.style.height=getViewport().height+"px";
     return false;
                }
login.prototype.donein=function(){
   var _this=this;
     document.body.style.height="auto";
     _this.asidel.className="aside-login donein";
     return false;
}
 // console.log(log.port());
/*****最小高度****/
function setMinH(eleId,H){
if(!document.getElementById(eleId)){return false;}
var ele=document.getElementById(eleId)
if(!-[1,]&&!window.XMLHttpRequest){//ie6
    ele.style.height=getViewport().height-H+'px';
}else{ele.style.minHeight=getViewport().height-H+'px';}//header footer left的padding
}
setMinH("container",235);
setMinH("Middle",96);
/***获取最后一个元素****/
function lastChilds(obj){
    if(obj.lastElementChild){
      return obj.lastElementChild;
    }else{
      return obj.lastChild; 
    }
}
/***获取下一个同级****/
function get_nextsibling(n){
    var x=n.nextSibling;
    while (x.nodeType!=1)
      {
      x=x.nextSibling;
      }
    return x;
}
/**模拟innerHTML下拉**/
function select_(id,hider,values){
   if(!document.getElementById(id)){return false;}
   var Red=document.getElementById(id),
       inhide=document.getElementById(hider),
       Redparent=Red.parentNode,
       times=Red.nextElementSibling?Red.nextElementSibling:get_nextsibling(Red),
       // alert(get_nextsibling(Red).innerHTML);
      timea=times.getElementsByTagName("a");
      Red.onclick=function(){
          times.style.display="block";
          return false;
      }
      for (var i = 0; i < timea.length; i++) {
          timea[i].onclick=function(){
              Red.innerHTML="";
              Red.innerHTML=this.innerHTML;
              if(values){
                 inhide.value=this.getAttribute(values);
              }else{
                  inhide.value=this.innerHTML;
              }
              
          }
      };
      Redparent.onmouseleave=function(){
            times.style.display="none";
      }
}
select_("section","depofc",'');
/***taber****/
+function(){
       if(!getByClass(document.body,"taber")[0]){return false;}
       var ow=getByClass(document.body,"taber")[0],
           otb=getByClass(ow,"tab")[0],
           oa=otb.getElementsByTagName("a"),
           ock=getByClass(ow,"ck");
       for (var i = 0; i < oa.length; i++) {
           oa[i].index=i;
           oa[i].onmouseover=function(){
           for (var i = 0; i < oa.length; i++) {
            ock[i].style.display="none";
            oa[i].className="";
          };
            if(getViewport().width<=768){
               this.className="";
            }else{
               this.className="active";
            }
            ock[this.index].style.display="block";
       }   
    };
}()
/***手风琴****/
function Accor(chr,attr2){
    if(!getByClass(document.body,"cloum")[0]){return false;}
        var oparent=getByClass(document.body,"cloum")[0],
            le=getByClass(oparent,chr)[0],
            a1=getByClass(le,"A1"),
            a2=getByClass(le,"A2"),
            oo=getByClass(le,"oo");
            lastChilds(le).style["marginRight"]="0";
            for (var i = 0; i < a2.length; i++) {     
                 a2[i].index=i;
                 a2[i].onclick=function(){
                     for (var i = 0; i < a2.length; i++){ 
                        clearInterval(a1[i].timer);
                         a1[i].style[attr2]="45px";
                         lastChilds(le).style["marginRight"]="0";
                         a2[i].className="A2";
                     };
                     this.className="A2 active";
                     if(attr2=="width"){
                         Stratmove(a1[this.index],{"width":325});
                     }else{
                         Stratmove(a1[this.index],{"height":240});
                     }
                     return false;
                     }
              }

}
 Accor("left","width");
 Accor("right","width");
 Accor("bk","height");
 /**栏目切换***/
+function(){
    if(!getByClass(document.body,"essay-tabs")[0]||
      !getByClass(tparent,"essay-sw")[0]){return false};
    var tparent=getByClass(document.body,"essay")[0],
        etab=getByClass(tparent,"essay-tabs")[0],
        oa=etab.getElementsByTagName("a"),
        f1=document.forms[0],
        esw=getByClass(tparent,"essay-sw");
        for (var i = 0; i < oa.length; i++) {
            oa[i].index=i;
            oa[i].onmouseenter=function(){ 
                for (var i = 0; i < esw.length; i++) {
                    esw[i].style.display="none";
                };
                esw[this.index].style.display="block";
                return false;
            }
        };
}()
