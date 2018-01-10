<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/18
  Time: 15:21
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
    <link rel="stylesheet" href="../static/css/event-submitSuccess.css">
    <title>新建成功_云英客服自助系统</title>
<body>
<div class="first-page clearfix">

    <%@ include file="../../static/component/nav/nav.jsp" %>

    <div class="float_left public-top">

        <%@ include file="../../static/component/header/header.jsp" %>

        <div class="event-submitSuccess">
            <div class="tc submitSuccess-ivon-T">
                <img src="../static/images/evaluate-success.png">
                <h1>您的事件已成功提交，请耐心等待！</h1>
            </div>
            <div class="submit-result">
                <p>事件名称：服务器炸了</p>
                <div>
                    <label>事件编号：<span>23421</span></label>
                    <label>联系人：<span>小龙女</span></label>
                    <label>发布时间：<span>2017-1-12——2017-12-12</span></label>
                </div>
            </div>
            <div class="tc mt24">
                <button class="btn btn-primary mr4">返回首页</button>
                <button class="btn btn-gray mr4">查看事件详情</button>
                <button class="btn btn-gray">继续提交</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
