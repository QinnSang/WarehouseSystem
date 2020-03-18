package controller.system;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.Contract;
import pojo.Employee;
import pojo.Role;
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

    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        return "system/role/index";
    }

    @RequestMapping("/toEdit/{roleId}")
    public String toEdit(){
        return "system/role/index";
    }

    @RequestMapping("/roleDetail/{roleId}")
    public String roleDetail(@PathVariable("roleId")int roleId){
        return "system/role/index";
    }


}
