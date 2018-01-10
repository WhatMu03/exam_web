package main.java.controller;

import java.util.HashMap;
import java.util.List;
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
import main.java.service.IEventService;
import main.java.service.IRequestService;
import main.java.service.IStationMessageService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * 主页controller
 */
@SuppressWarnings({"unchecked","rawtypes"})
@Controller
public class HomeController {

    @Autowired
    IStationMessageService stationMessageService;
    @Autowired
    IEventService eventService;
    @Autowired
    IRequestService requestService;

    /**
     * 登录首页
     * @param request
     * @param response
     * @param model
     * @return
     */
	@RequestMapping("/home/homePage.html")
    public ModelAndView homePage(HttpServletRequest request, HttpServletResponse response, Model model) { 
		//获取当前用户所在的公司当前月所有事件
		Map m = new HashMap<>();
		m.put("createTime", DateChange.getYMonth());
		m.put("loginNo", LoginBinder.get().getLoginNo());
        List<Map> list = eventService.monthEvent(m);
        JSONArray jsonArr = JSONArray.fromObject(list.toArray());
		
		Map map = new HashMap<>(); 
        map.put("loginNo", LoginBinder.get().getLoginNo());
        map.put("loginName", LoginBinder.get().getLoginName());
        
        List<Map> listEvent = eventService.unsolved(map);
        List<Map> listRequest = requestService.unsolved(map);
        List<Map> listAll = stationMessageService.noRead(map);
        map.put("obj", "事件");
        List<Map> listEventBack = stationMessageService.noRead(map);
        map.put("obj", "需求");
        List<Map> listRequestBack = stationMessageService.noRead(map);
        map.remove("obj");
        map.put("sender", "1");
        List<Map> listSystem = stationMessageService.noRead(map);
        model.addAttribute("listEvent",listEvent);//未解决事件
        model.addAttribute("event",listEvent.size());//未解决事件总计
        model.addAttribute("listRequest",listRequest);//未解决需求
        model.addAttribute("request",listRequest.size());//未解决需求总计
        model.addAttribute("listAll",listAll);//全部未读
        model.addAttribute("all",listAll.size());//全部未读总计 
        model.addAttribute("listEventBack",listEventBack);//事件反馈未读 
        model.addAttribute("eventBack",listEventBack.size());//事件反馈未读总计 
        model.addAttribute("listRequestBack",listRequestBack);//需求反馈未读
        model.addAttribute("requestBack",listRequestBack.size());//需求反馈未读总计 
        model.addAttribute("listSystem",listSystem);//系统反馈未读 
        model.addAttribute("system",listSystem.size());//系统反馈未读总计 
        model.addAttribute("jsonArr",jsonArr);//当前月事件
        return new ModelAndView("home/homePage");
    }  

	/**
	 * 获取指定月的数据
	 * @param request
	 * @param response
	 * @param p
	 * @throws Exception
	 */
    @RequestMapping(value = "/home/nextMonth.json",method = RequestMethod.POST,produces = "application/json; charset=utf-8")
    @ResponseBody
    public void nextMonth(HttpServletRequest request,HttpServletResponse response,@RequestParam Map p)throws Exception{
    	String month = p.get("month").toString();
    	String year = p.get("year").toString();
    	if(month.length() == 1){
    		month = "0" + month;
    	}
		Map m = new HashMap<>();
		m.put("createTime", year + "-" + month);
		m.put("loginNo", LoginBinder.get().getLoginNo());
        Map returnMap = new HashMap<>();
        try { 
            List<Map> list = eventService.monthEvent(m);
            JSONArray jsonArr = JSONArray.fromObject(list.toArray()); 
         	returnMap.put("result", ResultConstant.SUCCESS);
         	returnMap.put("jsonArr", jsonArr);
        } catch (Exception e){
            returnMap.put("result",ResultConstant.FAIL);
            returnMap.put(ResultConstant.MESSAGE,"获取指定月数据失败：" + e);
        }
        JSONObject jsonObject = JSONObject.fromObject(returnMap);
        response.getWriter().write(jsonObject.toString());
    }
    
    
}
