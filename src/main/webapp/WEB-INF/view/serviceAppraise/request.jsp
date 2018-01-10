<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../../static/component/common/public.jsp" %>
    <link rel="stylesheet" href="../static/css/user-evaluate.css">
    <title>需求评价_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS request">

    <%@ include file="../../static/component/header/header_black.jsp" %>

    <div class="register-main register-main-pd boxS">
        <div class="register-tip boxS">
            <div class="event-number">
                <!--  <i class="icon iconfont icon-xiangqingyetubiao-3"></i> -->
                <img class="icon-xiangqingyetubiao-3" src="../static/images/xiangqingyetubiao3.png">
                <div class="position-number">
                    <span>需求编号 ${result.requestNo}</span>
                    <div class="clearfix">
                        <label class="float_left">需求描述：</label>
                        <span class="float_left limit-width">${result.description}</span>
                    </div>
                    <label>需求处理意见：<span>${result.dealDesc}</span></label>
                </div>
                <div class="mt10">
                    <a class="read-details" onclick="detail()">查看详情</a>
                </div>
            </div>
            <div class="edit-evaluated">
                <div class="client-evaluate mb15">
                    <label>总分</label>
                    <div class="evaluate-level" id="grade">
                        <input type="hidden" value="" id="gradeVal">
                        <i class="icon iconfont icon-dafen-2" data-grade="1"></i>
                        <i class="icon iconfont icon-dafen-2" data-grade="2"></i>
                        <i class="icon iconfont icon-dafen-2" data-grade="3"></i>
                        <i class="icon iconfont icon-dafen-2" data-grade="4"></i>
                        <i class="icon iconfont icon-dafen-2" data-grade="5"></i>
                    </div>
                    <span class="gradeCont"></span>
                </div>
                <textarea id='suggest' maxlength="4000" cols="150" rows="10" style="width:100%"
                          placeholder="万分感谢您给我们提出宝贵意见..."></textarea>
                <div class="wordNum-guide" style="float: right"><span class="word">0</span>/4000</div>
                <div class="evaluate-name">
                    <button class="btn btn-primary" id="insert">发表评价</button>
                    <label>评价人姓名：<span>${loginName}</span></label>
                </div>
            </div>

        </div>
    </div>
</div>
<input id="requestNo" type="hidden" value="${result.requestNo}"/>
<input id="id" type="hidden" value="${result.id}"/>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<!-- 表单校验插件 -->
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/jquery.validate.js"></script>
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/localization/messages_zh.js"></script>
<script type="text/javascript">
    /*<![CDATA[*/
    $(function () {
        $('#suggest').keyup(function () {
            var len = $(this).val().length
            if (len > 4000) {
                $(this).val($(this).val().substring(0, 4000));
                $('.word').text(4000);
            } else {
                $('.word').text(len);
            }
        })
        // 评分 
        var gradeCont = ['非常不满意', '不满意', '一般', '满意', '非常满意']
        $('#grade').on('mousemove', '> i.icon', function (event) {
            var grade = $(this).data('grade')
            $(this).prevAll().attr('class', 'icon iconfont icon-dafen-1 active')
            $(this).attr('class', 'icon iconfont icon-dafen-1 active').nextAll().attr('class', 'icon iconfont icon-dafen-2')
            $('.gradeCont').text(grade + '分 — ' + gradeCont[grade - 1])
            $('#gradeVal').val(grade)
        })

    })

    //查询参数拼接
    function getParams() {
        var params = {};
        params['appraiseObj'] = '需求';
        params['appraiseObjNo'] = $("#requestNo").val();
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
                    window.location.href = "../serviceAppraise/appraiseSuccess.html?type=request";
                } else if (data.result == '0') {
                    window.location.href = "../serviceAppraise/appraiseFail.html?type=request&requestNo=" + $("#requestNo").val();//失败
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
        var detailUrl = "../request/detail.json?id=" + id;
        window.open(detailUrl);
    }

    // 表单校验
    $(".validate").validate({
        rules: {
            text: "required",
            password: {
                required: true,
                minlength: 6
            },
            email: {
                required: true,
                email: true
            },
        },
        messages: {
            text: "这是必填字段",
            password: {
                required: "这是必填字段",
                minlength: "密码长度不能小于 6 个字母"
            },
            email: "请输入一个正确的邮箱"
        }
    });

    /*]]>*/
</script>

</body> 