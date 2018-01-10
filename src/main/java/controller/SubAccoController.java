package main.java.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import main.java.common.DateChange;
import main.java.common.LoginBinder;
import main.java.constants.ResultConstant;
import main.java.service.ISubAccoService;
import main.java.util.Md5Utils;
import main.java.validate.ValidatePassword;
import net.sf.json.JSONObject;

@SuppressWarnings({"rawtypes","unchecked"})
@Controller
public class SubAccoController {
    @Autowired
    ISubAccoService subAccoService;

    /**
     * 修改密码 跳转
     * @param request
     * @return
     */
    @RequestMapping("/subAcco/revisePassword.html")
    public ModelAndView revisePasswordView(HttpServletRequest request) {
        return new ModelAndView("subAcco/revisePassword");
    } 
    
	/**
	 * 详情
	 * @param request
	 * @return
	 */ 
	@RequestMapping("/subAcco/detail.html")
    public ModelAndView detail(HttpServletRequest request,Model model,@RequestParam Map p){   
        p.put("loginNo", LoginBinder.get().getLoginNo());
		if (null == subAccoService.selectDetail(p)){
		    return  new ModelAndView("common/noData");
        }
        Map result = subAccoService.selectDetail(p);
		model.addAttribute("result", result);
    	return new ModelAndView("subAcco/detail");
    }
    
    /**
     * 密码校验
     * @param map
     * @return
     */
    public boolean passValid(Map map, Map returnMap){

        String loginNo = map.get("loginNo").toString();
        String newPass = map.get("newPass").toString();
        String checkPass = map.get("checkPass").toString();
        String oldPass = map.get("oldPass").toString();

        Map<String, Object> conditionMap = new HashMap<>();
        conditionMap.put("loginNo", loginNo);
        Map<String, Object> accoInfo= subAccoService.select(conditionMap).get(0);//查询用户信息

        if (!accoInfo.get("password").toString().equals(Md5Utils.stringMD5(oldPass))){
            returnMap.put(ResultConstant.MESSAGE, "当前密码输入错误");
            return false;
        }
        if (!new ValidatePassword().pwdComplexity(newPass) || newPass.length()<6 || newPass.length()>20){
            returnMap.put(ResultConstant.MESSAGE, "6-20个字符，密码至少包含字母、数字以及标点符号（除空格）中的2种");
            return false;
        }
        if (!newPass.equals(checkPass)){
            returnMap.put(ResultConstant.MESSAGE, "两次输入的密码不一致，请重新输入");
            return false;
        }
        if (oldPass.equals(newPass)){
            returnMap.put(ResultConstant.MESSAGE, "新密码不能和原密码一致");
            return false;
        }
        return true;
    } 
    
    /**
     * 修改密码
     * @param request
     * @param response
     * @param p
     */
    @RequestMapping(value = "/subAcco/revisePassword.json",method = RequestMethod.POST,produces = "application/json; charset=utf-8")
    @ResponseBody
    public void revisePassword(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws Exception{
        Map<String, Object> returnMap = new HashMap<>(); 
        Map<String, Object> map = new HashMap<>();
        map.put("loginNo", LoginBinder.get().getLoginNo());
        map.put("oldPass", p.get("oldPass"));//用户输入原密码
        map.put("newPass", p.get("newPass"));//用户输入新密码
        map.put("checkPass", p.get("checkPass"));//用户确认新密码
        //校验成功
        if (passValid(map,returnMap)){
            Map<String, Object> newPassMap = new HashMap<>();
            newPassMap.put("loginNo", LoginBinder.get().getLoginNo());
            newPassMap.put("password", Md5Utils.stringMD5(p.get("newPass").toString()));
            newPassMap.put("lastLoginTime", DateChange.getDateTime());//修改密码的同时,如果上次登录日期为空,则赋予
            try{
                subAccoService.updatePassword(newPassMap);//修改密码
                returnMap.put("result", ResultConstant.SUCCESS);
                returnMap.put(ResultConstant.MESSAGE, "密码修改成功");
            } catch (Exception e){
                returnMap.put("result", ResultConstant.FAIL);
                returnMap.put(ResultConstant.MESSAGE, "密码修改失败");
            }
        } else {
            returnMap.put("result", ResultConstant.FAIL);
        }
        JSONObject jsonObject = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(jsonObject.toString());
    }
    
    /**
     * 跳转至修改密码成功界面
     * @param request
     * @return
     */
    @RequestMapping("/subAcco/revisePassword_success.html")
    public ModelAndView revisePassword_success(HttpServletRequest request) {
        return new ModelAndView("subAcco/revisePassword_success");
    } 

}
