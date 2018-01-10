package main.java.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

import main.java.common.LoginBinder;
import main.java.constants.ResultConstant;
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.IStationMessageService;
import net.sf.json.JSONObject;


/**
 * 站内短信
 *
 * @author shenda20467
 * 20170818
 */

@Controller
@SuppressWarnings({"rawtypes",  "unchecked"})
public class StationMessageController {

    private static Log log = LogFactory.getLog(StationMessageController.class);

    @Autowired
    IStationMessageService stationMessageService;

    @RequestMapping("/stationMessage/listRequest.html")
    public ModelAndView listRequestView(HttpServletRequest request, Model model) {
        Map map = getCount("需求");
        model.addAttribute("all", map.get("all"));
        model.addAttribute("noRead", map.get("noRead"));
        return new ModelAndView("stationMessage/listRequest");
    }

    @RequestMapping("/stationMessage/listEvent.html")
    public ModelAndView listEventView(HttpServletRequest request, Model model) {
        Map map = getCount("事件");
        model.addAttribute("all", map.get("all"));
        model.addAttribute("noRead", map.get("noRead"));
        return new ModelAndView("stationMessage/listEvent");
    }

    @RequestMapping("/stationMessage/listSystem.html")
    public ModelAndView listSystemView(HttpServletRequest request, Model model) {
        Map map = getCount("系统");
        model.addAttribute("all", map.get("all"));
        model.addAttribute("noRead", map.get("noRead"));
        return new ModelAndView("stationMessage/listSystem");
    }

    /**
     * 查询数据加载
     * @param request
     * @param response
     * @param p
     * @throws IOException
     */
    @RequestMapping(value = "/stationMessage/load.json", method = RequestMethod.POST)
    public void loadData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws IOException {
    	p.put("acceptorNo", LoginBinder.get().getLoginNo());
        p.putAll(Page.newPage(request));
        List<Map> list = stationMessageService.selectPage(p);
        Integer count = stationMessageService.selectCount(p);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(JsonStr.jsonStr(list, count));
    }

    /**
     * 详情
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/stationMessage/detail.json")
    public ModelAndView detail(HttpServletRequest request, Model model, @RequestParam Map p) throws UnsupportedEncodingException {
        stationMessageService.updateStatus(p);  //更新短信状态为已读
    	int messageNo = Integer.parseInt(p.get("messageNo").toString());
        p.put("acceptorNo", LoginBinder.get().getLoginNo());

    	//判断数据是否为空,防止地址入侵
    	if (null == stationMessageService.selectDetail(p)){
            return new ModelAndView("common/noData");
        }

		Map result = stationMessageService.selectDetail(p);
		Map map = new HashMap<>();
		map.put("acceptorNo", LoginBinder.get().getLoginNo());

		//获取上一条数据
		map.put("messageNoExp", "< " + messageNo);
		Map m = stationMessageService.next(map);
		Map before = new HashMap<>();
		if(m == null){ 
			before = null;
		} else {
			p.put("messageNo", m.get("messageNo"));
			before = stationMessageService.selectDetail(p);
		} 
		
		//获取下一条数据 
		map.put("messageNoExp", "> " + messageNo);
		m = stationMessageService.next(map);
		Map after = new HashMap<>();
		if(m == null){ 
			after = null;
		} else {
			p.put("messageNo", m.get("messageNo"));
			after = stationMessageService.selectDetail(p);
		}  
  
		model.addAttribute("before", before);
		model.addAttribute("after", after);   
        model.addAttribute("result", result);
        return new ModelAndView("stationMessage/detail");
    }

    /**
     * 删除短信
     *
     * @throws IOException
     */
    @RequestMapping("/stationMessage/delete.json")
    public void delete(Model model, @RequestParam Map p, HttpServletResponse response) throws IOException {
        p.put("messageNo", p.get("messageNo").toString().split(","));
        Map returnMap = new HashMap<>();
        try {
            stationMessageService.delete(p);
            returnMap.put("result", ResultConstant.SUCCESS);
            String obj = p.get("obj").toString();
            returnMap.putAll(getCount(obj));
        } catch (Exception e) {
            returnMap.put("result", ResultConstant.FAIL);
            returnMap.put(ResultConstant.MESSAGE, "删除短信失败！");
            log.error("删除短信失败:" + e);
        }
        JSONObject result = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(result.toString());
    }

    /**
     * 设为已读
     *
     * @throws IOException
     */
    @RequestMapping("/stationMessage/setRead.json")
    public void setRead(Model model, @RequestParam Map p, HttpServletResponse response) throws IOException {
        p.put("messageNo", p.get("messageNo").toString().split(","));
        Map returnMap = new HashMap<>();
        try {
            stationMessageService.setRead(p);
            returnMap.put("result", ResultConstant.SUCCESS);
            String obj = p.get("obj").toString();
            returnMap.putAll(getCount(obj));
        } catch (Exception e) {
            returnMap.put("result", ResultConstant.FAIL);
            returnMap.put(ResultConstant.MESSAGE, "设为已读失败！");
            log.error("设为已读失败:" + e);
        }
        JSONObject result = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(result.toString());
    }

    /**
     * 获取全部和未读数据
     * @param model
     * @param p
     * @param response
     * @throws IOException
     */
    @RequestMapping("/stationMessage/getCount.json")
    public void getCount(Model model, @RequestParam Map p, HttpServletResponse response) throws IOException {
        Map returnMap = new HashMap<>();
        try { 
            returnMap.put("result", ResultConstant.SUCCESS);
            String obj = p.get("obj").toString();
            returnMap.putAll(getCount(obj));
        } catch (Exception e) {
            returnMap.put("result", ResultConstant.FAIL);
            returnMap.put(ResultConstant.MESSAGE, "获取全部和未读数据失败！");
            log.error("获取全部和未读数据失败！:" + e);
        }
        JSONObject result = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(result.toString());
    }
    
    //根据obj获取全部,未读数据
    public Map getCount(String obj) {
        Map map = new HashMap<>();
        map.put("acceptorNo", LoginBinder.get().getLoginNo());
        map.put("obj", obj);
        Integer all = stationMessageService.selectCount(map);
        map.put("status", "0");
        Integer noRead = stationMessageService.selectCount(map);
        map.put("all", all);
        map.put("noRead", noRead);
        return map;
    }

}


