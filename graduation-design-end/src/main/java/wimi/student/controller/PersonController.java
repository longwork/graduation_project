package wimi.student.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import wimi.student.entity.PersonVO;
import wimi.student.service.PersonService;
import wimi.student.util.JsonResult;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/person")
@AllArgsConstructor
public class PersonController {

    private final PersonService personService;

    /**
     * @return 跳转所有账户页面
     */
    @RequestMapping("/showAllPerson")
    public String showAllPerson() {
        return "/user/person";
    }

    /**
     * @return 跳转冻结账户页面
     */
    @RequestMapping("/showStopPerson")
    public String showStopPerson() {
        return "/user/personStop";
    }

    /**
     * @return 跳转开户页面
     */
    @RequestMapping("/newPerson")
    public String newPerson() {
        return "/user/newPerson";
    }

    /**
     * @return 跳转启用账户页面
     */
    @RequestMapping("/showOpenPerson")
    public String showOpenPerson() {
        return "/user/personOpen";
    }

    /**
     * @param personVO 传去需要查询的内容
     * @return 获取所有人员信息
     */
    @RequestMapping(value = "/getAllPerson")
    @ResponseBody
    public Map<String, Object> getAllPerson(PersonVO personVO) {
        List<PersonVO> personVOList = personService.getAllPerson(personVO);
        int total = personService.countAllPerson(personVO);
        Map<String, Object> map = new HashMap<>(10);
        map.put("rows", personVOList);
        map.put("total", total);
        return map;
    }

    /**
     * @param request 网页request请求
     * @return 修改状态信息
     */
    @RequestMapping(value = "/changeStatus")
    @ResponseBody
    public JsonResult<Integer> changeStatus(HttpServletRequest request) {
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        int result = personService.changeStatus(id, status);
        return new JsonResult<>(result);
    }

    /**
     * @param request 网页request请求
     * @return 删除个人信息
     */
    @RequestMapping(value = "/deleteInfo")
    @ResponseBody
    public JsonResult<Integer> deleteInfo(HttpServletRequest request) {
        String id = request.getParameter("id");
        int result = personService.deleteInfo(id);
        return new JsonResult<>(result);
    }


    /**
     * @param personVO 传来需要查询的内容
     * @return 获取所有人员信息
     */
    @RequestMapping(value = "/getStopPerson")
    @ResponseBody
    public Map<String, Object> getStopPerson(PersonVO personVO) {
        personVO.setStatus("冻结");
        List<PersonVO> personVOList = personService.getPerson(personVO);
        int total = personService.countAllPerson(personVO);
        Map<String, Object> map = new HashMap<>(10);
        map.put("rows", personVOList);
        map.put("total", total);
        return map;
    }


    /**
     * @param personVO 传来需要查询的内容
     * @return 获取所有人员信息
     */
    @RequestMapping(value = "/getOpenPerson")
    @ResponseBody
    public Map<String, Object> getOpenPerson(PersonVO personVO) {
        personVO.setStatus("启用");
        List<PersonVO> personVOList = personService.getPerson(personVO);
        int total = personService.countAllPerson(personVO);
        Map<String, Object> map = new HashMap<>(10);
        map.put("rows", personVOList);
        map.put("total", total);
        return map;
    }

    /**
     * @param personVO 需要添加的开户人员信息
     * @return 添加开户人员信息
     */
    @RequestMapping(value = "/submitInfo")
    @ResponseBody
    public JsonResult<Integer> submitInfo(PersonVO personVO) {
        try {

            int result = personService.submitInfo(personVO);
            if (result == 1) {
                return new JsonResult<>(result);
            } else {
                return new JsonResult<>(1, "数据插入失败");
            }
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
    }
}