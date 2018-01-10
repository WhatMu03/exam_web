<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/9/18
  Time: 12:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
    <link rel="stylesheet" href="../static/css/modification-success.css">
    <title>修改成功_云英客服自助系统</title>
</head>
<body onload="setTimeout('dojump()',1000)">
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="clearfix modification-success">
                <img src="../static/images/modification-success.png">
                <h1>恭喜您，密码修改成功！</h1>
                <a href="../home/homePage.html" class="skip-tip"><span id="jump">5</span>秒后自动跳转，点击立即返回</a>
            </div>
        </div>
    </div>
</div>

<script src="../static/resource/jquery.js"></script>

<script language="javascript">
    var t = 4;
    function dojump(){
        jump.innerHTML=t;
        t --;
        if(t>=0)
            setTimeout('dojump()',1000);
        else
            window.location.href="../home/homePage.html";
    }
</script>

</body>
</html>
