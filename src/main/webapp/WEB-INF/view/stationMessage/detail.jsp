<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/event-updateRemind.css">
    <title>短信详情_云英客服自助系统</title>
</head>
<body>

<div class="first-register boxS"> 
    <%@ include file="../../static/component/header/header_black.jsp" %> 
    <div class="register-main pd15 boxS">
        <div class="register-tip boxS">
            <div class="event-number clearfix"> 
                <img class="icon-xiangqingyetubiao-1" src="../static/images/xiangqingyetubiao1.png">
                <div class="position-number">
                    <span>${result.obj}编号${result.objNo}的更新提醒</span>
                    <div class="set-label"> <label>发件人：</label><span>系统管理员</span></div>
                    <div class="set-label"><label>时间：</label><span>${result.senderTime}</span></div>
                    <div class="set-label"><label>收件人：</label><span>${result.loginName}</span></div>
                </div>
                <div class="float_right mt10"> 
	                <c:choose>
						<c:when test="${empty before}">
							<button type="button" class="btn btn-gray mr4" disbled>上一条</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-gray mr4" id="before">上一条</button>
						</c:otherwise>
					</c:choose>
	                <c:choose>
						<c:when test="${empty after}">
							<button type="button" class="btn btn-gray" disbled>下一条</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-gray" id="after">下一条</button>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
            <div class="event-particulars">
                <div>
                    <h3>尊敬的用户，您好！</h3>
                    <p>贵司所提的${result.obj}状态已更新，编号为：${result.objNo}，内容为：${result.content}。</p>
                    <p class="set-padding">感谢您的支持！</p>
                    <p class="set-padding"><a href="#" onclick="objDetail()">点击此处查看详情</a></p>
                </div>
                <div class="send-name">
                    <span>系统管理员</span>
                    <span>${result.senderTime}</span>
                </div>
            </div>
        </div>
    </div>
</div>
<input type='hidden' name='obj' id='obj' text='${result.obj}' value='${result.obj}'/>
<input type='hidden' name='objNo' id='objNo' text='${result.objNo}' value='${result.objNo}' />
<input type="hidden" id="beforeId" value="${before.messageNo}"/>
<input type="hidden" id="afterId" value="${after.messageNo}"/>
<input type='hidden' name='messageNo' id='messageNo' text='${result.messageNo}' value='${result.messageNo}' />

<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
    /*<![CDATA[*/
    function objDetail() {
        var url;
        if ($('#obj').val() == '需求') {
            url = "../request/detail.json?requestNo=" + $('#objNo').val() + "&messageNo=" + $('#messageNo').val();
        } else {
            url = "../event/detail.json?eventNo=" + $('#objNo').val() + "&messageNo=" + $('#messageNo').val();
        }
        window.location.href = url;
    }

	//上一条	
    $("#before").on('click', function (e) { 
		var url = "../stationMessage/detail.json?messageNo=" + $('#beforeId').val();  
		window.location.href = url;
    }); 

	//下一条	
    $("#after").on('click', function (e) { 
		var url = "../stationMessage/detail.json?messageNo=" + $('#afterId').val();  
		window.location.href = url;
    }); 
    /*]]>*/
</script>

</body> 