package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Company;
import pojo.Employee;
import pojo.Permission;
import pojo.Role;
import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> query(Role role);
    int add(Role role);

    int update(Role role);

    int delRole(@Param("roleId") int roleId);

    List<Permission> queryPermission();

    int delRolePermission(Integer roleId);

    int addRolePermission(Role role);

    List<Permission> queryPermissionByRole(Integer roleId);
}
