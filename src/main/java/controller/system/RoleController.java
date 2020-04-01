package controller.system;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.*;
import service.RoleService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    RoleService roleService;

    @RequestMapping("/index")
    public String index(){
        return "system/role/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Role role, @RequestParam Integer page, @RequestParam Integer limit){
        PageInfo<Role> pageInfo=roleService.query(role,page,limit);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将全部数据的条数作为count传给前台（一共多少条）
        tableData.put("count", pageInfo.getTotal());
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    @RequestMapping("/roleInfo")
    @ResponseBody
    public StateType roleInfo(@ModelAttribute Role role, String roleType, HttpSession session){
        if(roleType.equals("add")){
            StateType stateType=roleService.add(role);
            return stateType;
        } else if(roleType.equals("update")){
            StateType stateType=roleService.update(role);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    @RequestMapping("/delRole")
    @ResponseBody
    public StateType delRole(@RequestParam int roleId){
        StateType stateType=roleService.delRole(roleId);
        return stateType;
    }

    @RequestMapping("/queryPermission")
    @ResponseBody
    public List<Permission> queryPermission(@RequestParam Integer roleId){
        return roleService.queryPermission(roleId);
    }

    @RequestMapping("/rolePermission")
    @ResponseBody
    public StateType rolePermission(@RequestBody Role role){
        StateType stateType=roleService.rolePermission(role);
        return stateType;
    }

}
