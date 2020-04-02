package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import pojo.Role;
import secure.Md5Salt;
import service.EmployeeService;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public StateType register(Employee employee)  {
        Map<String, Object> map=new HashMap<>();
        Employee employee1=employeeMapper.queryByName(employee.getLoginCode());
        if(employee1==null){
            employee1=employeeMapper.queryByEmail(employee.getEmail());
            if(employee1==null){
                Md5Salt md5Salt=new Md5Salt();
                String pwd=employee.getPassword();
                byte[] salt= new byte[0];
                try {
                    salt = md5Salt.getSalt(employee.getEmail()); //将邮箱当做初始盐，并将其转化为盐
                } catch (Exception e) {
                    e.printStackTrace();
                }
                String pwdMd5 = md5Salt.getSecurePassword(pwd, salt);  //对密码进行加密
                employee.setPassword(pwdMd5);
                employee.setSalt(new String(salt, Charset.forName("ISO-8859-1")));
                employee.setStatus(1);
                employee.setSex(1);
                boolean insertFlag=employeeMapper.addEmployee(employee)==1?true:false;
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

    @Override
    public Map<String, Object> login(Employee employee) {
        List<Employee> employees = employeeMapper.queryByCode(employee);
        Map<String,Object> map=new HashMap<>();
        if(employees!=null && employees.size()==1){
            //验证密码是否一致
            Employee employee1 = employees.get(0);
            byte[] salt= employee1.getSalt().getBytes(Charset.forName("ISO-8859-1"));
            String pwd=employee.getPassword();
            Md5Salt md5Salt=new Md5Salt();
            String pwdMd5 = md5Salt.getSecurePassword(pwd, salt);  //对密码进行加密
            if(pwdMd5.equals(employee1.getPassword()) ){
                map.put("StateType",null);
                map.put("employee",employees.get(0));
            }
            else map.put("StateType", StateType.getStateType(17));
        }else{
            map.put("StateType", StateType.getStateType(17));
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
        Employee employee1=employeeMapper.queryByName(employee.getLoginCode());
        if(employee1==null){
            Md5Salt md5Salt=new Md5Salt();
            String pwd=employee.getPassword();
            byte[] salt= new byte[0];
            try {
                salt = md5Salt.getSalt(employee.getEmail()); //将邮箱当做初始盐，并将其转化为盐
            } catch (Exception e) {
                e.printStackTrace();
            }
            String pwdMd5 = md5Salt.getSecurePassword(pwd, salt);  //对密码进行加密
            employee.setPassword(pwdMd5);
            employee.setSalt(new String(salt, Charset.forName("ISO-8859-1")));
            employee.setStatus(1);
            if(employee.getSex() == null)
                employee.setSex(1);
            int addRow1=employeeMapper.addEmployee(employee);
            if(addRow1 == 1)
                return  StateType.getStateType(22);
            return  StateType.getStateType(23);
        }

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
        employeeMapper.delRoleByEmployee(employeeId);
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
        //首先删除已有的用户角色分配
        employeeMapper.delRoleByEmployee(employee.getEmployeeId());
        int roleRow1=employeeMapper.employeeRole(employee);
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
}
