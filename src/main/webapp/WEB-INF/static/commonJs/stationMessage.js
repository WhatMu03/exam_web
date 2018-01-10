/*<![CDATA[*/
$(function () {
    var height = $(window).height() - $(".feedback-tool").outerHeight();
    $(".remain-evaluated-Padding").height(height);

    //切换
    $(".look-details").find("li").map(function () {
        $(this).click(function () {
            $(this).siblings().removeClass("current-choice");
            $(this).addClass("current-choice");
            onLoadStyle() === '全部' ? allMessage() : noRead();
        });
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
                var btn = '<i title="查看" class="icon iconfont icon-biaoge-caozuo-2" onClick="detail(this,1)" style="font-size:25px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
                if (rec.status == '0') {
                    btn = btn + '<i title="设为已读" class="icon iconfont icon-biaoge-caozuo-3" onClick="setRead(this)" style="font-size:22px;color:#3399ff;cursor:pointer;margin-right: 8px"></i>';
                }
                btn = btn + '<i title="删除" class="icon iconfont icon-biaoge-caozuo-1" onClick="del(this)" style="font-size:22px;color:#3399ff;cursor:pointer;"></i>';
                return btn;
            }

            var _that = this;
            //使用easyui grid控件
            var grid = $('#dataGrid').datagrid({
                width: 'auto',
                height: '420px',
                pagination: true,
                loadMsg: "数据处理中...",
                striped: true,
                nowrap: false,
                remoteSort: false,
                fitColumns: false,
                pageSize: 10,
                url: '../stationMessage/load.json',//数据源，生产环境请替换
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
                    {field: 'ck', checkbox: true, width: 20, align: 'center'},
                    {
                        field: 'messageNo',
                        title: '短信编号',
                        width: 100,
                        hidden: true,
                        align: 'center',
                        formatter: formatTitleTxt
                    },
                    {field: 'theme', title: '主题', width: 300, align: 'center', formatter: formatTitleTxt},
                    {field: 'senderTime', title: '时间', width: 150, align: 'center', formatter: formatTitleTxt},
                    {
                        field: 'status',
                        title: '是否已读',
                        width: 150,
                        align: 'center',
                        formatter: formatTitleTxt,
                        hidden: true
                    }
                ]],
                frozenColumns: [[
                    {field: 'operate', title: '操作', width: 110, align: 'left', formatter: operate}
                ]]
            });
            var pager = grid.datagrid('getPager');
            pager.pagination({
                beforePageText: '第',
                afterPageText: '页 共 {pages} 页',
                displayMsg: '共{total}条数据'
            });
            window.grid = grid;
        }
    }
    table.datagrid();
    onLoadStyle();
});

//Tab-全部-数据刷新
function allMessage() {
    $("#dataGrid").datagrid("load", "../stationMessage/load.json");
    getCount();
}

//Tab-未读-数据刷新
function noRead() {
    $("#dataGrid").datagrid("load", "../stationMessage/load.json?status=0");
    getCount();
}

//表格样式reload
function onLoadStyle() {
    var obj = $('.current-choice');
    var value = obj.html().trim().substring(0, 2);
    if (value === '全部'){
        if ($('#all').text() === '0') {
            $('#noMessage').css('display', 'flex');
            $('#grid').css('display', 'none');
        } else {
            $('#noMessage').css('display', 'none');
            $('#grid').css('display', 'block');
        }
    }
    if (value === '未读'){
        if ($('#noRead').text() === '0') {
            $('#noMessage').css('display', 'flex');
            $('#grid').css('display', 'none');
        } else {
            $('#noMessage').css('display', 'none');
            $('#grid').css('display', 'block');
        }
    }
    return value;
}

