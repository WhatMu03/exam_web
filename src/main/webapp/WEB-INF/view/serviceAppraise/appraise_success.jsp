<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/27
  Time: 14:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/modification-success.css">
    <title>评价成功_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="clearfix modification-success">
                <img src="../static/images/modification-success.png">
                <c:choose>
                    <c:when test="${notEvaluatedCount != 0}">
            			<h1>您的评价已收到，感谢您的支持 ！</h1>
                        <h1>系统检测到您有未评价${appraiseObj}，是否马上去评价？</h1> 
                        <a href="../serviceAppraise/notEvaluated.html"  class="btn btn-primary mt24">是</a>
						<c:if test="${appraiseObj == '事件'}"><a href="../event/list.html" class="btn btn-gray mt24">否</a></c:if>
						<c:if test="${appraiseObj == '需求'}"><a href="../request/list.html" class="btn btn-gray mt24">否</a></c:if>
                    </c:when>
                    <c:otherwise>
            			<h1>您的评价已收到，感谢您的支持 ！</h1>
                    	<a onclick="closeA()" class="btn btn-gray mt24">关闭</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<input type="hidden" class="notEvaluatedCount" value="${notEvaluatedCount}">
<script src="/kfxt/static/resource/jquery.js"></script>
<script type="text/javascript"> 
    function closeA(){ 
    	window.opener='';
    	window.close();
	}
</script>

</body>
</html>

