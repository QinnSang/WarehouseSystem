package service;

import com.github.pagehelper.PageInfo;
import pojo.Role;
import java.util.List;
import java.util.Map;

public interface RoleService {
    PageInfo<Role> queryRole(Role role);
    boolean add( Role role);

    boolean delete(Long roleId);

    Role queryByRoleId(Long roleId);

    Boolean updateSingleByRoleId(Role role);

    Role queryRoleDetail(Long roleId);
}
