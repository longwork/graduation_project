package wimi.student.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author Administrator
 */
@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class Transaction extends BaseEntity {
    private String accountid;
    private String otherid;
    private Double trMoney;
    private Date datetime;
    private String type;

    @Override
    public String toString() {
        return "Transaction{" +
                "accountid='" + accountid + '\'' +
                ", otherid='" + otherid + '\'' +
                ", trMoney=" + trMoney +
                ", datetime=" + datetime +
                ", type='" + type + '\'' +
                '}';
    }
}
