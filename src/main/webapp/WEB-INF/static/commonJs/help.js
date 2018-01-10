    
/*<![CDATA[*/
	$(function () {
        //  分页start
        Page({
            num:Math.ceil($("#count").val()/10) ,//页码数
            startnum:$("#page").val(),				//指定页码
            elem:$('#page1'),		//指定的元素
            callback:function(n){	//回调函数 
            	window.location.href = url + "?page=" + n;
            }
        });
        // 分页end
    })

	//跳转到文章详情
    $(".article").click(function(){
    	var node = $(this).find(".id"); 
   		var detailUrl = "../help/detail.json?id=" + $(node).val();
    	window.open(detailUrl); 
	}) 
	
	//搜索
	function search(){
    	var key = $("#key").val(); 
   		var detailUrl = url + "?key=" + key;
    	window.location.href = detailUrl; 
    }
    
	//返回到all
    $("#all").click(function(){
		window.location.href = "../help/all.html";
	})  
    
	//返回到new
    $("#new").click(function(){
		window.location.href = "../help/new.html";
	})   
    
	//返回到hot
    $("#hot").click(function(){
		window.location.href = "../help/hot.html";
	})   
    
	//返回到common 
    $("#common").click(function(){
		window.location.href = "../help/common.html";
	})    

    /*]]>*/