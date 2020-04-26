package wimi.student.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import wimi.student.entity.Account;
import wimi.student.entity.Person;
import wimi.student.service.LoginService;
import wimi.student.util.JsonResult;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/user")
@AllArgsConstructor
public class LoginController {

    private final LoginService loginService;

    /**
     * @return 跳转到密码修改页面
     */
    @RequestMapping("/showPassword")
    public String showPassword() {
        return "/personinfo/password";
    }

    /**
     * @return 跳转到个人信息页面
     */
    @RequestMapping("/showPerson")
    public String showPerson() {
        return "/personinfo/info";
    }

    /**
     * @return 跳转到余额查询页面
     */
    @RequestMapping("/showBalance")
    public String showBalance() {
        return "/bank/balance";
    }

    /**
     * @param userInfo 账户信息
     * @param session  页面session
     * @return 登录信息判断
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult<Account> handleLogin(Account userInfo, HttpSession session) {
        Account account;
        try {
            account = loginService.findByUser(userInfo);
            session.setAttribute("account", account);
            session.setAttribute("username", account.getUsername());
            session.setAttribute("role", account.getRole());
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
        return new JsonResult<>(account);
    }

    /**
     * @param session  网页session信息
     * @param password 密码
     * @return 解锁
     */
    @RequestMapping(value = "/getLock")
    @ResponseBody
    public JsonResult<Account> getLock(HttpSession session, String password) {
        Account account = (Account) session.getAttribute("account");
        if (account.getPassword().equalsIgnoreCase(password)) {
            return new JsonResult<>(account);
        } else {
            return new JsonResult<>(1, "密码错误");
        }
    }

    /**
     * @param session 网页session
     * @return 获取用户名
     */
    @RequestMapping(value = "/getUsername")
    @ResponseBody
    public JsonResult<Account> getUsername(HttpSession session) {
        Account account = (Account) session.getAttribute("account");
        try {
            Account newAccount = loginService.findByUser(account);
            return new JsonResult<>(newAccount);
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
    }

    /**
     * @param request 网页请求request
     * @return 修改密码
     */
    @RequestMapping(value = "/changePassword")
    @ResponseBody
    public JsonResult<Integer> changePassword(HttpServletRequest request) {
        Account account = (Account) request.getSession().getAttribute("account");
        if (account == null) {
            return new JsonResult<>(1, "用户未登录，请重新登录");
        } else {
            String oldPassword = request.getParameter("oldPassword");
            if (account.getPassword().equalsIgnoreCase(oldPassword)) {
                String newPassword = request.getParameter("newPassword");
                account.setPassword(newPassword);
                Integer n = loginService.changeUser(account);
                if (n == 1) {
                    return new JsonResult<>(0, "密码修改成功");
                } else {
                    return new JsonResult<>(1, "密码修改失败");
                }
            } else {
                return new JsonResult<>(1, "密码输入错误");
            }
        }
    }

    /**
     * @param request 网页请求request
     * @return 获取个人信息
     */
    @RequestMapping(value = "/getUser")
    @ResponseBody
    public JsonResult<Person> getUser(HttpServletRequest request) {
        Account account = (Account) request.getSession().getAttribute("account");
        Person person = new Person();
        person.setAccountid(account.getId());
        try {
            Person p = loginService.findByPerson(person);
            return new JsonResult<>(p);
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
    }

    /**
     * @param person 需要修改的个人信息
     * @return 修改个人信息
     */
    @RequestMapping(value = "/updatePerson")
    @ResponseBody
    public JsonResult<Integer> updatePerson(Person person) {
        try {
            int i = loginService.updatePerson(person);
            return new JsonResult<>(i);
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
    }

}
