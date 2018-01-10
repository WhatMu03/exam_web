<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/19
  Time: 15:43
  顶部导航栏公共组件
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="clearfix main-top w100 boxS">
    <div class="float_left system-name">
        <p>客户自助服务系统</p>
    </div>
    <div class="float_right system-user">
        <i class="icon iconfont icon-dingbudaohang-1"></i>
        <div class="user-name">
            <span style="cursor:pointer;" title="账户管理" id="subAcco">您好，${subAcco.loginName}</span>
            <i class="icon iconfont icon-shangxiazuoyou-1"></i>
        </div>
        <div class="system-icon">
            <i class="icon iconfont icon-dingbudaohang-" style="cursor:pointer;" title="帮助中心" id="help"></i>
        </div>
        <div class="system-icon">
            <i class="icon iconfont icon-dingbudaohang-2" style="cursor:pointer;" title="安全退出" id="logout"></i>
        </div>
    </div>
</div>
<!-- confirm -->
<div id="confirm" class="modal-body boxS clearfix" style="width:400px; padding: 25px 0 0 37px; display:none">
    <div class="w20 modal-icon float_left">
        <img src="../static/images/tu-3.png" style="width:100%; ">
    </div>
    <div class="w80 modal-main float_left boxS">
        <p id="message" style="padding:25px 0 0 10px">共选中5条数据，是否确认批量删除？</p>
    </div>
</div>
<script type="text/javascript" src="/kfxt/static/resource/jquery.js"></script>
<script type="text/javascript" src='/kfxt/static/resource/layer/layer.js'></script>
<script type="text/javascript">
	//帮助中心
    $("#help").on('click', function (e) {  
    	window.open("../help/all.html");
    }); 
	
	//安全退出
    $("#logout").on('click', function (e) { 
	   	 $("#message").html("确定要退出吗？"); 
  		top.layer.open({
	        fix: false,
	        offset: 'auto',
	        type: 1,
	        title: '提示', 
	        moveOut: false,
	        skin: 'layui-layer-ta',
	        area: ['400px', 'auto'],
	        btn:["确定","取消"],
	        btn1:function(){
	        	layer.closeAll(); 
	            window.location.href = "/kfxt/login/logout.json";
	        },
	        btn2:function(){
	        	layer.closeAll();
	        },
	        content: $("#confirm") 
	    }); 
    });
	//账户管理
    $("#subAcco").on('click', function (e) {  
		window.open("../subAcco/detail.html");
    }); 
</script>