package wimi.student.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.Table;

/**
 * @author Administrator
 */
@EqualsAndHashCode(callSuper = true)
@Table(name = "personinfo")
@Data
@NoArgsConstructor
public class Person extends BaseEntity {
    private String accountid;
    private String realname;
    private Integer age;
    private String sex;
    private String cardid;
    private String address;
    private String telephone;
}
