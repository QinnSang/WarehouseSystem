package service;

import com.github.pagehelper.PageInfo;
import pojo.Role;
import java.util.List;
import java.util.Map;

public interface RoleService {

    PageInfo<Role> query(Role role, Integer page, Integer limit);
}
