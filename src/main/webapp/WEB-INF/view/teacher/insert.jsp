<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/event-query.css">
    <link rel="stylesheet" href="../static/css/build-event.css">
    <%@ include file="../../static/component/common/public.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>新增事件_云英客服自助系统</title>
</head>
<body>
<div class="first-page clearfix">

    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="新建事件"></jsp:param>
    </jsp:include>
    <div class="float_left">
        <%@ include file="../../static/component/header/header.jsp" %>
        <div class="build-event">
                <div class="search-area clearfix">
                    <div class="clearfix">
                        <div class="show-w100 float_left form-group">
                            <label for="eventTitle"><font class="need-red">*</font>事件标题：</label>
                            <input type="text" id="eventTitle" name="eventTitle" class="form-control">
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>客户名称：</label>
                                <input type="text" value="${customerName}" id="customerName" disabled="disabled">
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>客户编号：</label>
                                <input type="text" value="${customerNo}" id="customerNo" disabled="disabled">
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>提交人：</label>
                                <input type="text" value="${loginName}" id="loginName" disabled="disabled">
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>联系电话：</label>
                                <input type="text" value="${mobile}" id="mobile" disabled="disabled">
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>邮箱：</label>
                                <input type="text" value="${email}" id="email" disabled="disabled">
                            </div>
                        </div>
                        <div class="input-3-3 float_left set-zIndex">
                            <div class="form-group">
                                <label><font class="need-red">*</font>业务系统：</label>
                                <select class="chosen-select" id="saleProductName" name="saleProductName">
                                    <option value="">请选择</option>
                                    <c:forEach items="${custPro}" varStatus="i" var="item">
                                        <option value="${item.saleProductName}"
                                                title="${item.saleProductName}">${item.saleProductCode}:${item.saleProductName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label><font class="need-red">*</font>事件类型：</label>
                                <select class="chosen-select" id="type" name="type">
                                    <option value="">请选择</option>
                                    <c:forEach items="${EVENT_TYPE}" varStatus="i" var="item">
                                        <option value="${item.name}" title="${item.description}">${item.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="position-re form-group">
                                <label><font class="need-red">*</font>发生时间：</label>
                                <div class="input-hastimeIcon">
                                    <input type="text" id="occurDateTime" class="input time"/>
                                    <i class="icon iconfont icon-shurukuang-shijian- icon-time"></i>
                                </div>
                            </div>
                        </div>
                        <div class="input-3-3 float_left">
                            <div class="form-group">
                                <label>受理人：</label>
                                <select class="chosen-select" id="dealingUserName" name="dealingUserName">
                                    <option value="">请选择</option>
                                    <c:forEach items="${dealingUser}" varStatus="i" var="item">
                                        <option value="${item.dealingUserNo}"
                                                title="${item.dealingUserNo}">${item.dealingUserNo}:${item.dealingUserName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="show-w100 float_left form-group edit-mT">
                        <label><font class="need-red">*</font>事件描述：</label>
                        <div class="clearfix edit-width">
                            <textarea id="description" style="width: 100%;height: 200px;"></textarea>
                        </div>
                    </div>
                </div>

                <div class="search-footer">
                    <button type="button" class="btn btn-primary mr4" onclick="insert()">提交</button>
                    <button class="btn btn-gray" onclick="reset()">重置</button>
                </div>
        </div>

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
<%--弹窗--%>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<%--日期--%>
<script src="../static/js/laydate.js"></script>
<!-- 下拉单选引入文件 -->
<script src="../static/js/plugins/chosen/chosen.jquery.min.js"></script>

<script>
    /*<![CDATA[*/
    $(function () {
        // 单日历
        laydate.render({
            elem: '#occurDateTime'
        });
        //下拉单选
        $('.chosen-select').chosen({
            no_results_text: "没有找到结果！",//搜索无结果时显示的提示
            search_contains:true,   //关键字模糊搜索，设置为false，则只从开头开始匹配
            }
        );
    })

    //参数拼接
    function getInsertParams() {
        var params = {};
        params['eventTitle'] = $("#eventTitle").val();
        params['customerNo'] = $("#customerNo").val();
        params['mobile'] = $("#mobile").val();
        params['email'] = $("#email").val();
        params['saleProductName'] = $("#saleProductName").val();
        params['type'] = $("#type").val();
        params['occurDateTime'] = $("#occurDateTime").val();
        params['dealingUserName'] = $("#dealingUserName").val();
        params['description'] = $("#description").val();
        return params;
    }

    //重置
    function reset() {
        $("#eventTitle").val("");
        $("#occurDateTime").val("");
        $("#dealingUserName").val("");
        $("#saleProductName").val("");
        $("#type").val("");
        $("#description").val("");
        $(".chosen-single").find("span").html("请选择");
    }

    function validate() {
        var errorInfo= [];
        var state = true;
        if ($("#eventTitle").val() == "") {
            errorInfo.push("事件标题不能为空！") ;
            state = false;
        }
        if ($("#occurDateTime").val() == "") {
            errorInfo.push("发生时间不能为空！") ;
            state = false;
        }
        if ($("#saleProductName").val() == "") {
            errorInfo.push("业务系统不能为空！");
            state = false;
        }
        if ($("#type").val() == "") {
            errorInfo.push("事件类型不能为空！");
            state = false;
        }
         if ($("#description").val() == "") {
            errorInfo.push("事件描述不能为空！");
            state = false;
        }
        if (state){
            return errorInfo;
            return true;
        } else {
            return errorInfo;
            return false;
        }
    }

    //新增事件
    function insert() {

	   	 $("#message").html("确定提交吗？"); 
    		top.layer.open({
	        fix: false,
	        offset: 'auto',
	        type: 1,
	        title: '提示', 
	        moveOut: false,
	        skin: 'layui-layer-ta',
	        area: ['400px', 'auto'],
	        btn:["确定","取消"],
	        btn1:function(){
	        	layer.closeAll(); 
	            var errorList = validate();
	            if (errorList.length === 0){
	                layer.close(index);
	                //加载 当前窗口锁定
	                var loading = layer.load(0, {scrollbar: false});
	                $.ajax({
	                    type: 'POST',
	                    url: '../event/insert.json',
	                    data: getInsertParams(),
	                    success: function (data) {
	                        layer.close(loading);//关闭加载层
	                        data = JSON.parse(data);
	                        if (data.result == '1') {
	                            window.location.href = "../event/insertSuccess.html"
	                        } else {
	                            window.location.href = "../event/insertFail.html?msg=" + data.message
	                        }
	                    },
	                    error: function (data) {
	                        layer.close(loading);//关闭加载层
	                        layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
	                    }
	                })
	            } else {
	                var temp = "";
	                for(t in errorList){
	                    temp = temp + errorList[t] + "<br/>"
	                }
	                layer.alert('请规范填写'+'<br/>'+temp, {icon: 2, 'title': '提示'});
	            }
	        },
	        btn2:function(){
	        	layer.closeAll();
	        },
	        content: $("#confirm") 
	    }); 
    	
    }

    /*]]>*/
</script>
</body>
</html>
