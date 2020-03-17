package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Employee;
import pojo.Role;
import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> queryRoles(Role role);

    int add(Role role);

    int delete(@Param("roleId") Long roleId);

    Role queryByRoleId(Long roleId);

    int updateSingleByRoleId(Role role);

    Role queryRoleDetail(@Param("roleId") Long roleId);
}
