package main.java.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.IEventService;
import main.java.service.IRequestService;
import main.java.service.IServiceAppraiseService;
import net.sf.json.JSONObject;


/**
 * 服务评价
 *
 * @author shenda20467
 * 20170818
 */

@Controller
@SuppressWarnings({"rawtypes", "unchecked"})
public class ServiceAppraiseController {

    private static Log log = LogFactory.getLog(ServiceAppraiseController.class);

    @Autowired
    IServiceAppraiseService serviceAppraiseService;
    @Autowired
    IEventService eventService;
    @Autowired
    IRequestService requestService;

    /**
     * 评价成功
     * @param model
     * @return
     */
    @RequestMapping("/serviceAppraise/appraiseSuccess.html")
    public ModelAndView appraiseSuccess(Model model, @RequestParam Map p) {
    	String type = p.get("type").toString();
    	String appraiseObj = "";
        String appraiserNo = LoginBinder.get().getLoginNo();  //获取用户的id
        Map hashMap = new HashMap();
    	if(type.equals("event")){
    		appraiseObj = "事件";
    	} else {
    		appraiseObj = "需求";
    	}
        hashMap.put("appraiseObj", appraiseObj);
        hashMap.put("appraiserNo", appraiserNo);
        int count = serviceAppraiseService.notEvaluatedCount(hashMap);//未评价
        model.addAttribute("notEvaluatedCount", count);
        model.addAttribute("appraiseObj", appraiseObj);
        return new ModelAndView("serviceAppraise/appraise_success");
    }
    
    /**
     * 评价失败
     * @param request
     * @return
     */
    @RequestMapping("/serviceAppraise/appraiseFail.html")
    public ModelAndView appraiseFail(HttpServletRequest request) {
        return new ModelAndView("serviceAppraise/appraise_fail");
    }

    /**
     * 待评价
     * @param request
     * @return
     */
    @RequestMapping("/serviceAppraise/notEvaluated.html")
    public ModelAndView notEvaluated(HttpServletRequest request,Model model) {
        Map<Object,Object> p = Page.newPage(request);
        p.put("appraiserNo", LoginBinder.get().getLoginNo());
    	List<Map> list = serviceAppraiseService.notEvaluated(p);   
    	Integer count = serviceAppraiseService.notEvaluatedCount(p);   
        model.addAttribute("list",list);
        model.addAttribute("count",count);
        model.addAttribute("page",p.get("page"));
        if(count == 0){
            return new ModelAndView("serviceAppraise/allDone");
        } else {
            return new ModelAndView("serviceAppraise/notEvaluated");
        }
    }

    /**
     * 已评价
     * @param request
     * @return
     */
    @RequestMapping("/serviceAppraise/haveEvaluated.html")
    public ModelAndView haveEvaluated(HttpServletRequest request,Model model) {
        Map<Object,Object> p = Page.newPage(request); 
        p.put("appraiserNo", LoginBinder.get().getLoginNo());
    	List<Map> list = serviceAppraiseService.haveEvaluated(p);
    	Integer count = serviceAppraiseService.haveEvaluatedCount(p);   
        model.addAttribute("list",list);
        model.addAttribute("count",count);
        model.addAttribute("page",p.get("page"));
        if (count == 0) {
            return new ModelAndView("serviceAppraise/neverEvaluated");
        } else {
            return new ModelAndView("serviceAppraise/haveEvaluated");
        }

    }


    /**
     * 需求评价
     * @param request
     * @param model
     * @param p
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/serviceAppraise/request.html")
    public ModelAndView request(HttpServletRequest request, Model model, @RequestParam Map p) throws UnsupportedEncodingException {
        p.put("loginNo", LoginBinder.get().getLoginNo());
        Map result = requestService.selectDetail(p);
        if (null == result) {
            return new ModelAndView("common/noData");
        }
        model.addAttribute("result",result);
        model.addAttribute("loginName", LoginBinder.get().getLoginName());
        return new ModelAndView("serviceAppraise/request");
    }

    /**
     * 事件评价
     * @param request
     * @param model
     * @param p
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/serviceAppraise/event.html")
    public ModelAndView event(HttpServletRequest request, Model model, @RequestParam Map p) throws UnsupportedEncodingException {
        p.put("loginNo", LoginBinder.get().getLoginNo());
        Map result = eventService.selectDetail(p);
        if (null == result) {
            return new ModelAndView("common/noData");
        }
        model.addAttribute("result",result);
        model.addAttribute("loginName",LoginBinder.get().getLoginName());
        return new ModelAndView("serviceAppraise/event");
    }
    
    /**
     * 查询数据加载
     *
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/serviceAppraise/load.json", method = RequestMethod.POST)
    public void loadData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws IOException {
        p.putAll(Page.newPage(request));
        p.put("appraiserNo", LoginBinder.get().getLoginNo());
        List<Map> list = serviceAppraiseService.selectPage(p);
        Integer count = serviceAppraiseService.selectCount(p);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(JsonStr.jsonStr(list, count));
    }

    /**
     * 插入
     *
     * @param request
     * @param response
     * @param p
     * @return
     * @throws IOException 
     */
    @RequestMapping(value = "/serviceAppraise/insert.json")
    @ResponseBody
    public void insertData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws IOException {
        p.put("appraiserNo",LoginBinder.get().getLoginNo());
        p.put("appraiseTime", DateChange.getDateTime());
        Map returnMap = new HashMap<>();
        if ("".equals(p.get("score"))){
            returnMap.put(ResultConstant.MESSAGE, "请您给我们的服务打分,谢谢!");
        } else if ("".equals(p.get("suggest").toString().trim())){
            returnMap.put(ResultConstant.MESSAGE, "请您给我们的服务提点建议,帮助我们改进,谢谢!"); 
        } else {
            try {
                serviceAppraiseService.insert(p);
                returnMap.put("result", ResultConstant.SUCCESS);
            } catch (Exception e) {
                returnMap.put("result", ResultConstant.FAIL);
                returnMap.put(ResultConstant.MESSAGE, "评价插入失败！");
                log.error("评价插入失败:" + e);
            }
        }
        JSONObject result = JSONObject.fromObject(returnMap);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(result.toString());
    }

}