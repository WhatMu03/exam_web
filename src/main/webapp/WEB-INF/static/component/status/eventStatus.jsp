<%--
-- 需求状态流程图
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<input type="hidden" value="${param.flowStatus}" class="index">
 <div class="clearfix btn-collection">
        <div class="progress clearfix">
            <ul class="progress-list clearfix" style="width: 80%;margin: 0px auto 0;padding-left: 15%; padding-top: 20px;">
                <li>
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


<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script>
    $(function () {
        var state = $('.index').val();//节点状态
        $(".progress-list").find("li").removeClass("active");
        $(".progress-list").find("li").removeClass("end");
        switch (state){
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
    })
</script>
