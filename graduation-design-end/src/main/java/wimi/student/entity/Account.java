package wimi.student.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author Administrator
 */
@Getter
@Setter
@NoArgsConstructor
public class Account extends BaseEntity {
    private String username;
    private String password;
    private Double balance;
    private String status;
    private String role;
}
