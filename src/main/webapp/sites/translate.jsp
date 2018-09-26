<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp" />
<title>Spis文献翻译</title>
<link href="<cms:getProjectBasePath/>resources/css/webuploader.css"
    rel="stylesheet" />
    <script src="<cms:getProjectBasePath/>resources/js/webuploader.js"></script>
</head>
<body>
    
        <div class="index-wraper">
            <div class="index-inwraper">
                <div class="index-container">
                    <div class="head sub-head">
                        <jsp:include page="include/navbar.jsp"></jsp:include>
                    </div>
                    

                    <!-- 文件翻译 主体内容 -->
                    <div class="file-wrap">
                        <h3>文件翻译</h3>
                        <div class="file-cont">
                            <div class="file_select_box">
                                <!-- <form id="file-upload" enctype="multipart/form-data">
                                    <input type="file" name="file" id="up-dilivery" class="up-filebox" accept="application/pdf,text/plain,application/msword">
                                </form> -->
                                <div class="upload_img"></div>

                                <!-- 初始状态 -->
                                <div class="file_state init">
                                    <p class="file_select">
                                        <a  href='javascript:void(0)'>选择文件</a>
                                    </p>
                                    <p class="upload_warning">支持PDF格式，文件大小不超过2M，暂不支持纯图片、扫描文件</p>
                                </div>

                                <!-- 上传中状态 -->
                                <div class="file_state upload">
                                    <p class="upload_txt">
                                        文件上传中...
                                    </p>
                                    <p class="upload_warning">支持PDF格式，文件大小不超过2M，暂不支持纯图片、扫描文件</p>
                                    <p class="cancel_upload">
                                        <a href='javascript:void(0)'>取消</a>
                                    </p>
                                </div>

                                <!-- 上传成功状态 -->
                                <div class="file_state success">
                                    <p class="file_name"></p>
                                    <p class="file_replace"><a href='javascript:void(0)'>更换</a></p>
                                </div>

                                <!-- 正在翻译中状态 -->
                                <!-- <div class="file_state late">
                                    <p class="late_txt">
                                        文件翻译中...
                                    </p>
                                    <p class="cancel_late">
                                        <a href="javascript:void(0)">取消</a>
                                    </p>
                                </div> -->
                            </div>


                            
                            <div class="file_late_box">
                                <div class="late_explain">
                                    <span class="left">源语言：自动检测</span>
                                    <i></i>
                                    <span class="right">目标语言：中文</span>
                                </div>
                                <div class="late_btn">
                                    <a href="javascript:void(0)" class="">翻译</a>
                                </div>
                                <div class="late_err">
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>





                </div>
            </div>
        </div>


        <jsp:include page="include/footer.jsp"></jsp:include>

        <script type='text/javascript'>
            ;(function(){//判断IE 版本
                var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
                var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
                var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
                var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
                if(isIE) {
                    var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
                    reIE.test(userAgent);
                    var fIEVersion = parseFloat(RegExp["$1"]);
                    if(fIEVersion <= 9) {
                        $(".file_state.init .file_select").html('<b>IE'+fIEVersion+'不支持此功能！请升级浏览器或使用其他主流浏览器！</b>');
                        $(".upload_img").addClass('isIE');
                    }  
                }
            }())
            $(function(){
                var state=$(".file-wrap .file_state"),//状态盒子
                    img=$(".file-wrap .upload_img"),//状态图片
                    sel_file=$(".file-wrap .file_state.init a,.file-wrap .file_state.success a"),//选择文件 更换选择按钮
                    cancel_upload=$(".file-wrap .file_state.upload a"),//上传中状态 取消按钮
                    cancel_late=$(".file-wrap .file_state.late a"),//翻译中状态 取消按钮

                    that_file=null,//当前上传的文件
                    that_name=null,//当前上传的文件名
                    file_cancel=false,//是否取消上传
                    late_btn=$(".file-wrap .file_late_box .late_btn a"),//翻译按钮
                    error=$(".file-wrap .file_late_box .late_err span"),//错误提示
                    file_input=$(".file-wrap #up-dilivery");//文件上传 input

                // 取消上传
                cancel_upload.click(function(){
                    file_init();
                    file_cancel=true;//取消上传：true
                })

                // 点击翻译
                late_btn.click(function(){
                    if(!$(this).hasClass("in")){ return false;}
                    window.location.href="/translate/trans?fileName="+that_name;
                    // window.open("/translate/trans?fileName="+that_name);
                })
                // 取消翻译
                cancel_late.click(function(){
                    upload_success(that_file);
                })

                img.click(function(){
                    if($(this).attr('class') != 'upload_img webuploader-container'){
                        return false;
                    }
                })


                var uploader = WebUploader.create({

                    auto: true,
                    // swf文件路径
                    swf:'<cms:getProjectBasePath/>resources/swf/Uploader.swf',

                    // 文件接收服务端。
                    server: '/translate/upload',

                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: '.file-wrap .file_state.init a,.file-wrap .file_state.success a,div[class="upload_img"]'
                });
                // 上传前 事件
                uploader.on( 'uploadStart', function( file ) {
                    var fileSize=file.size / 1024,
                        fileMaxSize=1024 * 2;//2M
                    if(fileSize>fileMaxSize){
                        layer.msg("文件大小不能超过2M！");
                        uploader.stop();
                        uploader.reset();
                        return false;
                    }
                    if (!/\.(pdf)$/.test(file.name)) {    
                        layer.msg("仅支持PDF格式！");    
                        uploader.stop();
                        uploader.reset();
                        return false;   
                    } 
                    file_upload(); 
                });
                // 上传失败 事件
                uploader.on( 'uploadError', function( file, reason ) {
                    if(!file_cancel){
                        file_init('文件上传失败！');
                    }else{
                        file_cancel=false;
                    }
                });
                // 上传成功 事件
                uploader.on( 'uploadSuccess', function( file,response ) {
                    if(file_cancel){
                        that_name=null;
                        that_file=null;
                        file_cancel=false;
                    }else{
                        that_name=response.data;
                        that_file=file.name;
                        upload_success(that_file);
                        uploader.reset();
                    }
                });

                



                // 初始化 状态
                function file_init(str){
                    style(state,false);
                    state.hide();
                    img.attr("class","upload_img");
                    style($(".file-wrap .file_state.init"),true);
                    late_init(true);
                    if(str) late_init(true,str);
                }

                // 正在上传 状态
                function file_upload(){
                    style(state,false);
                    img.attr("class","upload_img upload");
                    style($(".file-wrap .file_state.upload"),true);
                    late_init(true);
                }

                // 上传成功 状态
                function upload_success(file,str){
                    var format=(file.toLowerCase().split('.').splice(-1))[0];
                    style(state,false);
                    state.hide();
                    img.attr("class","upload_img").addClass('pdf');
                    style($(".file-wrap .file_state.success"),true);
                    $(".file-wrap .file_state.success").find(".file_name").text(file);
                    late_init(false);
                    if(str) late_init(false,str);
                }
                
                
                // 显示、隐藏 样式
                function style(dom,show){
                    if(show){
                        dom.css({
                            width:"auto",
                            height:"auto",
                            overflow:"visible",
                            marginTop:"24px",
                            display:"block"

                        })
                    }else{
                        dom.css({
                            width:0,
                            height:0,
                            overflow:'hidden',
                            marginTop:"0"
                        })
                    }
                }




                // 下方 翻译区域状态
                function late_init(bool,err_str){
                    if(bool) late_btn.removeClass("in");
                    else late_btn.addClass("in");

                    if(err_str) error.text(err_str).parent().show();
                    else error.text('').parent().hide();
                }
            })
        </script>
    </body>
</html>