<%--
-- 需求状态流程图
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<input type="hidden" value="${param.reqStatus}" class="index">
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

<script type="text/javascript" src="../static/resource/jquery.js"></script>
<script>

    $(function () {
        var state = $('.index').val();//节点状态
        $(".progress-list").find("li").removeClass("active");
        $(".progress-list").find("li").removeClass("end");
        switch (state){
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
                $(".progress-list").find("li").eq(0).addClass("active");
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

    })
</script>
