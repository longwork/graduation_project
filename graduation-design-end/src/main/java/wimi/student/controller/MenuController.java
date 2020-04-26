package wimi.student.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import wimi.student.entity.Account;
import wimi.student.entity.Menu;
import wimi.student.entity.MenuVo;
import wimi.student.service.MenuService;

import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * @author Administrator
 */
@Controller
@RequestMapping("/menu")
@AllArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @RequestMapping
    @ResponseBody
    public List<MenuVo> getAll(Menu menu, HttpSession session) {
        Account account = (Account) session.getAttribute("account");
        return menuService.getAll(menu, account);
    }
}
