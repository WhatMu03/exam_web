<%--
  Created by IntelliJ IDEA.
  User: sunyt
  Date: 2017/8/17
  Time: 9:25
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/event-details.css">
    <link rel="stylesheet" href="../static/css/progress.css">
    <title>事件详情_云英客服自助系统</title>
</head>
<body>

<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main register-main-pd boxS">
        <div class="register-tip boxS">
            <div class="event-number clearfix"> 
                <img class="icon-xiangqingyetubiao-2" style="height: 58px;" src="../static/images/xiangqingyetubiao.png">
                <div>
                    <div class="position-number">
                        <span>事件编号&nbsp;${result.eventNo}</span>
                        <i class="dispatched">
                            <c:choose>
                                <c:when test="${result.flowStatus eq '关闭'}">
                                    已解决
                                </c:when>
                                <c:otherwise>
                                    未解决
                                </c:otherwise>
                            </c:choose>
                        </i>
                    </div>
                    <p>事件标题：${result.eventTitle}</p>
                </div>
                <div class="float_right mt10">
                    <c:choose>
                        <c:when test="${result.flowStatus eq '关闭'}">
                            <button type="button" class="btn btn-primary" id="appraise">
                                <c:if test="${flag eq false}">评价</c:if>
                                <c:if test="${flag eq true}">再次评价</c:if>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-disabled">评价</button>
                        </c:otherwise>
                    </c:choose>
                    <span class="line"></span>
                    <c:choose>
                        <c:when test="${empty before}">
                            <button type="button" class="btn btn-disabled mr4" disbled>上一条</button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-gray mr4" id="before">上一条</button>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${empty after}">
                            <button type="button" class="btn btn-disabled" disbled>下一条</button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-gray" id="after">下一条</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="event-particulars">
                <div class="children-detail-show">
                    <div class="input-3-3">
                        <label>事件类型：</label><span>${result.type}</span>
                    </div>
                    <div class="input-3-3">
                        <label>业务系统：</label><span>${result.saleProductName}</span>
                    </div>
                    <div class="input-3-3">
                        <label>版本号：</label><span>${result.version}</span>
                    </div>
                    <div class="input-3-3">
                        <label>提交时间：</label><span>${result.createTime}</span>
                    </div>
                    <div class="input-3-3">
                        <label>解决时间：</label><span>${result.dCloseDatetime}</span>
                    </div>
                    <div class="input-3-3">
                        <label>提交人：</label><span>${result.submitterName}</span>
                    </div>
                    <div class="input-3-3">
                        <label>联系电话：</label><span>${result.mobile}</span>
                    </div>
                    <div class="input-3-3">
                        <label>邮箱：</label><span>${result.email}</span>
                    </div>
                    <div class="input-3-3">
                        <label>客户名称：</label><span>${result.customerName}</span>
                    </div>
                    <div class="input-3-3">
                        <label>解决时限：</label><span>${result.dresolvingLimitDatetime}</span>
                    </div>
                    <div class="w100">
                        <label>事件描述：</label><span><pre>${result.description}</pre></span>
                    </div>
                    <div class="w100">
                        <label>解决方案：</label><span><pre>${result.solution}</pre></span>
                    </div>
                </div>
                <div class="dispatched-status" style="margin-left: 51px;padding-bottom: 40px;">
                    <div class="input-3-8">

                        <jsp:include page="../../static/component/status/eventStatus.jsp">
                            <jsp:param name="flowStatus" value="${result.flowStatus}"></jsp:param>
                        </jsp:include>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="id" value="${result.id}"/>
<input type="hidden" id="beforeId" value="${before.id}"/>
<input type="hidden" id="afterId" value="${after.id}"/>
<input type="hidden" id="messageNo" value="${messageNo}"/>
<input type="hidden" id="eventNo" value="${result.eventNo}"/>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
    /*<![CDATA[*/ 

    //上一条
    $("#before").on('click', function (e) {
        var url = "../event/detail.json?id=" + $('#beforeId').val();
        window.location.href = url;
    });

    //下一条
    $("#after").on('click', function (e) {
        var url = "../event/detail.json?id=" + $('#afterId').val();
        window.location.href = url;
    });

    //服务评价
    $("#appraise").on('click', function (e) {
        var detailUrl = "../serviceAppraise/event.html?eventNo=" + $("#eventNo").val();
        window.open(detailUrl);
    });

    /*]]>*/
</script>
</body>
</html>
