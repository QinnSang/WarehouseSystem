package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.Employee;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    List<Employee> queryByNameAndPwd(Employee employee);
}
