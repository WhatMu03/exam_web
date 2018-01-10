package main.java.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import main.java.entity.SubAcco;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/31.
 * 登录拦截器
 */
public class loginInterceptor extends HandlerInterceptorAdapter {

    /**
     * 整个请求处理完毕回调方法
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest arg0,
                                HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
    }

    /**
     * 后处理回调方法
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
                           Object arg2, ModelAndView arg3) throws Exception {
    }


    /**
     * 预处理回调方法
     */
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        SubAcco subAcco = (SubAcco) session.getAttribute("subAcco");//获得session中的用户
        String curPath = request.getRequestURL().toString();//获取请求地址 
		//首次登陆放开
        if (curPath.contains("firstLogin")) {
			return true;
        }
        
        if (curPath.contains("login") && !curPath.contains("logout")){
        	if(subAcco != null){//说明此时已有session,不必重复输入登入信息，直接跳转到首页
                response.sendRedirect(curPath.substring(0,curPath.lastIndexOf("kfxt") + 5) + "home/homePage.html");
                return false;
        	} else {
                return true;
        	}
        } else {
            if(subAcco == null){
                response.sendRedirect(curPath.substring(0,curPath.lastIndexOf("kfxt") + 5) + "login/login.html");
                return false;
            } else {
                return true;
            }
        }
    }
}
