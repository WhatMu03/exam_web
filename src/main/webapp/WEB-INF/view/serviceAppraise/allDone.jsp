<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/19
  Time: 9:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/remain-evaluated.css">
    <link rel="stylesheet" href="../static/css/module/pagination/page.css">
    <title>待评价_云英客服自助系统</title>
</head>
<body>
<div class="first-page">


    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="待评价"></jsp:param>
    </jsp:include>

    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="w100 position-P boxS">
        <div class="remain-evaluated-Padding boxS">
            <div class="tc mt24">
                <img src="../static/images/all-evaluated.png">
                <h1 style="color: #666666;margin: 20px 0;font-size: 20px;">亲，您已完成全部评价！</h1>
                <button class="btn btn-primary" onclick="haveEvaluated()">查看已评价</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
/*<![CDATA[*/   
function haveEvaluated(){
	window.location.href = "../serviceAppraise/haveEvaluated.html";
}
           
	 /*]]>*/
</script>
</body>
</html>
