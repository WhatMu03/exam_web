<%--
  Created by IntelliJ IDEA.
  User: sunyt22618
  Date: 2017/9/19
  Time: 15:42
  左侧导航栏公共组件
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" value="${param.index}" class="index">
<div class="secondaryMenu">
    <div class="logo"><i class="icon iconfont icon-logo-"></i></div>
    </a>
    <div class="menuCont">
        <ul class="parent">
            <li>
                <ul class="child">
                    <li>
                        <div class="childList">
                            <a href="/kfxt/home/homePage.html">
                                <i class="icon iconfont icon-zuocecaidan-2"></i>首页
                            </a>
                        </div>
                    </li> 
                </ul>
            </li>
            <li>
                <div class="titleList">我的事件</div>
                <ul class="child">
<!--                     <li>
                        <div class="childList">
                            <a href="/kfxt/event/insert.html">
                                <i class="icon iconfont icon-zuocecaidan-5"></i>新建事件
                            </a>
                        </div>
                    </li> -->
                    <li>
                        <div class="childList">
                            <a href="/kfxt/event/list.html">
                                <i class="icon iconfont icon-zuocecaidan-3"></i>事件查询
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
            <li>
                <div class="titleList">我的需求</div>
                <ul class="child">
                    <li>
                        <div class="childList">
                            <a href="/kfxt/request/list.html">
                                <i class="icon iconfont icon-zuocecaidan-4"></i>需求查询
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
            <li>
                <div class="titleList">消息中心</div>
                <ul class="child">
                    <li>
                        <div class="childList">
                            <a href="/kfxt/stationMessage/listEvent.html">
                                <i class="icon iconfont icon-zuocecaidan-6"></i>事件反馈
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="childList">
                            <a href="/kfxt/stationMessage/listRequest.html">
                                <i class="icon iconfont icon-zuocecaidan-7"></i>需求反馈
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="childList">
                            <a href="/kfxt/stationMessage/listSystem.html">
                                <i class="icon iconfont icon-zuocecaidan-8"></i>系统消息
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
            <li>
                <div class="titleList">服务评价</div>
                <ul class="child">
                    <li>
                        <div class="childList">
                            <a href="/kfxt/serviceAppraise/notEvaluated.html">
                                <i class="icon iconfont icon-zuocecaidan-1"></i>待评价
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="childList">
                            <a href="/kfxt/serviceAppraise/haveEvaluated.html">
                                <i class="icon iconfont icon-zuocecaidan-"></i>已评价
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<script>
    (function(){
        //界面索引值
        var index  = document.querySelector('.index').value;
        var objList = document.querySelectorAll('.child li');

        var array = ["首页","事件查询","需求查询","事件反馈","需求反馈","系统消息","待评价","已评价"];
        for (var i = 0;i<array.length;i++){
            if(index == array[i]){
                objList[i].setAttribute("class","active");
            }else {
                objList[i].setAttribute("class","");
            }
        }

    })();

</script>