//改变当前按钮上面的数量
function getCount() {
    $.ajax({
        type: "POST",
        url: "../stationMessage/getCount.json",
        data: getSearchParams(),
        success: function (data) {
            data = JSON.parse(data);
            if (data.result == '1') {
                $('#all').text(data.all);
                $('#noRead').text(data.noRead);
            } else {
                layer.alert(data.message, {'title': '提示', icon: 2});
            }
        },
        error: function (data) {
            layer.alert('系统异常，请重新操作', {'title': '警告', icon: 2});
        }
    });

}

//设为已读
function setRead(rowData) {
    var messageNo = getRowData(rowData).messageNo;
    commonSetRead(messageNo);
}

//批量设为已读
function batchSetRead() {
    var rows = $('#dataGrid').datagrid('getSelections');
    var messageNos = [];
    if (rows.length == 0) {
        layer.alert("请勾选记录!", {'title': '提示', icon: 2});
        return;
    } else {
        for (var i = 0; i < rows.length; i++) {
            messageNos.push(rows[i]['messageNo']);
        }
    }
    commonSetRead(messageNos);
}

// 根据当前选中的tab来刷新数据
function refresh() {
    onLoadStyle() === '全部' ? allMessage() : noRead();
}

//设为已读(批量设为已读)走后台
function commonSetRead(messageNo) {
    $.ajax({
        type: "POST",
        url: "../stationMessage/setRead.json?messageNo=" + messageNo,
        data: getSearchParams(),
        success: function (data) {
            data = JSON.parse(data);
            if (data.result == '1') {
                layer.alert("设置成功!", {icon: 1, 'title': '提示'});
                refresh();//刷新
            } else {
                layer.alert('设置失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
            }
        },
        error: function (data) {
            layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
        }
    });
}

//删除
function del(rowData) {
    var messageNo = getRowData(rowData).messageNo;
    $("#message").html("确定要删除吗？");
    top.layer.open({
        fix: false,
        offset: 'auto',
        type: 1,
        title: '提示',
        moveOut: false,
        skin: 'layui-layer-ta',
        area: ['400px', 'auto'],
        btn: ["确定", "取消"],
        btn1: function () {
            layer.closeAll();
            commonDel(messageNo);
        },
        btn2: function () {
            layer.closeAll();
        },
        content: $("#confirm")
    });
}

//批量删除
function batchDel() {
    var rows = $('#dataGrid').datagrid('getSelections');
    var messageNos = [];
    if (rows.length == 0) {
        layer.alert("请勾选记录!", {'title': '提示', icon: 2});
        return;
    } else {
        for (var i = 0; i < rows.length; i++) {
            messageNos.push(rows[i]['messageNo']);
        }
    }
    $("#message").html("确定要删除吗？");
    top.layer.open({
        fix: false,
        offset: 'auto',
        type: 1,
        title: '提示',
        moveOut: false,
        skin: 'layui-layer-ta',
        area: ['400px', 'auto'],
        btn: ["确定", "取消"],
        btn1: function () {
            layer.closeAll();
            commonDel(messageNos);
        },
        btn2: function () {
            layer.closeAll();
        },
        content: $("#confirm")
    });
}

//删除(批量删除)走后台
function commonDel(messageNo) {
    $.ajax({
        type: "POST",
        url: "../stationMessage/delete.json?messageNo=" + messageNo,
        data: getSearchParams(),
        success: function (data) {
            data = JSON.parse(data);
            if (data.result == '1') {
                layer.alert("删除成功!<br/>", {icon: 1, 'title': '提示'});
                refresh();//刷新
            } else {
                layer.alert('删除失败!<br/>' + data.message, {icon: 2, 'title': '提示'});
            }
        },
        error: function (data) {
            layer.alert('系统异常，请重新操作', {icon: 2, 'title': '警告'});
        }
    });
}

//详情
function detail(rowData, num) {
    var messageNo;
    if (num == 0) {
        messageNo = rowData.messageNo;
    } else {
        messageNo = getRowData(rowData).messageNo;
    }
    var detailUrl = "../stationMessage/detail.json?messageNo=" + messageNo;
    window.open(detailUrl);
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


/*]]>*/