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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

import main.java.common.CodeChange;
import main.java.common.DateChange;
import main.java.common.LoginBinder;
import main.java.constants.ResultConstant;
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.IHelpService;
import net.sf.json.JSONObject; 


/**
 * 帮助中心
 * @author shenda20467
 * 20170831
 */

@Controller
@SuppressWarnings({"rawtypes","unused","unchecked"})
public class HelpController {

    private static Log log = LogFactory.getLog(HelpController.class);
	
	@Autowired
	IHelpService helpService;

	//全部
    @RequestMapping("/help/all.html")
    public ModelAndView allView(HttpServletRequest request,Model model,@RequestParam Map p) throws UnsupportedEncodingException {
    	CodeChange.toUtf8(p);
		p.putAll(Page.newPage(request)); 
		List<Map> list = helpService.selectPage(p);  
		Integer count = helpService.selectCount(p);
    	model.addAttribute("list", list);
    	model.addAttribute("count", count); 
        model.addAttribute("page",p.get("page"));
    	model.addAttribute("key", p.containsKey("key") ? p.get("key") : "");  
    	return new ModelAndView("help/all");
    } 

    //最新问题
    @RequestMapping("/help/new.html")
    public ModelAndView newView(HttpServletRequest request,Model model,@RequestParam Map p) throws UnsupportedEncodingException {
    	CodeChange.toUtf8(p);
		p.putAll(Page.newPage(request)); 
		List<Map> list = helpService.newPage(p);  
		Integer count = list.size();
    	model.addAttribute("list", list);
    	model.addAttribute("count", count); 
        model.addAttribute("page",p.get("page"));
    	model.addAttribute("key", p.containsKey("key") ? p.get("key") : "");  
    	return new ModelAndView("help/new");
    } 
    
    //常见问题
    @RequestMapping("/help/common.html")
    public ModelAndView commonView(HttpServletRequest request,Model model,@RequestParam Map p) throws UnsupportedEncodingException {
    	CodeChange.toUtf8(p);
		p.put("common", "1");
    	p.putAll(Page.newPage(request)); 
		List<Map> list = helpService.commonPage(p);  
		Integer count = helpService.commonCount(p);
    	model.addAttribute("list", list);
    	model.addAttribute("count", count); 
        model.addAttribute("page",p.get("page"));
    	model.addAttribute("key", p.containsKey("key") ? p.get("key") : "");  
    	return new ModelAndView("help/common");
    } 

    //热门问题
    @RequestMapping("/help/hot.html")
    public ModelAndView hotView(HttpServletRequest request,Model model,@RequestParam Map p) throws UnsupportedEncodingException {
    	CodeChange.toUtf8(p);
		p.putAll(Page.newPage(request)); 
		List<Map> list = helpService.hotPage(p);  
		Integer count = list.size();
    	model.addAttribute("list", list);
    	model.addAttribute("count", count); 
        model.addAttribute("page",p.get("page"));
    	model.addAttribute("key", p.containsKey("key") ? p.get("key") : "");  
    	return new ModelAndView("help/hot");
    }

    /**
     * 查询数据加载
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/help/load.json",method=RequestMethod.POST)  
    public void loadData(HttpServletRequest request,HttpServletResponse response,@RequestParam Map p) throws IOException { 
    	p.putAll(Page.newPage(request)); 
		List<Map> list = helpService.selectPage(p);  
		Integer count = helpService.selectCount(p);
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(JsonStr.jsonStr(list,count));
    }    
    
    /**
     * 插入
     * @throws IOException 
     */
    @RequestMapping("/help/insert.json") 
    public ModelAndView insert(Model model,@RequestParam Map p,HttpServletResponse response) throws IOException{   
    	p.put("createTime", DateChange.getDateTime());
		try {
			helpService.insert(p);
			int id = helpService.maxId();
	    	model.addAttribute("id", id); 
	    	return new ModelAndView("help/success");
		} catch (Exception e) { 
			log.error("文章添加失败:" + e);
	    	return new ModelAndView("help/fail");
		}     
	}  
 
