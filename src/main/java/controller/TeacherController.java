package main.java.controller;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import main.java.common.DateChange;
import main.java.common.LoginBinder;
import main.java.constants.ResultConstant;
import main.java.dto.JsonStr;
import main.java.dto.Page;
import main.java.service.*;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@Controller
@SuppressWarnings({"rawtypes", "unused", "unchecked"})
public class TeacherController {

    private static Log log = LogFactory.getLog(RequestController.class);

    @Autowired
    ITeacherService teacherService;
    @Autowired
    IDictionaryService dictionaryService;
    @Autowired
    ICustProService custProService;
    @Autowired
    IDealingUserService dealingUserService;

    /**
     * 教师列表
     * 跳转
     *
     * @return
     */
    @RequestMapping("/teacher/list.html")
    public ModelAndView listView(HttpServletRequest request, HttpServletResponse response, Model model) {
    	Map map = new HashMap<>();
    	map.put("loginNo", LoginBinder.get().getLoginNo());
        List<Map> eventStatus = dictionaryService.eventStatus();
        List<Map> EVENT_TYPE = dictionaryService.EVENT_TYPE();
        List<Map> custPro = custProService.select(map);
        model.addAttribute("eventStatus", eventStatus);
        model.addAttribute("EVENT_TYPE", EVENT_TYPE);
        model.addAttribute("custPro", custPro);
        return new ModelAndView("teacher/list");
    }

    /**
     * 新建教师成功
     * 跳转
     *
     * @return
     */
    @RequestMapping("/teacher/insertSuccess.html")
    public ModelAndView successView() {
        return new ModelAndView("teacher/insert_success");
    }

    /**
     * 新建教师失败
     * 跳转
     *
     * @return
     */
    @RequestMapping("/teacher/insertFail.html")
    public ModelAndView failView() {
        return new ModelAndView("teacher/insert_fail");
    }

    /**
     * 新建教师
     * 跳转
     *
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/teacher/insert.html", produces = "text/html;charset=UTF-8")
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
        Map returnMap = new HashMap();
        return new ModelAndView("teacher/insert", returnMap);
    }

    /**
     * 查询数据加载
     */
    @RequestMapping(value = "/teacher/load.json", method = RequestMethod.POST)
    @ResponseBody
    public void loadData(HttpServletRequest request, HttpServletResponse response, @RequestParam Map p) throws IOException {
        Map<Object, Object> page = Page.newPage(request);
        p.putAll(page);
        List<Map> list = teacherService.selectPage(p);
        Integer count = teacherService.selectCount(p);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().print(JsonStr.jsonStr(list, count));
    }

    /**
     * 创建教师
     *
     * @param request
     * @param response
     * @param m
     * @throws Exception
     */
    @RequestMapping(value = "/teacher/insert.json", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    @ResponseBody
    public void insert(HttpServletRequest request, HttpServletResponse response, @RequestParam Map m) throws Exception {
        Map<String, Object> returnMap = new HashMap<>();
        m.put("loginName", LoginBinder.get().getLoginName());
        m.put("loginNo", LoginBinder.get().getLoginNo());
        if ("".equals(m.get("code")) || null == m.get("code")) {
            returnMap.put(ResultConstant.MESSAGE, "工号为空");
            returnMap.put("result", ResultConstant.FAIL);
        } else {
            try {
                teacherService.insert(m);
            } catch (Exception e) {
                returnMap.put("result", ResultConstant.FAIL);
                returnMap.put(ResultConstant.MESSAGE, "教师创建失败：" + e);
            }
        }
        JSONObject jsonObject = JSONObject.fromObject(returnMap);
        response.getWriter().write(jsonObject.toString());
    }
}
