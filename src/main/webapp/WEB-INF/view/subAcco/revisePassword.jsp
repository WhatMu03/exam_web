<%--
  Created by IntelliJ IDEA. sunyt22618
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
    <link rel="stylesheet" href="../static/css/modification-message.css">
    <title>密码修改_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="tip-title">
                <h2>修改账号密码</h2>
            </div>
            <div class="form-edit clearfix">
                <form class="modification-form">
                    <div class="form-group" style="margin-bottom: 10px;">
                        <label class="label" style="opacity: 0;">请输入当前</label>
                        <div class="validate-error" style="display: none;">
                            <i class="icon iconfont icon-jingshi-"></i>
                            <span>设置的密码不不符合要求</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="label"><font class="needIcon">*</font>请输入当前的登录密码：</label>
                        <input type="password" id="oldPass" class="form-control " placeholder="请输入当前的登录密码">
                        <i class="success-icon" style="display: none;"></i>
                    </div>
                    <div class="form-group set-postion">
                        <label  class="label"><font class="needIcon">*</font>新的登录密码：</label>
                        <input type="password" id="newPass" class="form-control " placeholder="请输入新的登录密码">
                        <i class="success-icon" style="display: none;"></i>
                        <div class="password-tip">
                            <div class="password-error">
                            <span>
                            6-20个字符，密码至少包含字母，数字以及标点符号（除空格）中的两种
                            </span>
                                <i class="trangle"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="label"><font class="needIcon">*</font>确认新的登录密码：</label>
                        <input type="password" id="checkPass" class="form-control" placeholder="请再次输入新的登录密码">
                        <i class="success-icon" style="display: none;"></i>
                    </div>
                </form>
                <div class="tool-btn">
                    <button class="btn btn-primary mr6" onclick="submit()">确认</button>
                    <button class="btn btn-gray" onclick="reset()">重置</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
    <script>
    	//提交
        function submit() {
            $.ajax({
                url:'../subAcco/revisePassword.json',
                type:'post',
                data:{
                    oldPass:$('#oldPass').val(),
                    newPass:$('#newPass').val(),
                    checkPass:$('#checkPass').val()
                },
                success:function (data) {
                    data = JSON.parse(data);
                    if(data.result == '1'){
                        $(".validate-error").hide();
                        $(".success-icon").show();
                        window.location.href = '../subAcco/revisePassword_success.html';

                    }else{
                        $(".validate-error").show();
                        $(".validate-error").find("span").text(data.message);
//                        layer.alert('修改失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
                    }
                }
            })
        }

        //重置
        function reset() {
            $("#oldPass").val("");
            $("#newPass").val("");
            $("#checkPass").val("");
        }
    </script>
</body>
</html>
