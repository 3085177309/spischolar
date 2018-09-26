(function($){
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
      } */
      
    
    
    // 构建学科url
    function buildSubjUrl(evt) {
        var liDom = $(evt).parent('li');
        var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
        var year = $('#year').val();
        var discRepEncode = $(liDom).attr('discRepEncode');
        var discEncode = $(liDom).attr('discEncode');
        var siteFlag = $('#siteFlag').val();
        var sort = $(liDom).attr('sort');

        var key = authorityDatabaseEncode + "%5E" + year + "%5E" + discRepEncode + '&viewStyle=list&authorityDb=' + authorityDatabaseEncode + '&subject=' + discEncode;
        var url = "journal/category/list?queryCdt=shouLuSubjects_3_1_" + key + sort+'&detailYear='+year;
        $(evt).attr('href', url);
    }
    
    window.buildSubjUrl=buildSubjUrl;
    
    // 构建分区url
    function buildPartitionUrl(evt) {
        var liDom = $(evt).parent().parent().parent('li');
        var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
        var year = $('#year').val();
        var discRepEncode = $(liDom).attr('discRepEncode');
        var discEncode = $(liDom).attr('discEncode');
        var siteFlag = $('#siteFlag').val();
        var sort = $(liDom).attr('sort');
        var partition = $(evt).attr('partition');

        var partitionUrl = "&authorityDb=" + authorityDatabaseEncode + "&subject=" + discEncode + "&queryCdt=partition_3_1_" + authorityDatabaseEncode + "%5E" + year + "%5E" + discRepEncode;
        var url = "journal/search/list?" + partitionUrl + "%5E" + partition + "&partition=" + partition + sort + "&viewStyle=list&detailYear=" + year;
        $(evt).attr('href', url);
    }
    window.buildPartitionUrl=buildPartitionUrl;
    
    
    /*
     * 获取固定内容到粘贴板
     */
    function setclipboardData(event){
      var event = event || window.event;
      event.preventDefault ? event.preventDefault() : event.returnValue = false; //阻止浏览器默认事件
	  //chorme
      
      var CopyText=$('.export-item-content').eq(1).text();
	  if(event.clipboardData){
	    event.clipboardData.setData('text/plain',CopyText);
	  }else if(window.clipboardData){
	    //ie
	    window.clipboardData.setData("text",CopyText)
	  }
	  console.log(event.clipboardData);
	  //alert("复制成功！");
	}
  

  
	
	
})(jQuery)



