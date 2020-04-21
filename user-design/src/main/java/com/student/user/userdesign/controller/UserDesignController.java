package com.student.user.userdesign.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;

/**
 * @author Long
 * @date 2020-04-21 21:03:05 周二
 */
@Controller
public class UserDesignController {
    @RequestMapping("/test")
    public String test(Model model) {
        model.addAttribute("msg", "hello");
        model.addAttribute("list", Arrays.asList("long", "wen", "chao"));
        return "test";
    }
}
