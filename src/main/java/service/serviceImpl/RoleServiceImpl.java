package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.deploy.ui.AppInfo;
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
    public PageInfo<Role> queryRole(Role role) {
        //防止导出功能没有分页的需求
        if(role.getPage()!=null&&role.getLimit()!=null)
            PageHelper.startPage(role.getPage(),role.getLimit());
        List<Role> list=roleMapper.queryRoles(role);
        PageInfo<Role> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public boolean add(Role role) {
        return false;
    }

    @Override
    public boolean delete(Long roleId) {
        return false;
    }

    @Override
    public Role queryByRoleId(Long appId) {
        return null;
    }

    @Override
    public Boolean updateSingleByRoleId(Role role) {
        return null;
    }

    @Override
    public Role queryRoleDetail(Long roleId) {
        return null;
    }


}

