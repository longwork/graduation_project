package wimi.student.controller;

import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import wimi.student.entity.Account;
import wimi.student.entity.Transaction;
import wimi.student.service.TransactionService;
import wimi.student.util.JsonResult;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/trans")
@AllArgsConstructor
public class TransactionController {

    private final TransactionService transactionService;

    /**
     * @return 显示存款页面
     */
    @RequestMapping(value = "/showDeposit")
    public String showDeposit() {
        return "bank/deposit";
    }

    /**
     * @return 显示取款页面
     */
    @RequestMapping(value = "/showWithdrawals")
    public String showWithdrawals() {
        return "bank/withdrawals";
    }

    /**
     * @return 显示转账页面
     */
    @RequestMapping(value = "/showTransfer")
    public String showTransfer() {
        return "bank/transfer";
    }

    /**
     * @return 显示交易记录页面
     */
    @RequestMapping(value = "/showAllTrans")
    public String showAllTrans() {
        return "bank/records";
    }

    /**
     * @param transaction 账户信息
     * @param session     网页session信息
     * @return 存款
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult<Integer> saveMoney(Transaction transaction, HttpSession session) {
        JsonResult<Integer> jsonResult = new JsonResult<>();
        Account account = (Account) session.getAttribute("account");
        try {
            int n = transactionService.saveMoney(transaction, account);
            if (n > 0) {
                jsonResult.setState(0);
                jsonResult.setMessage("操作成功");
                jsonResult.setData(n);
            } else {
                jsonResult.setState(1);
                jsonResult.setMessage("操作失败");
            }
        } catch (Exception e) {
            return new JsonResult<>(e);
        }
        return jsonResult;
    }

    /**
     * @param transaction 账户信息
     * @param request     网页的session信息
     * @return 查看交易记录根据session找到所有的交易记录，返回trans列表
     */
    @RequestMapping(value = "/getAllTrans")
    @ResponseBody
    public Map<String, Object> getAllTrans(Transaction transaction, HttpServletRequest request) {
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        Map<String, Object> map = new HashMap<>(100);
        Account account = (Account) request.getSession().getAttribute("account");
        List<Transaction> transactions = transactionService.getAllTrans(transaction, account, beginTime, endTime);
        PageInfo<Transaction> pageList = new PageInfo<>(transactions);
        map.put("rows", pageList.getList());
        map.put("total", pageList.getTotal());

        return map;
    }
}
