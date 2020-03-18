package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Employee;
import pojo.Role;
import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> query(Role role);

}
