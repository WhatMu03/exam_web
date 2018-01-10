<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/10/23
  Time: 16:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/module/common/base.css">
    <link rel="stylesheet" href="../static/font/iconfont.css">
    <link rel="stylesheet" href="../static/css/module/common/leftMenu.css">
    <link rel="stylesheet" href="../static/css/module/common/btn.css">
    <link rel="stylesheet" href="../static/css/event-details.css">
    <title>无数据_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">
    <div class="clearfix main-top main-top-hasBac">
        <img class="float_left" src="../static/images/logo.png">
        <div class="float_left system-name">
            <p>客户自助服务系统</p>
        </div>
        <div class="float_right system-user">
            <i class="icon iconfont icon-dingbudaohang-1"></i>
            <div class="user-name">
                <span style="cursor:pointer;color:white;" title="账户管理" id="subAcco">您好，${subAcco.loginName}</span>
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
    <div class="register-main pd15 boxS">
        <div class="register-tip boxS ">
            <div class="errorPage">
                <img src="../static/images/no-common.png" alt="" style="width: 279px;height: 253px;">
                <p>抱歉！您访问的数据不存在</p>
            </div>
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
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
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
	            window.location.href = "../login/logout.json";
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
</body>
</html>
