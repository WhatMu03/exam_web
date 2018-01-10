package main.java.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CommonController {
    /**
     * 无数据界面显示
     * @return
     */
    @RequestMapping(value = "/common/noData.html")
    public ModelAndView noDataView(HttpServletRequest request, Model model){
        return new ModelAndView("common/noData");
    }
}
