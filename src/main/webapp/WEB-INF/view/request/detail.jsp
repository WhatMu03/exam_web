<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<link rel="stylesheet" href="../static/css/event-details.css">
	<link rel="stylesheet" href="../static/css/progress.css">
	<title>需求详情_云英客服自助系统</title>
</head>
<div class="first-register boxS">

	<%@ include file="../../static/component/header/header_black.jsp" %>

	<div class="register-main register-main-pd boxS">
		<div class="register-tip boxS">
			<div class="event-number clearfix"> 
				<img class="icon-xiangqingyetubiao-2" src="../static/images/xiangqingyetubiao2.png">
				<div>
					<div class="position-number">
						<span>需求编号&nbsp;${result.requestNo}</span>
						<i class="dispatched"> 
			                <c:choose>
								<c:when test="${result.publishStatus eq '已发放' or (result.publishStatus eq '' and result.reqStatus eq '已回复')}">
									已解决
								</c:when>
								<c:otherwise>
									未解决
								</c:otherwise>
							</c:choose>
						</i>
					</div>
					<p>客户名称：${result.customerName}</p>
				</div>
				<div class="float_right mt10">
	                <c:choose>
						<c:when test="${result.publishStatus eq '已发放' or (result.publishStatus eq '' and result.reqStatus eq '已回复')}">
							<button type="button" class="btn btn-primary" id="appraise"> 
				                <c:if test="${flag eq false}">评价</c:if>
				                <c:if test="${flag eq true}">再次评价</c:if>
			                </button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-disabled"  disabled="disabled" id="appraise">评价</button>
						</c:otherwise>
					</c:choose>
					<span class="line"></span>
	                <c:choose>
						<c:when test="${empty before}">
							<button type="button" class="btn btn-disabled mr4" disbled="disabled">上一条</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-gray mr4" id="before">上一条</button>
						</c:otherwise>
					</c:choose>
	                <c:choose>
						<c:when test="${empty after}">
							<button type="button" class="btn btn-disabled" disbled="disabled">下一条</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-gray" id="after">下一条</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="event-particulars">
				<div style="padding: 0 20px;width: 100%;box-sizing: border-box;">
					<div class="children-detail-show">
						<div class="input-3-3">
							<label>产品名称：</label><span>${result.saleProductName}</span>
						</div>
						<div class="input-3-3">
							<label>创建时间：</label><span>${result.createTime}</span>
						</div>
						<div class="input-3-3">
							<label>受理结果：</label><span>${result.dealResultName}</span>
						</div>
						<div class="input-3-3">
							<label>承诺发放日期：</label><span>${result.promiseDate}</span>
						</div>
						<div class="input-3-3">
							<label>承诺发放版本：</label><span>${result.promiseVerName}</span>
						</div>
						<div class="input-3-3">
							<label>发布发放状态：</label><span>${result.publishStatus}</span>
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
						<div class="w100">
							<label>需求描述：</label><span><pre>${result.description}</pre></span>
						</div>
						<div class="w100">
							<label>需求处理意见：</label><span><pre>${result.dealDesc}</pre></span>
						</div>

					</div>
					<div class="dispatched-status" style="height: auto;padding: 15px 0;width: 100%;margin-top: 0;">
						<div class="w100">
							<span>
					                <c:choose>
										<c:when test="${result.publishStatus eq ''}">
											<jsp:include page="../../static/component/status/requestStatus.jsp">
												<jsp:param name="reqStatus" value="${result.reqStatus}"></jsp:param>
											</jsp:include>
										</c:when>
										<c:otherwise>
											<jsp:include page="../../static/component/status/requestStatus.jsp">
												<jsp:param name="reqStatus" value="${result.publishStatus}"></jsp:param>
											</jsp:include> 
										</c:otherwise>
									</c:choose>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
	<input type="hidden" id="id" value="${result.id}"/>
	<input type="hidden" id="beforeId" value="${before.id}"/>
	<input type="hidden" id="afterId" value="${after.id}"/>
	<input type="hidden" id="requestNo" value="${result.requestNo}"/>
	<input type="hidden" id="messageNo" name="messageNo" value="${messageNo}"/>
</div>
<body>

<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript">
/*<![CDATA[*/   

	//上一条	
    $("#before").on('click', function (e) { 
		var url = "../request/detail.json?id=" + $('#beforeId').val();  
		window.location.href = url;
    }); 

	//下一条	
    $("#after").on('click', function (e) { 
		var url = "../request/detail.json?id=" + $('#afterId').val();  
		window.location.href = url;
    }); 

	//服务评价
    $("#appraise").on('click', function (e) {   
 		var detailUrl = "../serviceAppraise/request.html?requestNo=" + $("#requestNo").val();
 		window.open(detailUrl);
    });  
	 
	 /*]]>*/
</script>
 
</body> 