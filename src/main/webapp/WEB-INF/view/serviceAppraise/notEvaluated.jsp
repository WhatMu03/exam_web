<%--
  Created by IntelliJ IDEA.
  User: altynai
  Date: 2017/9/19
  Time: 9:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/remain-evaluated.css">
    <link rel="stylesheet" href="../static/css/module/pagination/page.css">
    <title>未评价_云英客服自助系统</title>
</head>
<body>
<div class="first-page">

    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="待评价"></jsp:param>
    </jsp:include>

    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="w100 position-P boxS">

        <div class="remain-evaluated-Padding boxS">
            <div class="overFloW-scr">
                <c:forEach items="${list}" varStatus="i" var="item">
                    <div class="evaluate" style="overflow: initial;">
                        <div class="evaluate-number">
                            <em>${item.appraiseObj}编号<span
                                    class="appraiseObjNo">${item.appraiseObjNo}</span><span>${item.createTime}</span></em>
                        </div>
                        <div class="displayF">
                            <div class="evaluate-detail">
                                <p>${item.description}</p>
                            </div>
                            <div class="evaluate-btn">
                                <div>
                                    <button class="btn btn-primary appraise">评价</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <%--分页--%>
            <div class="clearfix btn-collection">
                <div>
                    <div class="pageJump" style="min-width:200px">
                        <span>跳转到</span>
                        <input type="Number" class="form-control" id="pageNumber" style="min-width:50px"/>
                        <span>页</span>
                        <button type="button" class="button ">确定</button>
                    </div>
                    <ul class="pagination" id="page1">
                    </ul>
                    <div class="float_right search-result">共为你找到${count}条相关结果</div>
                </div>
            </div>
        </div>
    </div>
    <input id="count" value="${count}" type="hidden"/>
    <input id="page" value="${page}" type="hidden"/>
    <script src="../static/js/jquery/jquery-3.2.1.min.js"></script>
    <!-- 分页 -->
    <script src="../static/js/page.js"></script>
    <script>
        $(function () {
            //  分页start
            Page({
                num: Math.ceil($("#count").val() / 10),//页码数
                startnum: $("#page").val(),				//指定页码
                elem: $('#page1'),		//指定的元素
                callback: function (n) {	//回调函数
                    window.location.href = "../serviceAppraise/notEvaluated.html?page=" + n;
                }
            });
            // 分页end
            
            $('#pageNumber').on('keydown', function(event){
		    	if(event.keyCode == 13) {
		    		var val = $(this).val(), number = 1,
		    			maxPage = Math.ceil($("#count").val()/10);
		    		
		    		if(val <= 0) {
		    			number = 1
		    		} else if(val > maxPage) {
		    			number = maxPage
		    		} else {
		    			number = val
		    		}
		    		window.location.href = "../serviceAppraise/notEvaluated.html?page=" + number;
		    	}
		    	
		    })
        })

        //评价
        $(".appraise").click(function () {
            var node = $(this).parent().parent().parent().prev().find(".appraiseObjNo");
            var appraiseObjNo = $(node).html();

            var detailUrl;
            var bool = appraiseObjNo.indexOf("SJ");
            if (bool >= 0) {
                detailUrl = "../serviceAppraise/event.html?eventNo=" + appraiseObjNo;
            } else {
                detailUrl = "../serviceAppraise/request.html?requestNo=" + appraiseObjNo;
            }
            window.open(detailUrl);
        })
    </script>
</body>
</html>
