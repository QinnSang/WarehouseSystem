package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import pojo.Role;
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

    @Override
    public PageInfo<Employee> query(Employee employee, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Employee> list=employeeMapper.query(employee);
        PageInfo<Employee> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType addEmployee(Employee employee) {
        int addRow1=employeeMapper.addEmployee(employee);
        //如果添加成功
        if(addRow1==1)
            return  StateType.getStateType(22);
        return  StateType.getStateType(23);
    }

    @Override
    public StateType updateEmployee(Employee employee) {

        int updateRow1=employeeMapper.updateEmployee(employee);
        //如果修改用户信息成功
        if(updateRow1==1)
            return  StateType.getStateType(20);
        return  StateType.getStateType(21);
    }

    @Override
    public StateType delEmployee(int employeeId) {
        int delRow=employeeMapper.delEmployee(employeeId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public StateType freEmployee(int employeeId) {
        int freRow=employeeMapper.freEmployee(employeeId);
        if(freRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public StateType employeeRole(Employee employee) {
        int roleRow1=employeeMapper.employeeRole(employee);
        //如果修改用户信息成功
        if(roleRow1==1)
            return  StateType.getStateType(20);
        return  StateType.getStateType(21);
    }


}
