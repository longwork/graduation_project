package wimi.student.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Administrator
 */
@Controller
public class InitController {

    @RequestMapping(value = "/toIndex")
    public String toIndex() {
        return "index";
    }

    @RequestMapping(value = "/toLogin")
    public String toLogin() {
        return "login";
    }
}

