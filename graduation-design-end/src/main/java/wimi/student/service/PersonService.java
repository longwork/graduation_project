package wimi.student.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import wimi.student.entity.Account;
import wimi.student.entity.Person;
import wimi.student.entity.PersonVO;
import wimi.student.mapper.AccountMapper;
import wimi.student.mapper.PersoninfoMapper;
import wimi.student.util.UUIDGenerator;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @author Administrator
 */
@Service
@AllArgsConstructor
public class PersonService {
    private final AccountMapper accountMapper;
    private final PersoninfoMapper personinfoMapper;

    public List<PersonVO> getAllPerson(PersonVO personVO) {
        int rows = personVO.getRows();
        int page = personVO.getPage() - 1;
        return personinfoMapper.getAllPerson(rows, page);
    }

    public int countAllPerson(PersonVO personVO) {
        return personinfoMapper.countAllPerson(personVO.getStatus());
    }

    public int changeStatus(String id, String status) {
        Account account = new Account();
        account.setId(id);
        account.setStatus(status);
        return accountMapper.updateByPrimaryKeySelective(account);
    }

    public int deleteInfo(String id) {
        accountMapper.deleteByPrimaryKey(id);
        Person person = new Person();
        person.setAccountid(id);
        return personinfoMapper.delete(person);
    }

    public List<PersonVO> getPerson(PersonVO personVO) {
        int rows = personVO.getRows();
        int page = personVO.getPage() - 1;
        return personinfoMapper.getPerson(rows, page, personVO.getStatus());
    }

    @Transactional
    public int submitInfo(PersonVO personVO) throws Exception {
        Account account = new Account();
        account.setUsername(personVO.getUsername());
        if (accountMapper.select(account).size() > 0) {
            throw new Exception("该用户名已注册");
        }

        String id = UUIDGenerator.getUUID();
        account.setId(id);
        account.setStatus("启用");
        account.setBalance(personVO.getBalance());
        account.setPassword(personVO.getPassword());
        account.setRole(personVO.getRole());


        int i = accountMapper.insert(account);
        int pi = 0;
        if (i == 1) {
            Person person = new Person();
            person.setId(UUIDGenerator.getUUID());
            person.setAccountid(id);
            person.setRealname(personVO.getRealname());
            person.setSex(personVO.getSex());
            person.setAge(personVO.getAge());
            person.setAddress(personVO.getAddress());
            person.setTelephone(personVO.getTelephone());
            person.setCardid(personVO.getCardid());
            pi = personinfoMapper.insert(person);
            if (pi != 1) {
                accountMapper.delete(account);
            }
        }
        return pi;
    }

    public List<PersonVO> getPersonList() {
        return personinfoMapper.getPersonList();
    }
}
