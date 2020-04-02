package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.RoleMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.*;
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
        //删除对应角色权限关系
        roleMapper.delRolePermission(roleId);
        //删除对应用户角色关系
        roleMapper.delEmployeeRole(roleId);
        int delRow=roleMapper.delRole(roleId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    /**
     * 将数据库中无顺序的权限结点封装成前台树需要的数据结构
     * @return
     */
    @Override
    public List<Permission> queryPermission(Integer roleId) {
        List<Permission> permissionList=roleMapper.queryPermission();
        //根据角色编号查询已有的权限，并设置复选框为选中状态
        List<Permission> havePermission = roleMapper.queryPermissionByRole(roleId);
        for(Permission p1:permissionList){
            for (Permission p2:havePermission){
                if(p1.getId() == p2.getId())
                    p1.setChecked(true);
            }
        }
        List<Permission> treeDtoList = new ArrayList<>();
        for(Permission permission:permissionList){
            if(permission.getSuperId()==null||StringUtils.isBlank(permission.getSuperId())){
                treeDtoList.add(findChildren(permission,permissionList));
            }
        }
        return treeDtoList;
    }

    /**
     * 递归查询子节点
     * @param permission
     * @param permissionList
     * @return
     */
    private Permission findChildren(Permission permission, List<Permission> permissionList) {
        for(Permission item :permissionList){
            if((permission.getId()+"").equals(item.getSuperId())){
                if(permission.getChildren() == null)
                    permission.setChildren(new ArrayList<>());
                permission.getChildren().add(findChildren(item,permissionList));
            }
        }
        return permission;
    }

    @Override
    public StateType rolePermission(Role role) {
        //逆递归从树结构转化为列表结构
        List<Permission> permissionList = new ArrayList<>();
        List<Permission> treeDto = role.getPermissionList();
        for(Permission permission:treeDto){
            if(permission.getChildren()!=null){
                findPermission(permission,permissionList);
            }
            permissionList.add(permission);
        }
        role.setPermissionList(permissionList);
        //先删除已授权的角色关系
        roleMapper.delRolePermission(role.getRoleId());
        roleMapper.addRolePermission(role);
        return StateType.getStateType(41);
    }

    private void findPermission(Permission permission, List<Permission> permissionList) {
        if(permission.getChildren() == null)
            return ;
        for(Permission item:permission.getChildren()){
            findPermission(item,permissionList);
            permissionList.add(item);
        }
    }


}

