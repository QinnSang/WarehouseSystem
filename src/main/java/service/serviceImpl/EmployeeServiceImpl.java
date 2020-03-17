package service.serviceImpl;

import constant.StateType;
import mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import service.EmployeeService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public Map<String, Object> login(Employee employee) {
        List<Employee> employees = employeeMapper.queryByNameAndPwd(employee);
        Map<String,Object> map=new HashMap<>();
        if(employees!=null && employees.size()==1){
            map.put("StateType",null);
            map.put("employee",employees.get(0));
        }else{
            map.put("StateType", StateType.getStateType(14));
        }
        return map;
    }
}
