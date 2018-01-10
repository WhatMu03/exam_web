<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/9/18
  Time: 13:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/payment-account.css">
    <title>文章详情_云英客服自助系统</title>
</head>
<body>
<div class="first-register boxS">

    <%@ include file="../../static/component/header/header_black.jsp" %>
    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="payment-account">
                <div class="payment-account-introduce">
                    <h1>${result.title}</h1>
                    <span><i class="icon iconfont icon-wenzhangxiangqing-2"></i>${result.click}</span>
                    <span><i class="icon iconfont icon-wenzhangxiangqing-"></i>${result.createTime}</span>
                    <span> <i class="icon iconfont icon-wenzhangxiangqing-1"></i>系统管理员</span>
                </div>
                <p>${result.introduce}</p>
                <p>${result.content}</p>
                <p class="tc">你认为本文章有用吗？</p>
                <div class="comment-icon">
                    <div class="comment-margin-R">
		                <c:choose>
							<c:when test="${status eq '1' }"> 
		                        <a href="javascript:;" class="comment active goodCheck">
									<i class="icon iconfont icon-wenzhangxiangqing-zancai-" id = "good"></i>
		                        </a>
							</c:when>
							<c:otherwise>
		                        <a href="javascript:;" class="comment goodCheck">
									<i class="icon iconfont icon-wenzhangxiangqing-zancai-" id = "good"></i>
		                        </a>
							</c:otherwise>
						</c:choose> 
                        <span><i class="good">${result.good}</i>个赞</span>
                    </div>

                    <div>
		                <c:choose>
							<c:when test="${status eq '0' }"> 
		                        <a href="javascript:;" class="comment active badCheck">
                            		<i class="icon iconfont icon-wenzhangxiangqing-zancai-1" id = "bad"></i>
		                        </a>
							</c:when>
							<c:otherwise>
		                        <a href="javascript:;" class="comment badCheck">
                            		<i class="icon iconfont icon-wenzhangxiangqing-zancai-1" id = "bad"></i>
		                        </a>
							</c:otherwise>
						</c:choose>  
                        <span><i class="bad">${result.bad}</i>个踩</span>
                    </div> 
                </div>
                <div class="pre-next">
                    <ul class="clearfix">
                        <li class="float_left">
			                <c:choose>
								<c:when test="${empty before}">
	                        		没有更多了! 
								</c:when>
								<c:otherwise>
                        			<i class="icon iconfont icon-shangxiazuoyou-3"></i><a id="before">上一篇：${before.title}</a>
								</c:otherwise>
							</c:choose>
                        </li>
                        <li class="float_left tr">
			                <c:choose>
								<c:when test="${empty after}">
	                        		没有更多了! 
								</c:when>
								<c:otherwise>
	                        		<a id="after">下一篇：${after.title}</a><i class="icon iconfont icon-shangxiazuoyou-"></i>
								</c:otherwise>
							</c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>

<input id="id" type="hidden" value="${result.id}"/>
<input id="beforeId" type="hidden" value="${before.id}"/>
<input id="afterId" type="hidden" value="${after.id}"/>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript">
/*<![CDATA[*/
	function hasClass(element, cls) {
	    return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
	}
	
	//赞一个
    $("#good").on('click', function (e) { 
		$.ajax({
			type:"POST",
			url:'../help/good.json?id=' + $("#id").val(), 
			success:function(data){
				data = JSON.parse(data);
				if(data.result == '1'){ 
					if(hasClass(document.querySelector(".goodCheck"), 'active')){
						return;
					}else {
						$(".goodCheck").addClass('active');
						$(".good").html(parseInt($(".good").html()) + 1);
						if(hasClass(document.querySelector(".badCheck"), 'active')){
							$(".badCheck").removeClass('active');
							$(".bad").html(parseInt($(".bad").html()) - 1);
						}
					}
				}else{
                    layer.alert('点赞失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
				}
			},
			error:function(data){ 
                layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
			}
		});
    }); 
    
	//踩一个
    $("#bad").on('click', function (e) { 
		$.ajax({
			type:"POST",
			url:'../help/bad.json?id=' + $("#id").val(), 
			success:function(data){
				data = JSON.parse(data);
				if(data.result == '1'){ 
					if(hasClass(document.querySelector(".badCheck"), 'active')){
						return;
					}else {
						$(".badCheck").addClass('active');
						$(".bad").html(parseInt($(".bad").html()) + 1);
						if(hasClass(document.querySelector(".goodCheck"), 'active')){
							$(".goodCheck").removeClass('active');
							$(".good").html(parseInt($(".good").html()) - 1);
						}
					}
				}else{ 
                    layer.alert('点踩失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
				}
			},
			error:function(data){
                layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
			}
		});
    }); 
	
	//上一篇
    $("#before").on('click', function (e) { 
		var url = "../help/detail.json?id=" + $('#beforeId').val();  
		window.location.href = url;
    }); 

	//下一篇
    $("#after").on('click', function (e) { 
		var url = "../help/detail.json?id=" + $('#afterId').val();  
		window.location.href = url;
    });  
	 /*]]>*/
</script>
</html>