    /**
     * 删除
     * @throws IOException 
     */
    @RequestMapping("/help/delete.json") 
    public void delete(Model model,@RequestParam Map p,HttpServletResponse response) throws IOException{   
		p.put("id", p.get("id").toString().split(","));
    	Map returnMap = new HashMap<>(); 
		try {
			helpService.delete(p);
			returnMap.put("result", ResultConstant.SUCCESS);  
		} catch (Exception e) {
			returnMap.put("result", ResultConstant.FAIL);
			returnMap.put(ResultConstant.MESSAGE, "文章删除失败！");
			log.error("文章删除失败:" + e);
		}    
    	JSONObject result = JSONObject.fromObject(returnMap); 
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(result.toString());
	} 
 
    /**
     * 更新
     * @throws IOException 
     */
    @RequestMapping("/help/update.json") 
    public void update(Model model,@RequestParam Map p,HttpServletResponse response) throws IOException{   
    	Map returnMap = new HashMap<>(); 
    	p.put("createTime", DateChange.getDateTime());
		try {
			helpService.update(p);
			returnMap.put("result", ResultConstant.SUCCESS);  
		} catch (Exception e) {
			returnMap.put("result", ResultConstant.FAIL);
			returnMap.put(ResultConstant.MESSAGE, "文章更新失败！");
			log.error("文章更新失败:" + e);
		}    
    	JSONObject result = JSONObject.fromObject(returnMap); 
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(result.toString());
	}  
 
    /**
     * 点赞
     * @throws IOException 
     */
    @RequestMapping("/help/good.json") 
    public void good(Model model,@RequestParam Map p,HttpServletResponse response) throws IOException{   
    	Map returnMap = new HashMap<>(); 
		try {
			helpService.good(p);
			returnMap.put("result", ResultConstant.SUCCESS);  
		} catch (Exception e) {
			returnMap.put("result", ResultConstant.FAIL);
			returnMap.put(ResultConstant.MESSAGE, "点赞失败！");
			log.error("点赞失败:" + e);
		}    
    	JSONObject result = JSONObject.fromObject(returnMap); 
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(result.toString());
	}  
 
    /**
     * 点踩
     * @throws IOException 
     */
    @RequestMapping("/help/bad.json") 
    public void bad(Model model,@RequestParam Map p,HttpServletResponse response) throws IOException{   
    	Map returnMap = new HashMap<>(); 
		try {
			helpService.bad(p);
			returnMap.put("result", ResultConstant.SUCCESS);  
		} catch (Exception e) {
			returnMap.put("result", ResultConstant.FAIL);
			returnMap.put(ResultConstant.MESSAGE, "点踩失败！");
			log.error("点踩失败:" + e);
		}    
    	JSONObject result = JSONObject.fromObject(returnMap); 
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(result.toString());
	}  
    
	/**
	 * 详情
	 * @param request
	 * @return
	 */
    @RequestMapping("/help/detail.json")
    public ModelAndView detail(HttpServletRequest request,Model model,@RequestParam Map p){  
    	int id = Integer.parseInt(p.get("id").toString()); 
		Map result = helpService.selectDetail(p);   
		Map map = new HashMap<>();
		map.put("loginNo", LoginBinder.get().getLoginNo());
		
		//获取上一条数据
		map.put("idExp", "< " + id);
		Map m = helpService.next(map);
		Map before = new HashMap<>();
		if(m == null){ 
			before = null;
		} else {
			p.put("id", m.get("id"));
			before = helpService.selectDetail(p);  
		} 
		
		//获取下一条数据
		map.put("idExp", "> " + id);
		m = helpService.next(map);
		Map after = new HashMap<>();
		if(m == null){ 
			after = null;
		} else {
			p.put("id", m.get("id"));
			after = helpService.selectDetail(p);  
		}   
		
		//当前子账号的点赞或点踩情况
		map.put("help_center_id", id);
		Map detailMap = helpService.select_detail(map);
		if(detailMap == null){
			model.addAttribute("status", "2");
		} else {
			model.addAttribute("status", detailMap.get("status").toString());
		}
		
		model.addAttribute("result", result);
		model.addAttribute("before", before);
		model.addAttribute("after", after);
    	return new ModelAndView("help/detail");
    } 
 
}


