<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/18
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/event-submitSuccess.css">
    <title>新建失败_云英客服自助系统</title>
</head>
<body>
<div class="first-page clearfix">

    <%@ include file="../../static/component/nav/nav.jsp" %>

    <div class="float_left public-top">

        <%@ include file="../../static/component/header/header.jsp" %>

        <div class="event-submitSuccess">
            <div class="tc submitSuccess-ivon-T">
                <img src="../static/images/error.png">
                <h1>很抱歉，您的事件未成功提交，请重新提交！</h1>
            </div>
            <div class="submit-result submit-error tl ">
                <h2>请核对并修改以下信息后重新提交</h2>
                <p class="title">您提交的内容有如下错误：</p>
                <p>
                    <i class="icon iconfont icon-duicuo-"></i>${param.msg}
                </p>

            </div>
            <div class="tc mt24">
                <button class="btn btn-primary mr4">返回首页</button>
                <button class="btn btn-gray">重新提交</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
