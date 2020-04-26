package wimi.student.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import wimi.student.entity.Account;
import wimi.student.entity.Transaction;
import wimi.student.mapper.AccountMapper;
import wimi.student.mapper.TransactionMapper;
import wimi.student.util.DateUtil;
import wimi.student.util.UUIDGenerator;

import java.util.Date;
import java.util.List;

/**
 * 交易，存款，取款，转账
 *
 * @author Administrator
 */
@Service
@AllArgsConstructor
public class TransactionService {

    private final TransactionMapper transactionMapper;

    private final AccountMapper accountMapper;


    public int saveMoney(Transaction transaction, Account account) throws Exception {
        transaction.setAccountid(account.getId());

        transaction.setDatetime(new Date());
        transaction.setId(UUIDGenerator.getUUID());
        Account acco = accountMapper.selectByPrimaryKey(account.getId());


        if ("取款".equalsIgnoreCase(transaction.getType())) {
            transaction.setOtherid(account.getId().toString());
            findBalance(acco, transaction);
        } else if ("存款".equalsIgnoreCase(transaction.getType())) {
            transaction.setOtherid(account.getId().toString());
            acco.setBalance(acco.getBalance() + transaction.getTrMoney());
        } else if ("转账".equalsIgnoreCase(transaction.getType())) {

            findBalance(acco, transaction);
            Account other = accountMapper.selectByPrimaryKey(transaction.getOtherid());
            if (other == null) {
                throw new Exception("转账账号有误，请重新输入");
            }
            other.setBalance(other.getBalance() + transaction.getTrMoney());
            accountMapper.updateByPrimaryKey(other);
        }
        transactionMapper.insert(transaction);
        return accountMapper.updateByPrimaryKey(acco);
    }

    public void findBalance(Account account, Transaction transaction) throws Exception {
        Double balance = account.getBalance();
        if (balance >= transaction.getTrMoney()) {
            account.setBalance(account.getBalance() - transaction.getTrMoney());
        } else {
            throw new Exception("账户金额不足");
        }
    }


    public List<Transaction> getAllTrans(Transaction transaction, Account account, String beginTime, String endTime) {
        Date begin = new Date();
        Date end = new Date();
        if ((beginTime == null || "".equalsIgnoreCase(beginTime))) {
            begin = DateUtil.getYearFirst(1970);
        } else {
            begin = new Date(beginTime);
        }
        if (endTime == null || "".equalsIgnoreCase(endTime)) {
            end = new Date();
        } else {
            end = new Date(endTime);
        }

       /* if (transaction.getPage() != null && transaction.getRows() != null) {
            PageHelper.startPage(transaction.getPage(), transaction.getRows());
        }*/

        return transactionMapper.listTransaction(transaction.getType(), begin, end, account.getId(), account.getId());
    }
}
