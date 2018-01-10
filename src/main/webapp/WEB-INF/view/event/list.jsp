<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>事件查询_云英客服自助系统</title>
    <%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/event-query.css">
    <link rel="stylesheet" href="../static/css/progress.css">
</head>
<body>
<div class="first-page clearfix">
    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="事件查询"></jsp:param>
    </jsp:include>

    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="float_left w100 pd-T-45 boxS" style="height: 100%">
        <div style="height: auto">
            <div class="search-area" style="padding: 15px 60px 0 0;">
                <div class="clearfix">
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>事件编号：</label>
                            <input type="text" id="eventNo">
                        </div>
                    </div>
                    <div class="input-3-3 float_left chosen-zIndex">
                        <div class="form-group">
                            <label>业务系统：</label>
                        	<%--<div class="input-group">  --%>
	                            <select class="chosen-select" id="saleProductName" name="saleProductName"> 
	                            	<option value="">请选择</option>
									<c:forEach items="${custPro}" varStatus="i" var="item">
	                                	<option value="${item.saleProductName}" title="${item.saleProductName}">${item.saleProductCode}:${item.saleProductName}</option>
									</c:forEach> 
	                            </select>
                            <%--</div>--%>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>事件类型：</label>
                        	<%--<div class="input-group">  --%>
	                            <select class="chosen-select" id="type" name="type">
	                            	<option value="">请选择</option>
									<c:forEach items="${EVENT_TYPE}" varStatus="i" var="item">
	                                	<option value="${item.name}" title="${item.description}">${item.name}</option>
									</c:forEach>
	                            </select>
                            <%--</div>--%>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="position-re form-group">
                            <label >提交日期：</label>
                            <div class="input-hastimeIcon-selection"> 
								<input type="text"  class="form-control form-Date1" id="createTime" name="createTime">
                                <label for="createTime"><i class="icon iconfont icon-shurukuang-shijian- icon-time"></i></label>
                            </div>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>流程状态：</label>
                        	<%--<div class="input-group">  --%>
	                            <select class="chosen-select" id="flowStatus" name="flowStatus"> 
	                            	<option value="">请选择</option>
									<c:forEach items="${eventStatus}" varStatus="i" var="item">
	                                	<option value="${item.caption}" title="${item.caption}">${item.item}:${item.caption}</option>
									</c:forEach> 
	                            </select>
                            <%--</div>--%>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>关键词：</label>
                            <input type="text" id="key" name="key" placeholder="请输入事件标题或解决方案">
                        </div>
                    </div>
                </div>
                <div class="msearch-footer">
                    <button type="button" class="btn btn-primary mr6" onclick="search()">搜索</button>
                    <button type="button" class="btn btn-gray" onclick="reset()" >重置</button>
                </div>
            </div>
            <div id="grid" class="pd-lr-35">
                <table id="dataGrid">
                </table>
            </div>
        </div>
    </div>
</div>
<%--流程图弹出框--%>
<div class="event-state-model" style="display:none;padding-top: 50px;" >
    <div class="clearfix btn-collection" style="padding: 0;">
        <div class="progress clearfix">
            <ul class="progress-list clearfix" style="width: 90%;margin-left: 10%;">
                <li >
                    <p>新建</p>
                    <span></span>
                    <i></i>
                </li>
                <li>
                    <p>已分派</p>
                    <span></span>
                    <i></i>
                </li>
                <li>
                    <p>处理中</p>
                    <span></span>
                    <i></i>
                </li> 
                <li>
                    <p>关闭</p>
                    <span></span>
                    <i></i>
                </li>
            </ul>
        </div>
    </div>
</div>

<%--流程图弹出框结束--%>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/commonJs/datagrid.js"></script>
<!-- 下拉单选引入文件 -->
<script src="../static/js/plugins/chosen/chosen.jquery.min.js"></script>
<script src="../static/js/laydate.js"></script>
<!-- 表单校验插件 -->
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/jquery.validate.js"></script>
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/localization/messages_zh.js"></script>

