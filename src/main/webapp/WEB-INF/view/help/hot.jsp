<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/help-center.css">
    <link rel="stylesheet" href="../static/css/module/pagination/page.css">
    <title>热点问题_帮助中心_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS help-all">

    <%@ include file="../../static/component/header/header_black.jsp" %>
    <div class="clearfix register-main boxS">
        <div class="help-center">
            <h2>帮助中心</h2>
            <ul>
                <li style="cursor:pointer" id="all"><i class="icon iconfont icon-bangzhuzhongxin-"></i>全部</li>
                <li style="cursor:pointer" id="new"><i class="icon iconfont icon-bangzhuzhongxin-1"></i>最新问题</li>
                <li class="current" style="cursor:pointer" id="hot"><i class="icon iconfont icon-bangzhuzhongxin-2"></i>热门问题</li>
                <li style="cursor:pointer" id="common"><i class="icon iconfont icon-bangzhuzhongxin-3"></i>常见问题</li>
            </ul>
        </div>
        <div class="float_left search-result">
            <div class="search-tip">
                <span>共为你找到<i>${count}</i>条相关结果</span>
                <div class="searchInput">
                    <input type="text" placeholder="请输入标题或简介内容" id="key" value="${key}">
                    <i class="icon iconfont icon-sousuo-" style="cursor:pointer;" onclick="search()"></i>
                </div>
            </div>
            <div class="search-details">
				<c:forEach items="${list}" varStatus="i" var="item">
	                <div class="required-solved hot-unscramble article" style="cursor:pointer">
	                	<input type="hidden" value="${item.id}" class="id"/>
	                    <div class="clearfix">
	                        <div class="float_left required-number">
	                            <span>${item.title}<i class="icon iconfont icon-bangzhuzhongxin-2"></i></span>
	                        </div>
	                        <div class="float_right required-dateup">
	                            <span>更新时间：<i>${item.createTime}</i></span>
	                        </div>
	                    </div>
	                    <p>${item.introduce}</p>
	                </div>
                </c:forEach> 
            </div>
            <%--分页--%> 
            <div class="clearfix btn-collection">
                <div>
                    <div class="pageJump">
                        <span>跳转到</span>
                        <input type="text" class="form-control"/>
                        <span>页</span>
                        <button type="button" class="button ">确定</button>
                    </div>
                    <ul class="pagination" id="page1">
                    </ul> 
                </div>
            </div> 
        </div>
    </div>
</div>
<input id="count" value="${count}" type="hidden"/>
<input id="page" value="${page}" type="hidden"/>
<script src="../static/js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<!-- 分页 -->
<script src="../static/js/page.js"></script>
<script>
/*<![CDATA[*/
    var url = "../help/hot.html";  
    /*]]>*/
</script> 
<script type="text/javascript" src="../static/commonJs/help.js"></script>
</body>
</html>
