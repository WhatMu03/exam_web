<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/event-feedback.css">
    <title>系统反馈_站内短信_云英客服自助系统</title>
</head>
<body>
<div class="first-page">
    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="系统消息"></jsp:param>
    </jsp:include>
    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="w100">
        <div class="feedback-tool">
            <div class="clearfix">
                <div class="float_left">
                    <ul class="look-details">
                        <li class="float_left border-style-1 current-choice" style="cursor:pointer">全部（<span
                                id="all">${all}</span>）
                        </li>
                        <li class="float_left border-style-2 border-l-none" style="cursor:pointer">未读（<span
                                id="noRead">${noRead}</span>）
                        </li>
                    </ul>
                </div>
                <div class="float_right">
                    <button class="btn btn-primary mr4" onclick="batchDel()">批量删除</button>
                    <button class="btn btn-gray" onclick="batchSetRead()">批量设置为已读</button>
                </div>
            </div>
        </div>
        <!--dataGrid-->
        <div id="grid" class="pd-lr-35">
            <table id="dataGrid">
            </table>
        </div>
        <div class="remain-evaluated-Padding boxS" style="display: none;" id="noMessage">
            <div class="tc" style="margin: auto;">
                <img src="../static/images/no-message.png">
                <h1 style="color: #666666;margin: 20px 0;font-size: 20px;">亲，您暂时没有未读消息！</h1>
            </div>
        </div>
    </div>

    <!-- confirm -->
    <div id="confirm" class="modal-body boxS clearfix" style="width:400px; padding: 25px 0 0 37px; display:none">
        <div class="w20 modal-icon float_left">
            <img src="../static/images/tu-3.png" style="width:100%; ">
        </div>
        <div class="w80 modal-main float_left boxS">
            <p id="message" style="padding:25px 0 0 10px">共选中5条数据，是否确认批量删除？</p>
        </div>
    </div>
    <script type="text/javascript" src="../static/resource/jquery.js"></script>
    <script type="text/javascript" src='../static/resource/layer/layer.js'></script>
    <script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/plugins/jquery.panel.js"></script>
    <script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../static/commonJs/datagrid.js"></script>
    <script type="text/javascript" src='../static/resource/layer/layer.js'></script>
    <script type="text/javascript">
        //查询参数拼接
        function getSearchParams() {
            var params = {};
            params['obj'] = "系统";
            return params;
        }

        /*]]>*/
    </script>
    <script type="text/javascript" src="../static/commonJs/stationMessage.js"></script>
</body>