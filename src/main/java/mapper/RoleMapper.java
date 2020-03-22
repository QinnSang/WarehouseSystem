package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Company;
import pojo.Employee;
import pojo.Role;
import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> query(Role role);
    int add(Role role);

    int update(Role role);

    int delRole(@Param("roleId") int roleId);

    Role queryById(@Param("roleId") Integer roleId);

}
