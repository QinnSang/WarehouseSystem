package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Permission;
import pojo.Role;
import java.util.List;

public interface RoleService {

    PageInfo<Role> query(Role role, Integer page, Integer limit);
    StateType add(Role role);

    StateType update(Role role);

    StateType delRole(int roleId);

    List<Permission> queryPermission(Integer roleId);

    StateType rolePermission(Role role);
}
