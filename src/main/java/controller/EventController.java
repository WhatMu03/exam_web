package main.java.controller;

import java.io.IOException;
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

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

import main.java.common.CodeChange;
import main.java.common.CommonMethod;
import main.java.common.DateChange;
import main.java.common.LoginBinder;
import main.java.constants.ResultConstant;
import main.java.dto.ExportEvent;
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.ICustProService;
import main.java.service.IDealingUserService;
import main.java.service.IDictionaryService;
import main.java.service.IEventService;
import net.sf.json.JSONObject;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@Controller
@SuppressWarnings({"rawtypes", "unused", "unchecked"})
public class EventController {

    private static Log log = LogFactory.getLog(RequestController.class);

    @Autowired
    IEventService eventService;
    @Autowired
    IDictionaryService dictionaryService;
    @Autowired
    ICustProService custProService;
    @Autowired
    IDealingUserService dealingUserService;

    /**
     * 事件列表
     * 跳转
     *
     * @return
     */
    @RequestMapping("/event/list.html")
    public ModelAndView listView(HttpServletRequest request, HttpServletResponse response, Model model) {
    	Map map = new HashMap<>();
    	map.put("loginNo", LoginBinder.get().getLoginNo());
        List<Map> eventStatus = dictionaryService.eventStatus();
        List<Map> EVENT_TYPE = dictionaryService.EVENT_TYPE();
        List<Map> custPro = custProService.select(map);
        model.addAttribute("eventStatus", eventStatus);
        model.addAttribute("EVENT_TYPE", EVENT_TYPE);
        model.addAttribute("custPro", custPro);
        return new ModelAndView("event/list");
    }

    /**
     * 新建事件成功
     * 跳转
     *
     * @return
     */
    @RequestMapping("/event/insertSuccess.html")
    public ModelAndView successView() {
        return new ModelAndView("event/insert_success");
    }

    /**
     * 新建事件失败
     * 跳转
     *
     * @return
     */
    @RequestMapping("/event/insertFail.html")
    public ModelAndView failView() {
        return new ModelAndView("event/insert_fail");
    }

    /**
     * 新建事件
     * 跳转
     *
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/event/insert.html", produces = "text/html;charset=UTF-8")
    public ModelAndView createView(HttpServletResponse response, HttpServletRequest request, Model model) {
    	Map map = new HashMap<>();
    	map.put("loginNo", LoginBinder.get().getLoginNo());
        List<Map> dealingUser = dealingUserService.selectAll(new HashMap<>());
        List<Map> EVENT_TYPE = dictionaryService.EVENT_TYPE();
        List<Map> custPro = custProService.select(map);
        model.addAttribute("dealingUser", dealingUser);
        model.addAttribute("EVENT_TYPE", EVENT_TYPE);
        model.addAttribute("custPro", custPro);
        Map mm = new HashMap<>();
        mm.put("loginNo", LoginBinder.get().getLoginNo());
        Map returnMap = eventService.selectFormInit(mm);
        return new ModelAndView("event/insert", returnMap);
    }

    /**
     * 查询数据加载
     */
    @RequestMapping(value = "/event/load.json", method = RequestMethod.POST)
    @ResponseBody
    public void loadData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws IOException {
        Map<Object, Object> page = Page.newPage(request);
        p.putAll(page);
        p.put("loginNo", LoginBinder.get().getLoginNo());
        p.put("createTime", DateChange.dateSection(p.get("createTime").toString()));//时间区间转换
        List<Map> list = eventService.selectPage(p);
        Integer count = eventService.selectCount(p);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(JsonStr.jsonStr(list, count));
    }

    /**
     * 详情
     *
     * @param p
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/event/detail.json")
    public  ModelAndView detail(@RequestParam Map p ,HttpServletRequest request,Model model){ 
        Map<Object,Object> page = Page.newPage(request);
        p.putAll(page);
        p.put("loginNo", LoginBinder.get().getLoginNo());//当前登录用户的ID
    	if(!p.containsKey("id")){//首页日历点入事件详情
            p.put("loginNo", LoginBinder.get().getLoginNo());
            List<Map> list= eventService.selectPage(p);
            p.put("id", list.get(0).get("id"));
            p.remove("eventNo");
    	} 
    	
    	int id = Integer.parseInt(p.get("id").toString());
    	boolean flag = eventService.existEventAppraise(p);
		Map result = eventService.selectDetail(p);

		if (null == result){
		    return  new ModelAndView("common/noData");
        }

		Map map = new HashMap<>();
		map.put("loginNo", LoginBinder.get().getLoginNo());
		
		//获取上一条数据
		map.put("idExp", "< " + id);
		Map m = eventService.next(map);
		Map before = new HashMap<>();
		if(m == null){ 
			before = null;
		} else {
			p.put("id", m.get("id"));
			before = eventService.selectDetail(p);  
		} 
		
		//获取下一条数据
		map.put("idExp", "> " + id);
		m = eventService.next(map);
		Map after = new HashMap<>();
		if(m == null){ 
			after = null;
		} else {
			p.put("id", m.get("id"));
			after = eventService.selectDetail(p);  
		}   

        model.addAttribute("flag", flag);
        model.addAttribute("result", result);
        model.addAttribute("before", before);
        model.addAttribute("after", after);
        model.addAttribute("messageNo", p.get("messageNo"));//返回需要用的短信编号
        return new ModelAndView("event/detail");
    }

    /**
     * 导出
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/event/export.json")
    public void exportData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws Exception {
        p.putAll(Page.newPage(request));
        CodeChange.toUtf8(p);
        p.put("loginNo", LoginBinder.get().getLoginNo());
        List<Map<String, String>> list = eventService.selectExport(p);
        CommonMethod.export(list, response, ExportEvent.class);
    }

    /**
     * 创建事件
     *
     * @param request
     * @param response
     * @param m
     * @throws Exception
     */
    @RequestMapping(value = "/event/insert.json", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    @ResponseBody
    public void insert(HttpServletRequest request, HttpServletResponse response, @RequestParam Map m) throws Exception {
        Map<String, Object> returnMap = new HashMap<>();
        m.put("loginName", LoginBinder.get().getLoginName());
        m.put("loginNo", LoginBinder.get().getLoginNo());
        if ("".equals(m.get("eventTitle")) || null == m.get("eventTitle")) {
            returnMap.put(ResultConstant.MESSAGE, "事件标题为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else if ("".equals(m.get("type")) || null == m.get("type")) {
            returnMap.put(ResultConstant.MESSAGE, "事件类型为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else if ("".equals(m.get("occurDateTime")) || null == m.get("occurDateTime")) {
            returnMap.put(ResultConstant.MESSAGE, "发生时间为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else if ("".equals(m.get("saleProductName")) || null == m.get("saleProductName")) {
            returnMap.put(ResultConstant.MESSAGE, "业务系统为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else if ("".equals(m.get("description")) || null == m.get("description")) {
            returnMap.put(ResultConstant.MESSAGE, "事件描述为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else {
            try {
                Map map = eventService.insert(m);
                if (map.containsKey("msg")) {
                    returnMap.put("result", ResultConstant.FAIL);
                    returnMap.put(ResultConstant.MESSAGE, "事件创建失败:" + map.get("msg"));
                } else {
                    returnMap.put("result", ResultConstant.SUCCESS);
                }
            } catch (Exception e) {
                returnMap.put("result", ResultConstant.FAIL);
                returnMap.put(ResultConstant.MESSAGE, "事件创建失败：" + e);
            }
        }
        JSONObject jsonObject = JSONObject.fromObject(returnMap);
        response.getWriter().write(jsonObject.toString());
    }
}
