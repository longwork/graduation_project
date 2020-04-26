package wimi.student.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Administrator
 */
@Data
@NoArgsConstructor
public class MenuVo {
    private String id;
    private String name;
    private String action;
    @JsonProperty("iconCls")
    private String icon;
    private Boolean isParent;
    private String parentId;
    private Boolean checked;
    private Boolean open;
    private String menutype;
    private List<MenuVo> children;

    public MenuVo(Menu menu) {
        this.id = menu.getId();
        this.name = menu.getName();
        this.action = menu.getAction();
        this.icon = menu.getIcon();
        this.menutype = menu.getMenutype();
        this.checked = (menu.getChecked() == 0);
        this.isParent = (menu.getIsParent() == 0);
        this.open = (menu.getOpen() == 0);
        this.parentId = menu.getParentId();
        this.children = new ArrayList<>();
    }
}
