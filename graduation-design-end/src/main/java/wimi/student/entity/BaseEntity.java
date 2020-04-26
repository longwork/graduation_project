package wimi.student.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author Administrator
 */
@Getter
@Setter
public class BaseEntity {
    @Id
    @Column(name = "Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Transient
    private Integer page = 1;

    @Transient
    private Integer rows = 10;
}
