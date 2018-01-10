<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/login.css">
    <%@ include file="../../static/component/common/public.jsp"%>
    <title>在线考试平台</title>
</head>
<body class="module">
<div class="login-top">
    <ul>
        <li><img src="../static/images/logo.png" /></li>
        <li class="bn">在线考试平台</li>
    </ul>
</div>
<div class="login-cont clearfix">
    <div class="login-cont-fl fl">
        <p>账户登录</p>
        <div class="validate-error" style="width: 236px;position: relative;top:-20px;left: 30px;display: none">
            <i class="icon iconfont icon-jingshi-"></i>
            <span class="message">设置的密码不不符合要求</span>
        </div>
        <ul>
            <li>
                <i class="icon iconfont icon-dingbudaohang-1"></i>
                <input type="text" name="loginNo" id="loginNo" placeholder="请输入账号">
            </li>
            <li>
                <i class="icon iconfont icon-mima"></i>
                <input type="password" name="password" id="password" autocomplete="off" placeholder="请输入密码">
            </li>
            <li class="bn first-child">
                <div class="code-inp fl">
                    <i class="icon iconfont icon-denglu-tubiao-1"></i>
                    <input type="text" id="code" name="code" placeholder="请输入验证码">
                </div>
                <div class="code fr"  style="width: 92px;height:38px; overflow:hidden">
                    <img id="imgObj" alt="验证码" src="../login/validateCode.json" style="width: 92px;height: 40px;" onclick="changeImg()"/> 
                </div>
            </li>
        </ul> 
        <button class="btn btn-primary plr110 mt24 ml30" id="loginBtn">登录</button>
    </div>
    <div class="login-cont-fr fr">
        <h2>登录请注意以下注意事项</h2>
        <p>
            1、请使用5位数字字串作为登录账号，登录账号会以邮件的形式发送给您。<br>
            2、如果您没有收到发送的账号信息，<span style="color: blue;">请联系客服人员，具体联系方式：0571-26695555 转 5。</span><br>
            3、客户服务相关栏目只有会员才有查看权限。<br>
            4、如果忘记了登录密码，<span style="color: blue;">请致电客服人员。</span><br>
            5、<a href="mailto:hsyun@hundsun.com" style="text-decoration:underline blue;color: blue">修改密码或者注销账户，请向hsyun@hundsun.com客服邮件提出申请。</a>
        </p>
    </div>
</div>
<div class="login-footer">
    <div class="footer-cont">
        <div class="qr-code fl"><img src="../static/images/login-qr-code.jpg" /></div>
        <div class="cont fl">
            杭州市滨江区江南大道3588号恒生大厦<br>
            总机：0571-28828888 传真：0571-28823456 邮政编码：310053 <br>
            浙ICP备09092082号-5     Copyright@ 2010 Hundsun Technologies Inc.ALL Rights Reserved
        </div>
    </div>
</div>

<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
    /*<![CDATA[*/
    (function(){

        $('#loginBtn').click(function(){
           login();
        });

        document.onkeydown = function (e) {
            var ev = document.all ? window.event : e;
            if (ev.keyCode == 13){
                login();
            }
        }

    })();

    //登录
    function login() {
        $.ajax({
            url: '../login/loginInput.json',
            type: 'POST',
            data: {
                loginNo: $('#loginNo').val(),
                password: $('#password').val(),
                code: $('#code').val()
            },
            beforeSend:function(){
                $('#loginBtn').attr('disabled','disabled');//让提交按钮失效，以实现防止按钮重复点击
                $('#loginBtn').text('登录中');//给用户提供友好状态提示
            },
            success: function (data) {
                if (data.message == '登录成功') {
                    if (data.firstLogin == "1") {
                        window.location.href = "../login/firstLogin.html"
                    } else {
                        window.location.href = "../home/homePage.html"
                    }
                } else {
                    $('.validate-error').css('display','block');
                    $('.message').text(data.message);//提示错误信息
                    $('#loginBtn').removeAttr('disabled');
                    $('#loginBtn').text('登录');
                    changeImg();//更换验证码
                }

            }
        })
    }

    // 刷新图片
    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", changeUrl(src));
    }

    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function changeUrl(url) {
        var timestamp = (new Date()).valueOf();
        var index = url.indexOf("?", url);
        if (index > 0) {
            url = url.substring(0, index);
        }
        if ((url.indexOf("&") >= 0)) {
            url = url + "?tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }

    /*]]>*/
</script>
</body>
</html>