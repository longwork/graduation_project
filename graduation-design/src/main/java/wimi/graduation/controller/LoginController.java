package wimi.graduation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author Long WenChao
 * @date 2020-04-24 13:35 周五
 */
@Controller
public class LoginController {

    @RequestMapping("/login")
    public ModelAndView login(ModelAndView modelAndView) {
        modelAndView.setViewName("index");
        return modelAndView;
    }
}
