<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/30
  Time: 11:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/modification-success.css">
    <title>评价失败_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="clearfix modification-success">
                <img src="../static/images/error.png">
                <h1>评价失败，请重新评价！</h1>
                <a class="btn btn-primary  mt24" id="appraiseAgain">重新评价</a>
                <a href="../serviceAppraise/notEvaluated.html" id="close" class="btn btn-gray  mt24">返回列表</a>
            </div>
        </div>
    </div>
</div>
<input type="hidden" value="${param.requestNo}" class="requestNo">
<input type="hidden" value="${param.eventNo}" class="eventNo">
<input type="hidden" value="${param.type}" class="type">
<script src="/kfxt/static/resource/jquery.js"></script>

<script>
    var url = "";
    $(function(){
        if ($('.type').val() == "event"){
            url = "../serviceAppraise/event.html?eventNo="+$('.eventNo').val();
        } else {
            url = "../serviceAppraise/request.html?requestNo="+$('.requestNo').val();
        }
        $('#appraiseAgain').click(function(){
            window.location.href = url;
        })
    })

</script>

</body>
</html>


