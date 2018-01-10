<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/9/18
  Time: 12:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
    <link rel="stylesheet" href="../static/css/user-detail.css">
    <title>账户详情_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">
    <%@ include file="../../static/component/header/header_black.jsp" %>
    <div class="register-main register-main-pd boxS">
        <div class="bac-white children-ID">
            <div class="children-mr">
                <label>子账户名：</label>
                <span class="children-name">${result.loginName}</span> 
                <c:if test="${result.status eq '启用' }"><i class="status-icon bac-green">正常</i></c:if>
                <c:if test="${result.status eq '禁用' }"><i class="status-icon bac-red">禁用</i></c:if>
            </div>
            <div>
                <label>子账号编号：</label><span>${result.loginNo}</span>
                <label class="set-marL">创建日期：</label><span>${result.createTime}</span>
            </div>
        </div>
        <div class="bac-white children-detail">
            <h2 style="font-size: 16px;font-weight: bold;">详细信息</h2>
            <div class="children-detail-show">
                <div class="">
                    <label>客户编号：</label><span>${result.customerNo}</span>
                </div>
                <div class="">
                    <label>客户名称：</label><span>${result.customerName}</span>
                </div>
                <div class="">
                    <label>邮箱：</label><span>${result.email}</span>
                </div>
                <div class="">
                    <label>手机号：</label><span>${result.mobile}</span>
                </div>
                <div class="">
                    <label>座机号：</label><span>${result.phone}</span>
                </div>
                <div class="">
                    <label>部门：</label><span>${result.depth}</span>
                </div>
                <div class="">
                    <label>职位：</label><span>${result.post}</span>
                </div>
                <div class="">
                    <label>上次登录时间：</label><span>${result.lastLoginTime}</span>
                </div>
            </div>
        </div>
        <div class="bac-white signIn-password clearfix">
            <h2 style="font-size: 16px;font-weight: bold;">登陆密码</h2>
            <span>安全性高的密码可以使账号更安全，建议您定期更换密码，设置一个包含字母，符号或数字中至少两项且长度超过6位的密码。</span>
            <button class="btn btn-primary float_right" id="revisePassword">修改密码</button>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="../static/resource/jquery.js"></script> 
<script type="text/javascript">
/*<![CDATA[*/   
	//修改密码
    $("#revisePassword").on('click', function (e) {  
		window.location.href = "../subAcco/revisePassword.html";
    }); 
	 /*]]>*/
</script>
</html>
