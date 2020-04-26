package wimi.student.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import wimi.student.entity.Account;
import wimi.student.entity.Person;
import wimi.student.mapper.LoginMapper;
import wimi.student.mapper.PersoninfoMapper;


/**
 * @author Administrator
 */
@Service
@AllArgsConstructor
public class LoginService {

    private final LoginMapper loginMapper;

    private final PersoninfoMapper personinfoMapper;

    private static final String S = "冻结";

    public Account findByUser(Account userInfo) throws Exception {
        Account account = loginMapper.selectOne(userInfo);
        if (account == null) {
            throw new Exception("用户名或密码错误");
        }
        if (S.equalsIgnoreCase(account.getStatus())) {
            throw new Exception("该账户已被冻结");
        }
        return account;
    }

    public Integer changeUser(Account account) {
        return loginMapper.updateByPrimaryKey(account);
    }

    public Person findByPerson(Person person) throws Exception {
        Person persons = personinfoMapper.selectOne(person);
        if (persons != null) {
            return persons;
        } else {
            throw new Exception("找不到该用户信息");
        }
    }

    public int updatePerson(Person person) {
        return personinfoMapper.updateByPrimaryKey(person);
    }
}
