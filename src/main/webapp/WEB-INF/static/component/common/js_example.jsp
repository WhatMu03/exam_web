<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/9/20
  js 组件引入 以及初始化
--%>
<!-- datagrid表格引入 -->
<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script type="text/javascript" src='../static/resource/layer/layer.js'></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="../static/resource/jquery-easyui/1_4_3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../static/commonJs/datagrid.js"></script>
<!-- 下拉单选引入文件 -->
<script src="../static/js/plugins/chosen/chosen.jquery.min.js"></script>
<!-- 下拉多选引入文件 -->
<script src="../static/js/plugins/bootcss/3_3_7/js/bootstrap.min.js"></script>
<script src="../static/js/plugins/jquery-ui/1.12.1/jquery-ui.min.js"></script>
<script src="../static/js/plugins/multiselect/jquery.multiselect.js"></script>
<script src="../static/js/plugins/multiselect/jquery.multiselect.filter.min.js"></script>
<!-- 表单校验插件 -->
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/jquery.validate.js"></script>
<script src="../static/js/plugins/jquery-validation-1.17.0/dist/localization/messages_zh.js"></script>
<!-- 日期 -->
<script src="../static/js/laydate.js"></script>
<!-- 富文本 -->
<script src="../static/js/wangEditor.js" charset="utf-8"></script>
<!-- 分页 -->
<script src="../static/js/page.js"></script>

<label class="flex150 label">日历</label>
<div class="input-group input-icon " >
    <input type="text"  class="form-control form-Date" readonly>
    <i class="icon iconfont icon-zuocecaidan-5"></i>
</div>

<div class="form-group mb20">
    <label class="flex150 label">双日历</label>
    <div class="input-group input-icon " >
        <input type="text"  class="form-control form-Date1" readonly>
        <i class="icon iconfont icon-zuocecaidan-5"></i>
    </div>
</div>

<div class="form-group mb20">
    <label class="flex150 label">下拉单选：</label>
    <select class="chosen-select">
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
    </select>
</div>


<div class="form-group mb20">
    <label  class="flex150 label">下拉多选：</label>
    <select multiple="multiple" class="DictionarySelect">
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
    </select>
</div>

<script>
    $(function () {
        //下拉单选
        $('.chosen-select').chosen();

        // 下拉多选
        $(".DictionarySelect").multiselect({
            noneSelectedText: "<center>=请选择=</center>",
            checkAllText:    "全选",
            uncheckAllText: "全不选",
            selectedList:55
        }).multiselectfilter({label:"",placeholder:''});

        // 表单校验
        $(".validate").validate({
            rules: {
                text: "required",
                password: {
                    required: true,
                    minlength: 6
                },
                email: {
                    required: true,
                    email: true
                },
            },
            messages: {
                text: "这是必填字段",
                password: {
                    required: "这是必填字段",
                    minlength: "密码长度不能小于 6 个字母"
                },
                email: "请输入一个正确的邮箱"
            }
        });


        // tab切换
        $(".tab-page").find("li").map(function(){
            $(this).click(function(){
                $(this).siblings().removeClass("current-tab");
                $(this).addClass("current-tab");
                var type = $(this).attr("data-type");
                $(".changeTab").hide();
                $(".tab-"+type).show();
            });
        });

    });

    $.validator.setDefaults({
        submitHandler: function() {
            alert("提交事件!");
        }
    });
    //单日历
    laydate.render({
        elem: '.form-Date'
    });
    //双日历
    laydate.render({
        elem: '.form-Date1',
        range: true
    });
    // 富文本start
    var E = window.wangEditor
    var editor = new E('#editor')
    editor.customConfig.uploadImgShowBase64 = true
    editor.create()
    // editor.txt.html() 获取内容
//    获取内容
    //此处是必须的
    editor.txt.html() === "<p><br></p>" ? "" : editor.txt.html();
    // 富文本end

    //  分页start
    Page({
        num:12,					//页码数
        startnum:3,				//指定页码
        elem:$('#page1'),		//指定的元素
        callback:function(n){	//回调函数
            console.log(n);
        }
    });
    // 分页end
</script>
