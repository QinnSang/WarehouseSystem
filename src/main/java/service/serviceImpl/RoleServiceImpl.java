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

}

