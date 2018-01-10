<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>教师查询_在线考试平台</title>
    <%@ include file="../../static/component/common/public.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="../static/css/first-page.css">
    <link rel="stylesheet" href="../static/css/event-query.css">
    <link rel="stylesheet" href="../static/css/progress.css">
</head>
<body>
<div class="first-page clearfix">
    <jsp:include page="../../static/component/nav/nav.jsp">
        <jsp:param name="index" value="教师查询"></jsp:param>
    </jsp:include>

    <%@ include file="../../static/component/header/header.jsp" %>
    <div class="float_left w100 pd-T-45 boxS" style="height: 100%">
        <div style="height: auto">
            <div class="search-area" style="padding: 15px 60px 0 0;">
                <div class="clearfix">
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>工号：</label>
                            <input type="text" id="code">
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>姓名：</label>
                            <input type="text" id="name">
                        </div>
                    </div>
                    <div class="input-3-3 float_left">
                        <div class="form-group">
                            <label>性别：</label>
	                            <select class="chosen-select" id="sex" name="sex">
	                            	<option value="">请选择</option>
									<c:forEach items="${sex}" varStatus="i" var="item">
	                                	<option value="${item.caption}" title="${item.caption}">${item.item}:${item.caption}</option>
									</c:forEach> 
	                            </select>
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
	                var btn = '<i title="编辑" class="icon iconfont icon-biaoge-caozuo-2" onClick="edit(this,1)" style="font-size:25px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
	            		btn = btn + '<i title="删除" class="icon iconfont icon-biaoge-caozuo-" onClick="delete(this)" style="font-size:22px;color:#3399ff;cursor:pointer;"></i>';
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
                    fitColumns:true,
                    pageSize:10,
                    url: '../teacher/load.json',//数据源，生产环境请替换
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
                    columns:[[
         				{field:'code',title:'工号',hidden:true,align:'center',width:70,formatter:formatTitleTxt},
          				{field:'name',title:'姓名',hidden:true,align:'center',width:70,formatter:formatTitleTxt},
                   		{field:'sex',title:'性别',align:'center',width:80,formatter:formatTitleTxt}
                    ]],
	                frozenColumns:[[
   	                    {field:'operate',title:'操作',align:'left',width:80,formatter:operate}
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

    //搜索
    function search(){
        $("#dataGrid").datagrid("load", "../teacher/load.json");
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


    /*]]>*/
</script>
</body>
</html>
