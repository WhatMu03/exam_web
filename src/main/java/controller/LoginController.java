package main.java.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;

import main.java.common.DateChange;
import main.java.common.commonMap.LoginMap;
import main.java.constants.ResultConstant;
import main.java.entity.SubAcco;
import main.java.service.IEventService;
import main.java.service.ILoginService;
import main.java.service.IStationMessageService;
import main.java.util.Md5Utils;
import main.java.util.MySessionContext;
import main.java.validate.ValidateCode;
import net.sf.json.JSONObject;


@Controller
@SuppressWarnings({"rawtypes", "unchecked"})
public class LoginController {

    @Autowired
    ILoginService loginService;
    @Autowired
    IStationMessageService stationMessageService;
    @Autowired
    IEventService eventService;

    @RequestMapping("/")
    public ModelAndView index(HttpServletRequest request) { 
        return new ModelAndView("index");
    }


    @RequestMapping("/login/login.html")
    public ModelAndView login(HttpServletRequest request) { 
        return new ModelAndView("login/login");
    }

    /**
     * 首次登陆,跳转，修改密码
     *
     * @param request
     * @return
     */
    @RequestMapping("/login/firstLogin.html")
    public ModelAndView firstLogin(HttpServletRequest request) { 
        return new ModelAndView("login/firstLogin");
    }

    //校验
    public boolean check(Map p, Map returnMap) {
        String loginNo = p.get("loginNo").toString();
        String password = p.get("password").toString();
        String code = p.get("code").toString();
        String sessionCode = p.get("sessionCode").toString();

        if ("".equals(code)) {
            returnMap.put(ResultConstant.MESSAGE, "请输入验证码!");
            return false;
        }
        if (!StringUtils.equalsIgnoreCase(code, sessionCode)) {  //验证码，忽略大小写  
            returnMap.put(ResultConstant.MESSAGE, "验证码错误!");
            return false;
        }

        //校验输入规则
        if (loginNo.length() != 5) {
            returnMap.put(ResultConstant.MESSAGE, "请输入5位登录名!");
            return false;
        }
        if (loginNo.trim().isEmpty()) {
            returnMap.put(ResultConstant.MESSAGE, "用户名不能为空");
            return false;
        }
        if (password.trim().isEmpty()) {
            returnMap.put(ResultConstant.MESSAGE, "密码不能为空");
            return false;
        }

        //验证账户是否存在
        Map<String, Object> mm = new HashMap<>();
        mm.put("loginNo", loginNo);
        List<Map> loginAccount = loginService.select(mm);
        if (loginAccount.size() == 0) {
            returnMap.put(ResultConstant.MESSAGE, "账户不存在!");
            return false;
        } else {
            String temp = (String) loginAccount.get(0).get("status");
            SubAcco subAcco = JSON.parseObject(JSON.toJSONString(loginAccount.get(0)), SubAcco.class);
            returnMap.put("subAcco", subAcco);
            //账号存在，检查状态
            switch (temp) {
                case "0":
                    break; 
                case "1":
                    returnMap.put(ResultConstant.MESSAGE, "该账户已禁用!");
                    return false;
                case "2":
                    returnMap.put(ResultConstant.MESSAGE, "该账户已锁定!");
                    return false;
            }
        }
        //账户状态正常，比对密码
        if (loginAccount.get(0).get("password").equals(Md5Utils.stringMD5(password))) {
            LoginMap.countMap.remove(loginNo); //去除当前用户的登录次数
        } else {
            returnMap.put("passwordFail", ResultConstant.SUCCESS);
            return false;
        }

        //登录已经成功,检查用户是不是第一次登录
        if (loginAccount.get(0).get("lastLoginTime") == null || "".equals(loginAccount.get(0).get("lastLoginTime"))) {
            returnMap.put("firstLogin", ResultConstant.SUCCESS);
        } else {
            String loginTimeNow = DateChange.getDateTime();//当前时间,精确到秒
            Map map = new HashMap();
            map.put("loginNo", loginAccount.get(0).get("loginNo"));
            map.put("lastLoginTime", loginTimeNow);
            loginService.update(map);//更改数据库中的最后登录时间
            returnMap.put("firstLogin", ResultConstant.FAIL);
        }
        return true;
    }

    /**
     * 登录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/login/loginInput.json", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String loginInput(@RequestParam Map p, HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("sessionCode");//验证码
        p.put("sessionCode", sessionCode);
        Map<String, Object> returnMap = new HashMap<>();
        if (check(p, returnMap)) {//校验通过
            SubAcco subAcco = (SubAcco) returnMap.get("subAcco");
            session.setAttribute("subAcco", subAcco);  
            if (LoginMap.user_sessionId.containsKey(subAcco.getLoginNo())) {
                String sessionId = LoginMap.user_sessionId.get(subAcco.getLoginNo());
                HttpSession se = MySessionContext.getSession(sessionId);
                if (se != null)
				 {
					se.invalidate();//摧毁
				}
            }
            LoginMap.user_sessionId.put(subAcco.getLoginNo(), session.getId());//当前用户放入sessionId的map内存中
            returnMap.put(ResultConstant.MESSAGE, "登录成功");
        }
        //密码错误
        if (returnMap.containsKey("passwordFail") && "1".equals(returnMap.get("passwordFail"))) {
            String loginNo = p.get("loginNo").toString();
            if (!LoginMap.countMap.containsKey(loginNo)) {
                LoginMap.countMap.put(loginNo, 1);
                returnMap.put(ResultConstant.MESSAGE, "账号或密码错误");
            } else {
                if (LoginMap.countMap.get(loginNo).equals(LoginMap.MAX_ACCESS_TIMES)) {
                    Map updateStatus = new HashMap<String, Object>();
                    updateStatus.put("loginNo", loginNo);
                    updateStatus.put("status", 2);
                    updateStatus.put("lockTime", DateChange.getDateTime());
                    loginService.updateStatus(updateStatus);//输错6次 改变子账户status
                    returnMap.put(ResultConstant.MESSAGE, "账户已锁定,请联系管理员");
//                    LoginMap.countMap.remove(loginNo); //去除当前用户的登录次数
                } else {
                    LoginMap.countMap.put(loginNo, LoginMap.countMap.get(loginNo) + 1);//次数+1
                    int leftAttemptCount = LoginMap.MAX_ACCESS_TIMES + 1 - LoginMap.countMap.get(loginNo);
                    returnMap.put(ResultConstant.MESSAGE, "账户或密码错误！剩余尝试次数" + leftAttemptCount);
                }
            }
        }

//        //TODO TEST
//        Subject subject 

        JSONObject jsonResult = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        return jsonResult.toString();
    }

    /**
     * 响应验证码页面
     *
     * @return
     */
    @RequestMapping(value = "/login/validateCode.json")
    public String validateCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 设置响应的类型格式为图片格式  
        response.setContentType("image/jpeg");
        //禁止图像缓存。  
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession();

        ValidateCode vCode = new ValidateCode(120, 40, 4, 100);
        session.setAttribute("sessionCode", vCode.getCode());
        vCode.write(response.getOutputStream());
        return null;
    }

    /**
     * 安全退出
     */
    @RequestMapping(value = "/login/logout.json", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SubAcco subAcco = (SubAcco) session.getAttribute("subAcco");
        if (subAcco != null && LoginMap.user_sessionId.containsKey(subAcco.getLoginNo())) {
            String sessionId = LoginMap.user_sessionId.get(subAcco.getLoginNo());
            HttpSession se = MySessionContext.getSession(sessionId);
            se.invalidate();//摧毁 
        }
        return new ModelAndView("login/login");
    }
    
}


