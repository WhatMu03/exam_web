package main.java.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import main.java.dto.ExportRequest;
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.ICustProService;
import main.java.service.IDictionaryService;
import main.java.service.IRequestService;
import main.java.util.EnumUtil;
import main.java.util.ExcelUtil;
import net.sf.json.JSONObject; 


/**
 * 需求
 * @author shenda20467
 * 20170817
 */

@Controller
@SuppressWarnings({"rawtypes","unused","unchecked"})
public class RequestController {

    private static Log log = LogFactory.getLog(RequestController.class);
	
	@Autowired
	IRequestService requestService;
    @Autowired
    IDictionaryService dictionaryService;
    @Autowired
    ICustProService custProService;

    @RequestMapping("/request/list.html")
    public ModelAndView listView(HttpServletResponse response, HttpServletRequest request, Model model){
    	Map map = new HashMap<>();
    	map.put("loginNo", LoginBinder.get().getLoginNo());
    	List<Map> requestStatus = dictionaryService.requestStatus();
    	List<Map> custPro = custProService.select(map);
        model.addAttribute("requestStatus",requestStatus); 
        model.addAttribute("custPro",custPro); 
    	return new ModelAndView("request/list");
    }

    /**
     * 查询数据加载
     * @param request
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/request/load.json",method=RequestMethod.POST)  
    public void loadData(HttpServletRequest request,HttpServletResponse response,@RequestParam Map p) throws IOException {
    	p.putAll(Page.newPage(request)); 
        p.put("loginNo", LoginBinder.get().getLoginNo());
        p.put("createTime", DateChange.dateSection(p.get("createTime").toString()));//时间区间转换
		List<Map> list = requestService.selectPage(p);  
		Integer count = requestService.selectCount(p);
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(JsonStr.jsonStr(list,count));
    }  

    /**
     * 导出
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	@RequestMapping(value="/request/export.json")  
    public void exportData(HttpServletRequest request,HttpServletResponse response,@RequestParam Map p) throws Exception { 
    	p.putAll(Page.newPage(request));
		CodeChange.toUtf8(p); 
        p.put("loginNo", LoginBinder.get().getLoginNo());
		List<Map<String,String>> list = requestService.selectExport(p);   
		CommonMethod.export(list, response, ExportRequest.class);
    }
	  
	/**
	 * 详情
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
    @RequestMapping("/request/detail.json")
    public ModelAndView detail(HttpServletRequest request,Model model,@RequestParam Map p){
        Map<Object,Object> page = Page.newPage(request);
        p.putAll(page);
		p.put("loginNo", LoginBinder.get().getLoginNo());//当前登录用户的ID
		//首页日历点入事件详情
    	if(!p.containsKey("id")){
			List<Map> list= requestService.selectPage(p);
            p.put("id", list.get(0).get("id"));//获取当前需求的ID
            p.remove("requestNo");
    	}
		int id = Integer.parseInt(p.get("id").toString());
    	boolean flag = requestService.existRequestAppraise(p);//是否存在评价
		Map result = requestService.selectDetail(p);
		if (null == result){
			return new ModelAndView("common/noData");
		}
		Map map = new HashMap<>();
		map.put("loginNo", LoginBinder.get().getLoginNo());
		
		//获取上一条数据
		map.put("idExp", "< " + id);
		Map m = requestService.next(map);
		Map before = new HashMap<>();
		if(m == null){ 
			before = null;
		} else {
			p.put("id", m.get("id"));
			before = requestService.selectDetail(p);  
		} 
		
		//获取下一条数据
		map.put("idExp", "> " + id);
		m = requestService.next(map);
		Map after = new HashMap<>();
		if(m == null){ 
			after = null;
		} else {
			p.put("id", m.get("id"));
			after = requestService.selectDetail(p);  
		}  

		model.addAttribute("flag", flag);
		model.addAttribute("result", result);
		model.addAttribute("before", before);
		model.addAttribute("after", after);
		model.addAttribute("messageNo", p.get("messageNo"));//返回需要用的短信编号


		return new ModelAndView("request/detail");
    }

	/**
	 * 置顶
	 * @return
	 */
    @RequestMapping(value = "/request/setOrCancelTop.json", method = RequestMethod.POST)
    public void setOrCancelTop(HttpServletResponse response, @RequestParam Map m) throws Exception{
		Map returnMap = new HashMap();
		returnMap.put("requestNo", m.get("requestNo"));
		int n = -1;
		if ("1".equals(m.get("important").toString())){
			//原状态：已置顶
			n = requestService.cancelTop(returnMap);
		} else {
			//原状态：未置顶
			n = requestService.setTop(returnMap);
		}
		if (n == 0){
			returnMap.put("result", ResultConstant.FAIL);
			returnMap.put(ResultConstant.MESSAGE, "失败！");
		} else {
			returnMap.put("result", ResultConstant.SUCCESS);
			returnMap.put(ResultConstant.MESSAGE, "成功！");
		}
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(JSONObject.fromObject(returnMap).toString());
	}

}


