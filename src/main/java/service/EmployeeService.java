package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Employee;
import pojo.Role;
import pojo.Warehouse;

import java.util.List;
import java.util.Map;

public interface EmployeeService {

    Map<String, Object> login(Employee employee);
    PageInfo<Employee> query(Employee employee, Integer page, Integer limit);
    StateType addEmployee(Employee employee);
    StateType updateEmployee(Employee employee);
    StateType delEmployee(int employeeId);

    StateType freEmployee(int employeeId);

    StateType employeeRole(int employeeId);

    PageInfo<Role> queryRole();

    StateType register(Employee employee);
}
