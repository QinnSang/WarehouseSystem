package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Employee;
import pojo.Warehouse;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    List<Employee> queryByNameAndPwd(Employee employee);

   List<Employee>query(Employee employee);

    int addEmployee(Employee employee);

    int updateEmployee(Employee employee);

    int delEmployee(@Param("employeeId") int employeeId);
}
