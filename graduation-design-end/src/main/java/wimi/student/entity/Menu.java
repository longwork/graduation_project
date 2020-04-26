package wimi.student.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Table;

/**
 * @author Administrator
 */
@Table(name="f_menu")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private String id;
    private String name;
    private String action;
    private String icon;
    private int isParent;
    private String parentId;
    private int checked;
    private int open;
    private String menutype;
}
