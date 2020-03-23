package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Contract;
import pojo.Employee;
import pojo.Role;
import java.util.List;
import java.util.Map;

public interface RoleService {

    PageInfo<Role> query(Role role, Integer page, Integer limit);
    StateType add(Role role);

    StateType update(Role role);

    StateType delRole(int roleId);
}
