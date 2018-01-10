<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/module/calendar.css">    <!-- 日历 -->
    <%@ include file="../../static/component/common/public.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>主页_云英客服自助系统</title>
</head>
<body class="page-background">
<div class="first-page">


    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="首页"></jsp:param>
    </jsp:include>


    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="main-right w100 boxS">

        <div class="pd15 clearfix page-message boxS">
            <div class="float_left at-issue boxS">
                <div class="issue-tab">
                    <ul class="tab-page clearfix to-be-solved">
                        <li class="float_left current-tab" data-type="1" style="cursor:pointer">待解决需求<i
                                class="red-circle">${request}</i></li>
                        <li class="float_left has-rightBorder" data-type="2" style="cursor:pointer">待解决事件<i
                                class="gray-circle">${event}</i></li>
                    </ul>
                    <!-- <button type="button" class="btn btn-primary new-add" onclick="insert()"><i class="icon iconfont icon-xinzengshijian- mr6"></i>新建事件</button> -->
                </div>

                <%--待解决需求--%>
                <div class="tab-div solved-1">
                    <c:choose>
                        <c:when test="${request == 0}">
                            <div style="text-align: center;margin-top: 30%">
                                <img src="../static/images/no-message.png">
                                <h1 style="color: #666666;margin: 20px 0;font-size: 20px;">亲，您暂时没有待解决需求！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listRequest}" varStatus="i" var="item">
                                <div class="required-solved pd-t0 request" style="cursor:pointer">
                                    <div class="clearfix">
                                        <div class="float_left required-number">
                                            <span>需求编号：<em class="requestNo">${item.requestNo}</em></span>
                                            <i class="dispatched">${item.reqStatus}</i>
                                            <input type="hidden" class="id" value="${item.id}"/>
                                        </div>
                                        <div class="float_right required-dateup">
                                            <span>更新时间：<i>${item.updateTime}</i></span>
                                        </div>
                                    </div>
                                    <p>${item.description}</p>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%--待解决事件--%>
                <div class="tab-div solved-2" style="display: none;">
                    <c:choose>
                        <c:when test="${event == 0}">
                            <div style="text-align: center;margin-top: 30%">
                                <img src="../static/images/no-message.png">
                                <h1 style="color: #666666;margin: 20px 0;font-size: 20px;">亲，您暂时没有待解决事件！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listEvent}" varStatus="i" var="item">
                                <div class="required-solved pd-t0 event" style="cursor:pointer">
                                    <div class="clearfix">
                                        <div class="float_left required-number">
                                            <span>事件编号：<em class="eventNo">${item.eventNo}</em></span>
                                            <i class="dispatched">${item.flowStatus}</i>
                                            <input type="hidden" class="id" value="${item.id}"/>
                                        </div>
                                        <div class="float_right required-dateup">
                                            <span>更新时间：<i>${item.updateTime}</i></span>
                                        </div>
                                    </div>
                                    <p>${item.description}</p>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <div class="float_right retroaction-message">
                <div>
                    <ul class="tab-page clearfix message-type">
                        <li class="float_left current-tab" data-type="1" style="cursor:pointer">全部未读消息<i>${all}</i></li>
                        <li class="float_left has-rightBorder" data-type="2" style="cursor:pointer">
                            需求反馈<i>${requestBack}</i></li>
                        <li class="float_left" data-type="3" style="cursor:pointer">事件反馈<i>${eventBack}</i></li>
                        <li class="float_left has-rightBorder" data-type="4" style="cursor:pointer">系统消息<i>${system}</i>
                        </li>
                    </ul>
                </div>

                <%--全部未读消息--%>
                <div class="show-message tab-1">
                    <c:choose>
                        <c:when test="${all == 0}">
                            <div style="text-align: center">
                                <img src="../static/images/no-message.png" style="width: 140px;height: auto;">
                                <h1 style="color: #666666">亲，您暂时没有未读消息！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listAll}" varStatus="i" var="item">
                                <div class="clearfix unread-message pd-t">
                                    <div class="float_left unread-icon">
                                        <c:choose>
                                            <c:when test="${item.obj == '需求'}">
                                                <i class="icon iconfont icon-shouye-xiaoxileitubiao-"></i>
                                            </c:when>
                                            <c:when test="${item.obj == '事件'}">
                                                <i class="icon iconfont icon-shouye-xiaoxileitubiao-2"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="icon iconfont icon-shouye-xiaoxileitubiao-1"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="float_left feedback">
                                        <span>${item.obj}反馈</span>
                                        <p>贵公司所提出的${item.objNo}状态已更新，<span class="detail"
                                                                           style="cursor:pointer;text-decoration: underline">点击此处查看详情</span>。
                                        </p>
                                        <input class="messageNo" value="${item.messageNo}" type="hidden"/>
                                    </div>
                                    <div class="position-Ab">
                                        <span class="feedback-time">${item.senderTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%--需求反馈--%>
                <div class="show-message tab-2" style="display: none;">

                    <c:choose>
                        <c:when test="${requestBack == 0}">
                            <div style="text-align: center">
                                <img src="../static/images/no-message.png" style="width: 140px;height: auto;">
                                <h1 style="color: #666666">亲，您暂时没有需求反馈消息！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listRequestBack}" varStatus="i" var="item">
                                <div class="clearfix unread-message pd-t">
                                    <div class="float_left unread-icon">
                                        <i class="icon iconfont icon-shouye-xiaoxileitubiao-"></i>
                                    </div>
                                    <div class="float_left feedback">
                                        <span>${item.obj}反馈</span>
                                        <p>贵公司所提出的${item.objNo}状态已更新，<span class="detail"
                                                                           style="cursor:pointer;text-decoration: underline">点击此处查看详情</span>。
                                        </p>
                                        <input class="messageNo" value="${item.messageNo}" type="hidden"/>
                                    </div>
                                    <div class="position-Ab">
                                        <span class="feedback-time">${item.senderTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%--事件反馈--%>
                <div class="show-message tab-3" style="display: none;">
                    <c:choose>
                        <c:when test="${eventBack == 0}">
                            <div style="text-align: center">
                                <img src="../static/images/no-message.png" style="width: 140px;height: auto;">
                                <h1 style="color: #666666">亲，您暂时没有事件反馈消息！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listEventBack}" varStatus="i" var="item">
                                <div class="clearfix unread-message pd-t">
                                    <div class="float_left unread-icon">
                                        <i class="icon iconfont icon-shouye-xiaoxileitubiao-2"></i>
                                    </div>
                                    <div class="float_left feedback">
                                        <span>${item.obj}反馈</span>
                                        <p>贵公司所提出的${item.objNo}状态已更新，<span class="detail"
                                                                           style="cursor:pointer;text-decoration: underline">点击此处查看详情</span>。
                                        </p>
                                        <input class="messageNo" value="${item.messageNo}" type="hidden"/>
                                    </div>
                                    <div class="position-Ab">
                                        <span class="feedback-time">${item.senderTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </div>

                <%--系统消息--%>
                <div class="show-message tab-4" style="display: none;">
                    <c:choose>
                        <c:when test="${system == 0}">
                            <div style="text-align: center">
                                <img src="../static/images/no-message.png" style="width: 140px;height: auto;">
                                <h1 style="color: #666666">亲，您暂时没有系统反馈消息！</h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listSystem}" varStatus="i" var="item">
                                <div class="clearfix unread-message pd-t">
                                    <div class="float_left unread-icon">
                                        <i class="icon iconfont icon-shouye-xiaoxileitubiao-1"></i>
                                    </div>
                                    <div class="float_left feedback">
                                        <span>${item.obj}反馈</span>
                                        <p>贵公司所提出的${item.objNo}状态已更新，<span class="detail"
                                                                           style="cursor:pointer;text-decoration: underline">点击此处查看详情</span>。
                                        </p>
                                        <input class="messageNo" value="${item.messageNo}" type="hidden"/>
                                    </div>
                                    <div class="position-Ab">
                                        <span class="feedback-time">${item.senderTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </div>

                <!-- 首页日历 -->
                <div class="div2" style="margin-top:20px">
                </div>
            </div>
        </div>
    </div>

</div>

<div class="jsonArr" style="display:none">${jsonArr}</div>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script src="../static/js/calendar.js"></script><!-- 日历 -->
<script language="javascript">
    $(function () {
        MessageTab();
        ToSolved();
    });

    var jsonArr = {}
    try {
        jsonArr = JSON.parse($(".jsonArr").html());
    } catch (error) {
        jsonArr = {}
    }

    //新增事件
    function insert() {
        layer.alert('暂不开放此功能', {icon:2,'title':'提示'});
        /* 		window.location.href = "../event/insert.html"; */
    }

    //跳转到详情
    $(".detail").click(function () {
        var node = $(this).parent().parent().find(".messageNo");
        var detailUrl = "../stationMessage/detail.json?messageNo=" + $(node).val();
        window.open(detailUrl);
    })

    //跳转到事件详情
    $(".event").click(function () {
        var node = $(this).find(".id");
        var detailUrl = "../event/detail.json?id=" + $(node).val();
        window.open(detailUrl);
    })

    //跳转到需求详情
    $(".request").click(function () {
        var node = $(this).find(".id");
        var detailUrl = "../request/detail.json?id=" + $(node).val();
        window.open(detailUrl);
    })

    function MessageTab() {
        $(".message-type").find("li").map(function () {
            $(this).click(function () {
                $(this).siblings().removeClass("current-tab");
                $(this).addClass("current-tab");
                var type = $(this).attr("data-type");
                $(".show-message").hide();
                $(".tab-" + type).show();
            });
        })
    }

    function ToSolved() {
        $(".to-be-solved").find("li").map(function () {
            $(this).click(function () {
                $(this).siblings().removeClass("current-tab");
                $(this).addClass("current-tab");
                var type = $(this).attr("data-type");
                $(".tab-div").hide();
                $(".solved-" + type).show();
            });
        })
    }

    // 日历
    var cale = new calender({
        'parent': $('.div2'),
        'width': "100%",
        'data': jsonArr,
        curDate: false,
        callback: function (event, start) {
            var eveSpan = $(event.target).find('span'),
                eventno = eveSpan.data('eventno'),
                eventtitle = eveSpan.data('eventtitle');

            if (eventno || start) {
                var template = $('<div class="dataFixed"></div>'),
                    $ul = $("<ul></ul>");
                if (start) {
                    $('<li><a onclick="insert()">+ 添加事件</a></li>').appendTo($ul)
                } else {
                    var i = 0,
                        title = eventtitle.split(','),
                        noId = eventno.split(',');
                    for (; i < title.length; i++) {
                        $('<li><a onclick="rlDetail(\'' + noId[i] + '\')">' + title[i] + '</a></li>').appendTo($ul)
                    }
                }

                $ul.appendTo(template)
                template.appendTo($(event.target))
            }
        }
    })

    cale.on("prevDate", function (_this) {
        changeData(_this);
    })

    cale.on("nextDate", function (_this) {
        changeData(_this);
    })

    //改变日历数据 
    function changeData(_this) {
        $.ajax({
            type: "POST",
            url: "../home/nextMonth.json?month=" + (_this.Month + 1) + "&year=" + _this.Year,
            success: function (data) {
                data = JSON.parse(data);
                if (data.result == '1') {
                    var jsonArr = data.jsonArr;
                    _this.bindRander({'data': jsonArr})
                } else {
                    layer.alert('获取数据失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
                }
            },
            error: function (data) {
                layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
            }
        });
    }

    //日历跳转事件
    function rlDetail(eventNo) {
        window.open('../event/detail.json?eventNo=' + eventNo);
    }
</script>
</body>
</html> 