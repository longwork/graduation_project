package com.student.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Long
 * @date 9:48 2020-04-23 周四
 */
@RestController
public class TestController {

    @GetMapping("/test")
    public String test(){
        return "hello";
    }
}
