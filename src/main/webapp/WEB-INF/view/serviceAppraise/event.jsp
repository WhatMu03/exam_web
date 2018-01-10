<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/user-evaluate.css">
    <title>事件评价_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %> 
    <div class="register-main register-main-pd boxS">
        <div class="register-tip boxS">
            <div class="event-number">
                <img class="icon-xiangqingyetubiao-3" src="../static/images/xiangqingyetubiao3.png">
                <div class="position-number">
                    <span>事件编号 ${result.eventNo}</span>
                    <div class="clearfix">
                        <label class="float_left">事件描述：</label>
                        <span class="float_left limit-width">${result.description}</span>
                    </div>
                    <label>解决方案：<span>${result.solution}</span></label>
                </div>
                <div class="mt10">
                    <a class="read-details" onclick="detail()">查看详情</a>
                </div>
            </div>
            <div class="edit-evaluated">
                <div class="clearfix mb15">
                    <div class="client-evaluate">
                        <label>总分</label>
                        <div class="evaluate-level" id="grade">
                            <input type="hidden" id="gradeVal" value="">
                            <i class="icon iconfont icon-dafen-2" data-grade="1"></i>
                            <i class="icon iconfont icon-dafen-2" data-grade="2"></i>
                            <i class="icon iconfont icon-dafen-2" data-grade="3"></i>
                            <i class="icon iconfont icon-dafen-2" data-grade="4"></i>
                            <i class="icon iconfont icon-dafen-2" data-grade="5"></i>
                        </div>
                        <span class="gradeCont"></span>
                    </div>
                </div>
                <%--评价--%>
                <textarea id='suggest'  maxlength="4000" style="width: 100%;height: 200px;" placeholder="万分感谢您给我们提出宝贵意见..."></textarea>
                <div class="wordNum-guide" style="float: right"><span class="word">0</span>/4000</div>
                <div class="evaluate-name">
                    <button class="btn btn-primary" id="insert">发表评价</button>
                    <label>评价人姓名：<span>${loginName}</span></label>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="eventNo" type="hidden" value="${result.eventNo}"/>
<input id="id" type="hidden" value="${result.id}"/>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript">
    /*<![CDATA[*/
    $(function () {
        $('#suggest').keyup(function () {
            var len = $(this).val().length
            if (len > 4000){
                $(this).val($(this).val().substring(0,4000));
                $('.word').text(4000);
            } else {
            }$('.word').text(len);
        })
    })
    //查询参数拼接
    function getParams() {
        var params = {};
        params['appraiseObj'] = '事件';
        params['appraiseObjNo'] = $("#eventNo").val();
        params['score'] = $("#gradeVal").val();
        params['suggest'] = $("#suggest").val();
        return params;
    }

    //插入
    $("#insert").on('click', function (e) { 
        $.ajax({
            type: "POST",
            url: "../serviceAppraise/insert.json",
            data: getParams(),
            success: function (data) {
                data = JSON.parse(data);
                if (data.result == '1') {
                    window.location.href = "../serviceAppraise/appraiseSuccess.html?type=event";//成功
                } else if (data.result == '0') { 
                    window.location.href = "../serviceAppraise/appraiseFail.html?type=event&eventNo="+$("#eventNo").val();//失败
                } else { 
                    layer.alert('评价失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
                }
            },
            error: function (data) {
                layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
            }
        });
    });

    //详情
    function detail() {
        var id = $("#id").val();
        var detailUrl = "../event/detail.json?id=" + id;
        window.open(detailUrl);
    }

    // 评分
    var gradeCont = ['非常不满意', '不满意', '一般', '满意', '非常满意']
    $('#grade').on('mousemove', '> i.icon', function (event) {
        var grade = $(this).data('grade')
        $(this).prevAll().attr('class', 'icon iconfont icon-dafen-1 active')
        $(this).attr('class', 'icon iconfont icon-dafen-1 active').nextAll().attr('class', 'icon iconfont icon-dafen-2')
        $('.gradeCont').text(grade + '分 — ' + gradeCont[grade - 1])
        $('#gradeVal').val(grade)
    })

    /*]]>*/
</script>

</body> 