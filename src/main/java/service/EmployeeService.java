package service;

import pojo.Employee;

import java.util.Map;

public interface EmployeeService {

    Map<String, Object> login(Employee employee);
}
