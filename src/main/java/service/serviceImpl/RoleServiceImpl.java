package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.CompanyMapper;
import mapper.EmployeeMapper;
import mapper.RoleMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Company;
import pojo.Contract;
import pojo.Employee;
import pojo.Role;
import service.CompanyService;
import service.EmployeeService;
import service.RoleService;

import java.util.*;

@Service("roleService")
public class RoleServiceImpl implements RoleService{

    @Autowired
    RoleMapper roleMapper;
    
    @Override
    public PageInfo<Role> query(Role role, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Role> list=roleMapper.query(role);
        PageInfo<Role> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType add(Role role) {
        int addRow1=roleMapper.add(role);
        //如果添加成功
        if(addRow1==1)
            return  StateType.getStateType(22);
        return  StateType.getStateType(23);
    }

    @Override
    public StateType update(Role role) {

        int updateRow1=roleMapper.update(role);
        //如果修改角色信息成功
        if(updateRow1==1)
            return  StateType.getStateType(20);
        return  StateType.getStateType(21);
    }

    @Override
    public StateType delRole(int roleId) {
        int delRow=roleMapper.delRole(roleId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public Role queryById(Integer roleId) {
        return roleMapper.queryById(roleId);
    }


}

