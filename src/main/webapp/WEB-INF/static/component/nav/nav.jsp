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
                <div class="titleList">用户管理</div>
                <ul class="child">
                    <li>
                        <div class="childList">
                            <a href="/kfxt/teacher/list.html">
                                <i class="icon iconfont icon-zuocecaidan-3"></i>教师列表
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="childList">
                            <a href="/kfxt/student/list.html">
                                <i class="icon iconfont icon-zuocecaidan-4"></i>学生列表
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

        var array = ["教师列表","学生列表"];
        for (var i = 0;i<array.length;i++){
            if(index == array[i]){
                objList[i].setAttribute("class","active");
            }else {
                objList[i].setAttribute("class","");
            }
        }

    })();

</script>
