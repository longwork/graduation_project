package wimi.student.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author Administrator
 */
@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class PersonVO extends BaseEntity {
    private String accountid;
    private String username;
    private String password;
    private Double balance;
    private String realname;
    private String address;
    private String cardid;
    private Integer age;
    private String sex;
    private String telephone;
    private String status;
    private String role;
}
