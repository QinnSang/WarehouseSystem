package controller.system;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.Employee;
import pojo.Location;
import pojo.Role;
import service.EmployeeService;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/index")
    public String index(){
        return "system/employee/index";
    }

    @RequestMapping("/toLogin")
    public String toLogin() {
        return "system/employee/login";
    }

    @RequestMapping("/login")
    public String login(@ModelAttribute Employee employee,HttpSession  session, Model model){
        //因为需要同时将user和查询消息同时查出来，所以用Map接受
        Map<String,Object> map=employeeService.login(employee);
        StateType stateType= (StateType) map.get("StateType");
        employee= (Employee) map.get("employee");
        if(stateType==null){
//            利用session保存员工信息，可在jsp和后台中取得该员工信息
            session.setAttribute("employee",employee);
//            return "redirect:/index/index";
             return "index";
        }
        model.addAttribute("stateType",stateType);
//        return "redirect:/";  //因为登录错误而需要返回页面提示消息，所以不能使用redirect，否则取不到stateType
        return "system/employee/login";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Employee employee, @RequestParam Integer page, @RequestParam Integer limit){
        PageInfo<Employee> pageInfo=employeeService.query(employee,page,limit);
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

    @RequestMapping("/employeeInfo")
    @ResponseBody
    public StateType employeeInfo(@ModelAttribute Employee employee, String employeeType, HttpSession session){
        if(employeeType.equals("insert")){
            StateType stateType=employeeService.addEmployee(employee);
            return stateType;
        } else if(employeeType.equals("update")){
            StateType stateType=employeeService.updateEmployee(employee);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    @RequestMapping("/delEmployee")
    @ResponseBody
    public StateType delEmployee(@RequestParam int employeeId){
        StateType stateType=employeeService.delEmployee(employeeId);
        return stateType;
    }

    @RequestMapping("/freEmployee")
    @ResponseBody
    public StateType freEmployee(@RequestParam int employeeId){
        StateType stateType=employeeService.freEmployee(employeeId);
        return stateType;
    }


    //查询所有角色信息
    @RequestMapping("/queryRole")
    @ResponseBody
    public Map<String, Object> queryRole () {
        PageInfo<Role> pageInfo = employeeService.queryRole();
        Map<String, Object> tableData = new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    @RequestMapping("/roleInfo")
    @ResponseBody
    public StateType roleInfo(@ModelAttribute int employeeId){
            StateType stateType=employeeService.employeeRole(employeeId);
            return stateType;
    }
}
