<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
    <link rel="stylesheet" href="../static/css/first-register.css">
    <title>首次登陆_云英客服自助系统</title>
</head>
<body>
    <div class="first-register boxS">

        <%@ include file="../../static/component/header/header_black.jsp" %>

        <div class="register-main pd15 boxS">
            <div class="register-tip boxS">
                <div class="tip-title">
                    <h2>首次登陆提醒</h2>
                </div>
                <div class="tip-message clearfix">
                    <img src="../static/images/first-register.png" class="float_left">
                    <div class="float_left user-tip">
                        <p>尊敬的客户，您好！</p>
                        <p>为保护您的账户安全，请您务必在首次登陆时修改密码。</p>
                    </div>
                    <div class="float_right">
                        <button class="btn btn-primary correction-password" onclick="edit()">修改密码</button>
                    </div>
            </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="../static/resource/jquery.js"></script>
    <script type="text/javascript">
		function edit(){
			window.location.href = "../subAcco/revisePassword.html";
		}
    </script>
</body>
</html>