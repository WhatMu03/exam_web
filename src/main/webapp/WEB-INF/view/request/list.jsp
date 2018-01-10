<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="../../static/component/common/public.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/event-query.css">
    <link rel="stylesheet" href="../static/css/progress.css">
    <title>我的需求_云英客服自助系统</title>
</head>
<body>
<div class="first-page clearfix">

    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="需求查询"></jsp:param>
    </jsp:include>

    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="float_left w100">
        <div>
            <div class="search-area">
                <div class="clearfix">
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>需求编号：</label>
                            <input type="text" id="requestNo" name="requestNo">
                        </div>
                    </div>
                    <%-- 					<div class="input-3-3 float_left">
                                            <div class="form-group">
                                                <label>业务系统：</label>
                                                <select class="chosen-select" id="saleProductName" name="saleProductName">
                                                    <option value="">请选择</option>
                                                    <c:forEach items="${custPro}" varStatus="i" var="item">
                                                        <option value="${item.saleProductName}" title="${item.saleProductName}">${item.saleProductCode}:${item.saleProductName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div> --%>
                    <div class="input-3-3 float_left">
                        <div class="position-re form-group">
                            <label class="">提交时间：</label>
                            <div class="input-hastimeIcon-selection">
                                <input type="text" class="form-control form-Date1" id="createTime" name="createTime">
                                <label for="createTime"><i class="icon iconfont icon-shurukuang-shijian- icon-time"></i></label>
                            </div>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>流程状态：</label>
                            <%--<div class="input-group">  --%>
                            <select class="chosen-select" id="reqStatus" name="reqStatus">
                                <option value="">请选择</option>
                                <c:forEach items="${requestStatus}" varStatus="i" var="item">
                                    <option value="${item.caption}"
                                            title="${item.caption}">${item.item}:${item.caption}</option>
                                </c:forEach>
                            </select>
                            <%--</div>--%>
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>关键词：</label>
                            <input type="text" id="key" name="key" placeholder="请输入需求描述或产品名称">
                        </div>
                    </div>
                </div>
                <div class="msearch-footer">
                    <button type="button" class="btn btn-primary mr6" onclick="search()">搜索</button>
                    <button type="button" class="btn btn-gray" onclick="reset()">重置</button>
                </div>
            </div>
        </div>
        <!--dataGrid-->
        <div id="grid" class="pd-lr-35">
            <table id="dataGrid">
            </table>
        </div>
    </div>

</div>
<%--此处是流程图弹框--%>
<div class="reqState-model" style="display: none;padding: 20px 0;">
    <div class="clearfix btn-collection">
        <div class="progress clearfix">
            <ul class="progress-list clearfix">
                <li>
                    <p>新增</p>
                    <span></span>
                    <i></i>
                </li>
                <li>
                    <p>已处理</p>
                    <span></span>
                    <i></i>
                </li>
                <li>
                    <p>已审核</p>
                    <span></span>
                    <i></i>

                </li>
                <li>
                    <p>已回复</p>
                    <span></span>
                    <i></i>
                </li>
                <li>
                    <p>待发布</p>
                    <span></span>
                    <i></i>

                </li>
                <li>
                    <p>待发放</p>
                    <span></span>
                    <i></i>

                </li>
                <li>
                    <p>已发放</p>
                    <span></span>
                    <i></i>
                </li>
            </ul>
        </div>
        <div class="progress-branch clearfix progress-true mt60">

            <ul class="progress-list clearfix">
                <li>
                    <span></span>
                    <i></i>
                    <p>已转出</p>
                    <div class="start-true "></div>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>待处理</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>已处理</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>已审核</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>已回复</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>设计中</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>开发中</p>
                </li>
                <li>
                    <span></span>
                    <i></i>
                    <p>待测试</p>
                    <div class="end-true"></div>
                </li>
            </ul>

        </div>
    </div>
</div>
<%--流程图弹框结束--%>
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/commonJs/datagrid.js"></script>
<!-- 下拉单选引入文件 -->
<script src="../static/js/plugins/chosen/chosen.jquery.min.js"></script>
<!-- 日期 -->
<script src="../static/js/laydate.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript">

    /*<![CDATA[*/
    $(function () {
        //下拉单选
        $('.chosen-select').chosen({
            no_results_text: "没有找到结果！",//搜索无结果时显示的提示
            search_contains: true   //关键字模糊搜索，设置为false，则只从开头开始匹配
        });
        //双日历
        laydate.render({
            elem: '.form-Date1',
            range: true
        });
        var table = {
            datagrid: function () {
                function scrollView() {
                    $(".datagrid-view2 .datagrid-body").bind('scroll', function () {
                        var _self = $(this);
                        var gv1 = $(".datagrid-view1"), activeClass = "datagrid-view-scroll";

                        _self.scrollLeft() > 0 ? gv1.addClass(activeClass) : gv1.removeClass(activeClass);
                    });

                    $(".data-table-loading").hide();
                }

                function operate(value, rec) {
                    var btn = '<i title="详情" class="icon iconfont icon-biaoge-caozuo-2" onClick="detail(this,1)" style="font-size:25px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
                    if (rec.publishStatus == "已发放" || (rec.publishStatus == "" && rec.reqStatus == "已回复")) {
                        btn = btn + '<i title="评价" class="icon iconfont icon-biaoge-caozuo-" onClick="appraise(this)" style="font-size:22px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
                    }
                    if (rec.important == '0') {
                        btn = btn + '<i title="设为重要" class="icon iconfont icon-zhiding-" onclick="setOrCancelTop(this)"  style="font-size:25px;color:#3399ff;cursor:pointer;"></i>'
                    } else {
                        btn = btn + '<i title="取消重要" class="icon iconfont icon-quxiaozhiding-" onclick="setOrCancelTop(this)"  style="font-size:25px;color:#3399ff;cursor:pointer;"></i>'
                    }
                    return btn;
                }

                function reqStatus(value, rec) {
                	if(rec.publishStatus != ""){
                		value = rec.publishStatus;
                	}
                    var btn = '<span title="' + value + '" class="iconfont" onClick="reqStatus(this)" style="font-size:12px;color:#6699ff;cursor:pointer;text-decoration: underline">' + value + '</span>';
                    return btn;
                }

                function description(value, rec) { 
                	//value = value.replace(/'/g, '').replace(/"/g, '');
                	//value =  Server.HtmlEncode(value);
                    return '<span title="' + value + '">' + value + '</span>';
                }
                
                //使用easyui grid控件
                var grid = $('#dataGrid').datagrid({
                    width: 'auto',
                    height: '420px',
                    pagination: true,
                    loadMsg: "数据处理中...",
                    striped: true,
                    nowrap: false,
                    //remoteSort:false,
                    fitColumns: true,
                    pageSize: 10,
                    url: '../request/load.json',//数据源，生产环境请替换
                    method: 'post',
                    onDblClickRow: function (rowIndex, rowData) {
                        detail(rowData, 0);
                    },
                    onLoadSuccess: function () {
                        fixedRow();
                        register();
                        title();
                    },
                    onLoadError: function () {
                        layer.msg('请求失败，请重试', {time: 1000});
                    },
                    onBeforeLoad: function (param) {
                        $.extend(param, getSearchParams());
                    },
                    columns: [[
                        {field: 'id',title: '需求id',width: 100,hidden: true,align: 'center',formatter: formatTitleTxt},
                        {field: 'requestNo', title: '需求编号', width: 70, align: 'center', formatter: formatTitleTxt},
                        {field: 'description', title: '需求描述', width: 100, align: 'center', formatter: description}, 
                        {field: 'saleProductName',title: '产品名称',width: 100,align: 'center',formatter: formatTitleTxt},
                        {field: 'createTime', title: '提交日期', width: 90, align: 'center', formatter: formatTitleTxt},
                        {field: 'promiseDate', title: '承诺日期', width: 90, align: 'center', formatter: formatTitleTxt},
                        {field: 'publishVer', title: '升级版本', width: 60, align: 'center', formatter: formatTitleTxt},
                        {field: 'reqStatus', title: '流程状态', width: 40, align: 'center', formatter: reqStatus},
                        {field: 'important',title: '是否重要',width: 40,align: 'center',hidden: true,formatter: formatTitleTxt},
                        {field: 'publishStatus',title: '发布发放状态',width: 40,align: 'center',hidden: true,formatter: formatTitleTxt}
                    ]],
                    frozenColumns: [[
                        {field: 'reqStatus_operate', title: '操作', width: 120, align: 'left', formatter: operate}
                    ]],
                    rowStyler: function (index, row) {
                        if (row.important == '1') {
                            return 'background: #dde8ef !important;';
                        }
                    }
                });
                var pager = grid.datagrid('getPager');
                pager.pagination({
                    layout: ['first', 'prev', 'manual', 'next', 'last', 'list'],
                    beforePageText: '第',
                    afterPageText: '页 共 {pages} 页',
                    displayMsg: '共{total}条数据'
                });
                window.grid = grid;

            }
        }
        table.datagrid();
    });

    //查询参数拼接
    function getSearchParams() {
        var params = {};
        params['requestNo'] = $("#requestNo").val();
        params['saleProductName'] = $("#saleProductName").val();
        params['createTime'] = $("#createTime").val();
        params['reqStatus'] = $("#reqStatus").val();
        params['key'] = $("#key").val();
        return params;
    }

    //查询
    function search() {
        $("#dataGrid").datagrid("load", "../request/load.json");
    }

    //重置
    function reset() {
        $("#requestNo").val("");
        $("#createTime").val("");
        $("#key").val("");
        $("#saleProductName").val("");
        $("#reqStatus").val("");
        $(".chosen-single").find("span").html("请选择");
    }

    //详情
    function detail(rowData, num) {
        var id;
        if (num == 0) {
            id = rowData.id;
        } else {
            id = getRowData(rowData).id;
        }
        var detailUrl = "../request/detail.json?id=" + id;
        window.open(detailUrl);
    }

    //置顶or取消置顶
    function setOrCancelTop(obj) {
        var obj = getRowData(obj);
        $.ajax({
            type: 'POST',
            url: "../request/setOrCancelTop.json",
            data: {
                requestNo: obj.requestNo,
                important: obj.important
            },
            success: function (res, state) {
                res = JSON.parse(res);//置顶成功，重新查询
                if (res.result == '1') {
                    search();
                }
            },
            error: function (res) {
                layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
            }
        })
    }

    //服务评价
    function appraise(rowData) {
        var detailUrl = "../serviceAppraise/request.html?requestNo=" + getRowData(rowData).requestNo;
        window.open(detailUrl);
    }

    //需求流程
    function reqStatus(rowData) {
        var reqStatus = getRowData(rowData).reqStatus;
        this.showStateModel(reqStatus);
        layer.open({
            type: 1,
            content: $(".reqState-model"),
            title: '流程状态',
            area: ['65%', '250px'] //宽高
        });
    }

    //点击表格操作行按钮时获取该行数据
    function getRowData(node) {
        var index = $(node).parents('.datagrid-row').attr('datagrid-row-index');
        var td0 = $(node).parents('.datagrid-view').children('.datagrid-view0').find("tr").eq(parseInt(index) + 1).find('td');
        var td2 = $(node).parents('.datagrid-view').children('.datagrid-view2').find("tr").eq(parseInt(index) + 1).find('td');
        data = new Array();
        var n = {};
        td0.each(function () {
            n[$(this).attr('field')] = $(this).find('span').text();
        })
        td2.each(function () {
            n[$(this).attr('field')] = $(this).find('span').text();
        })
        return n;
    }

    function showStateModel(state) {
        $(".progress-list").find("li").removeClass("active");
        $(".progress-list").find("li").removeClass("end");
        switch (state) {
            case "新增":
                $(".progress-list").find("li").eq(0).addClass("end");
                break;
            case "已处理":
                $(".progress-list").find("li").eq(0).addClass("active");
                $(".progress-list").find("li").eq(1).addClass("end");
                $(".progress-list").find("li").eq(7).addClass("active");
                $(".progress-list").find("li").eq(8).addClass("active");
                $(".progress-list").find("li").eq(9).addClass("end");
                break;
            case "已审核":
                $(".progress-list").find("li").eq(0).addClass("active");
                $(".progress-list").find("li").eq(1).addClass("active");
                $(".progress-list").find("li").eq(2).addClass("end");
                $(".progress-list").find("li").eq(7).addClass("active");
                $(".progress-list").find("li").eq(8).addClass("active");
                $(".progress-list").find("li").eq(9).addClass("active");
                $(".progress-list").find("li").eq(10).addClass("end");
                break;
            case "已回复":
                $(".progress-list").find("li").eq(3).addClass("end");
                $(".progress-list").find("li").eq(7).addClass("active");
                $(".progress-list").find("li").eq(8).addClass("active");
                $(".progress-list").find("li").eq(9).addClass("active");
                $(".progress-list").find("li").eq(10).addClass("active");
                $(".progress-list").find("li").eq(11).addClass("end");
                $(".end").prevAll("li").addClass("active");
                break;
            case "待发布":
                $(".progress-list").find("li").eq(4).addClass("end");//这里存在问题
                $(".end").prevAll("li").addClass("active");
                $(".progress-list").find("li").eq(6).nextAll().addClass("active");
                break;
            case "待发放":
                $(".progress-list").find("li").eq(5).addClass("end");
                $(".end").prevAll("li").addClass("active");
                $(".progress-list").find("li").eq(6).nextAll().addClass("active");
                break;
            case "已发放":
                $(".progress-list").find("li").eq(6).addClass("end");
                $(".progress-list").find("li").eq(6).siblings().addClass("active");
                break;
            case "已转出":
                $(".progress-list").find("li").eq(0).addClass("end");
                $(".progress-list").find("li").eq(7).addClass("end");
                break;
            case "待处理":
                $(".progress-list").find("li").eq(0).addClass("active");
                $(".progress-list").find("li").eq(7).addClass("active");
                $(".progress-list").find("li").eq(8).addClass("end");
                break;
            case "设计中":
                $(".progress-list").find("li").eq(3).prevAll().addClass("active");
                $(".progress-list").find("li").eq(3).addClass("end");
                $(".progress-list").find("li").eq(6).nextAll().addClass("active");
                $(".progress-list").find("li").eq(12).addClass("end");
                $(".progress-list").find("li").eq(13).removeClass("active");
                $(".progress-list").find("li").eq(14).removeClass("active");
                break;
            case "开发中":
                $(".progress-list").find("li").eq(3).prevAll().addClass("active");
                $(".progress-list").find("li").eq(3).addClass("end");
                $(".progress-list").find("li").eq(6).nextAll().addClass("active");
                $(".progress-list").find("li").eq(14).removeClass("active");
                break;
            case "待测试":
                $(".progress-list").find("li").eq(3).prevAll().addClass("active");
                $(".progress-list").find("li").eq(3).addClass("end");
                $(".progress-list").find("li").eq(7).nextAll().addClass("active");
                break;
        }
    }

    /*]]>*/
</script>

</body>
