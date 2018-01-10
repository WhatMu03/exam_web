<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/27
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="clearfix main-top main-top-hasBac">
    <img class="float_left" src="../static/images/logo.png">
    <div class="float_left system-name">
        <p>客户自助服务系统</p>
    </div>
    <div class="float_right system-user">
        <i class="icon iconfont icon-dingbudaohang-1"></i>
        <div class="user-name">
            <span style="cursor:pointer;" title="账户管理" id="subAcco">您好，${subAcco.loginName}</span>
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
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
    //帮助中心
    $("#help").on('click', function (e) {
        window.open("../help/all.html");
    });

    //安全退出
    $("#logout").on('click', function (e) {
        window.location.href = "../login/logout.json";
    });

    //账户管理
    $("#subAcco").on('click', function (e) {
        window.open("../subAcco/detail.html");
    });
</script>
