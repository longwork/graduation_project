package wimi.student.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import wimi.student.entity.Account;
import wimi.student.entity.Menu;
import wimi.student.entity.MenuVo;
import wimi.student.mapper.MenuMapper;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Administrator
 */
@Service
@AllArgsConstructor
public class MenuService {

    private final MenuMapper menuMapper;

    private static final String S = "管理员";

    public List<MenuVo> getAll(Menu menu1, Account account) {
        if (S.equalsIgnoreCase(account.getRole())) {
            menu1.setMenutype("1");
        } else {
            menu1.setMenutype("0");
        }

        /* Example example=new Example(Menu.class);
        Example.Criteria criteria = example.createCriteria();
        if (selmenu.getMenutype()==1||selmenu.getMenutype()==0) {
            criteria.andLike("menutype", "%" + selmenu.getMenutype() + "%");
        } */

        List<Menu> list = menuMapper.select(menu1);
        List<MenuVo> mainList = new ArrayList<>();
        List<MenuVo> subList = new ArrayList<>();
        for (Menu menu : list) {
            if ("".equalsIgnoreCase(menu.getParentId()) || menu.getParentId() == null) {
                mainList.add(new MenuVo(menu));
            } else {
                subList.add(new MenuVo(menu));
            }
        }
        parseParentAndChildren(mainList, subList);
        return mainList;
    }

    private void parseParentAndChildren(List<MenuVo> mainList, List<MenuVo> subList) {
        for (MenuVo main : mainList) {
            List<MenuVo> list = new ArrayList<>();
            for (MenuVo sub : subList) {
                if (main.getId().equalsIgnoreCase(sub.getParentId())) {
                    list.add(sub);
                }
            }
            main.setChildren(list);
        }
    }

  /*  public menu getById(Integer id) {
        return menuMapper.selectByPrimaryKey(id);
    }

    public void deleteById(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }

    public void save(menu country) {
        if (country.getId() != null) {
            menuMapper.updateByPrimaryKey(country);
        } else {
            menuMapper.insert(country);
        }
    }*/
}