<script type="text/javascript">
    /*<![CDATA[*/
    $(function(){

        $(".icon-time").click(function(){
            console.log(1);
            $(".form-Date1").trigger("click");
        })

        //下拉单选
        $('.chosen-select').chosen(
            {
                no_results_text: "没有找到结果！",//搜索无结果时显示的提示
                search_contains:true,   //关键字模糊搜索，设置为false，则只从开头开始匹配
            }
        );
        //双日历
        laydate.render({
            elem: '.form-Date1',
            range: true
        });
        
        var table={
            datagrid:function(){
                function scrollView(){
                    $(".datagrid-view2 .datagrid-body").bind('scroll',function(){
                        var _self=$(this);
                        var gv1=$(".datagrid-view1"),activeClass="datagrid-view-scroll";

                        _self.scrollLeft()>0?gv1.addClass(activeClass):gv1.removeClass(activeClass);
                    });

                    $(".data-table-loading").hide();
                }
	            function operate(value,rec){ 
	                var btn = '<i title="详情" class="icon iconfont icon-biaoge-caozuo-2" onClick="detail(this,1)" style="font-size:25px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
	            	if(value == "关闭"){
	            		btn = btn + '<i title="评价" class="icon iconfont icon-biaoge-caozuo-" onClick="appraise(this)" style="font-size:22px;color:#3399ff;cursor:pointer;"></i>';
		            } 
	                return btn;
	            }
	            function flowStatus(value,rec){ 	                
	            	var btn = '<span title="' + value + '" class="iconfont" onClick="flowStatus(this)" style="font-size:12px;color:#6699ff;cursor:pointer;text-decoration: underline">' + value + '</span>';
	            	return btn;
	            }
                var _that=this;
                //使用easyui grid控件
                var grid=$('#dataGrid').datagrid({
                    width:'auto',
                    height:'420px',
                    pagination:true,
                    loadMsg:"数据处理中...",
                    striped:true,
                    nowrap:false,
                    //remoteSort:false,
                    fitColumns:true,
                    pageSize:10,
                    url: '../event/load.json',//数据源，生产环境请替换
                    method: 'post',
                    onDblClickRow: function (rowIndex, rowData) {
                        detail(rowData,0);
                    },
                    onLoadSuccess: function(data){
                        fixedRow();
                        register();
                        title();
                    },
                    onLoadError:function(){
                        layer.msg('请求失败，请重试', { time: 1000 });
                    },
                    onBeforeLoad: function (param) {
                        $.extend(param, getSearchParams());
                    },
                    columns:[[
         				{field:'id',title:'事件id',hidden:true,align:'center',width:70,formatter:formatTitleTxt},
          				{field:'description',title:'事件描述',hidden:true,align:'center',width:70,formatter:formatTitleTxt},
                   		{field:'eventNo',title:'事件编号',align:'center',width:80,formatter:formatTitleTxt},
                        {field:'eventTitle',title:'事件标题',align:'center',width:80,formatter:formatTitleTxt},
                        {field:'solution',title:'解决方案',align:'center',width:100,formatter:formatTitleTxt},
                        {field:'saleProductName',title:'业务系统',align:'center',width:100,formatter:formatTitleTxt},
                        {field:'type',title:'事件类型',align:'center',width:50,formatter:formatTitleTxt},
                        {field:'submitterName',title:'提交人',align:'center',width:40,formatter:formatTitleTxt},
                        {field:'createTime',title:'提交日期',align:'center',width:90,formatter:formatTitleTxt},
                        {field:'flowStatus',title:'流程状态',align:'center',width:40,formatter:flowStatus}
                    ]],
	                frozenColumns:[[
   	                    {field:'flowStatus_operate',title:'操作',align:'left',width:80,formatter:operate}
   	                ]]
                });
                var pager =grid.datagrid('getPager');
                pager.pagination({
                    layout:['first','prev','manual','next','last','list'],
                    beforePageText: '第',
                    afterPageText: '页 共 {pages} 页',
                    displayMsg: '共{total}条数据'
                });
                window.grid= grid;

            }
        }
        table.datagrid();
    });

    //查询参数拼接
    function getSearchParams(){
		var params = {};
		params['eventNo'] = $("#eventNo").val();
		params['saleProductName'] = $("#saleProductName").val();
		params['type'] = $("#type").val();
		params['createTime'] = $("#createTime").val();
		params['flowStatus'] = $("#flowStatus").val();
		params['key'] = $("#key").val();
        return params;
    }

    //搜索
    function search(){
        $("#dataGrid").datagrid("load", "../event/load.json");
    }

    //重置
    function reset() { 
  		$("#eventNo").val(""); 
  		$("#createTime").val("");
  		$("#key").val(""); 
  		$("#saleProductName").val("");  
  		$("#type").val("");  
  		$("#flowStatus").val("");   
  		$(".chosen-single").find("span").html("请选择");
    }

    //详情
    function detail(rowData,num){
		var id;
		if(num == 0){
			id = rowData.id;
		} else {
			id = getRowData(rowData).id;
		}
        var detailUrl = "../event/detail.json?id=" + id;
 		window.open(detailUrl);
    }

	//服务评价
	function appraise(rowData){
 		var detailUrl = "../serviceAppraise/event.html?eventNo=" + getRowData(rowData).eventNo;
 		window.open(detailUrl);
	}
	
	//事件流程
	function flowStatus(rowData){
		var flowStatus = getRowData(rowData).flowStatus;
		this.showStateModel(flowStatus);
        layer.open({
            type: 1,
            title:'流程状态',
            content: $(".event-state-model"),
            area: ['45%', '200px'] //宽高
        });
	}
	function showStateModel(val){
//        var state = $('.index').val();节点状态
        $('.progress-list li').attr('style','width:20%')
        $(".progress-list").find("li").removeClass("active");
        $(".progress-list").find("li").removeClass("end");
        switch (val){
            case "新建":
                $(".progress-list").find("li").eq(0).addClass("end");
                break;
            case "已分派":
                $(".progress-list").find("li").eq(1).addClass("end");
                break;
            case "处理中":
                $(".progress-list").find("li").eq(2).addClass("end");
                break; 
            case "关闭":
                $(".progress-list").find("li").eq(3).addClass("end");
                break;
        }
        $(".end").prevAll("li").addClass("active");
    }

	//点击表格操作行按钮时获取该行数据
	function getRowData(node) {
		var index = $(node).parents('.datagrid-row').attr('datagrid-row-index');
		var td0 = $(node).parents('.datagrid-view').children('.datagrid-view0').find("tr").eq(parseInt(index) + 1).find('td');
		var td2 = $(node).parents('.datagrid-view').children('.datagrid-view2').find("tr").eq(parseInt(index) + 1).find('td');
		data = new Array();
		var n = {};
		td0.each(function(){
	        n[$(this).attr('field')] = $(this).find('span').text();
		})
		td2.each(function(){
	        n[$(this).attr('field')] = $(this).find('span').text();
		})
		return n;
	}

    /*]]>*/
</script>
</body>
</html>
