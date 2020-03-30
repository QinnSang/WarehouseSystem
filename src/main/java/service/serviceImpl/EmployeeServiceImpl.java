package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import pojo.Location;
import pojo.Role;
import service.EmployeeService;

import java.util.Date;
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
    public StateType employeeRole(int employeeId) {
        int roleRow1=employeeMapper.employeeRole(employeeId);
        //如果添加用户角色成功
        if(roleRow1>=1)
            return  StateType.getStateType(22);
        return  StateType.getStateType(23);
    }

    @Override
    public PageInfo<Role> queryRole() {
        List<Role> list=employeeMapper.queryRole();
        PageInfo<Role> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType register(Employee employee) {
        Map<String, Object> map=new HashMap<>();
        Employee employee1=employeeMapper.queryByName(employee.getLoginCode());
        if(employee1==null){
            employee1=employeeMapper.queryByEmail(employee.getEmail());
            if(employee1==null){
                //todo 发送邮件时把注册时间当做参数传过去，对参数进行签名。验证时与当前时间比较，减少了保存时间的操作。
//                String pwdMd5= SecureUtils.getMD5(employee.getPassword());
//                String validatecode=SecureUtils.getMD5(employee.getEmail());
//                employee.setPassword(pwdMd5);
//                employee.setLoginCode(validatecode);
                employee.setStatus(1);
                boolean insertFlag=employeeMapper.register(employee)==1?true:false;
                if(insertFlag){
                    return null;
                }else{
                    //注册失败
                    return  StateType.getStateType(13);
                }
            }else{
                //邮箱已被注册
                return  StateType.getStateType(12);
            }
        }else{
            //账号已被注册
            return  StateType.getStateType(11);
        }
    }


}
