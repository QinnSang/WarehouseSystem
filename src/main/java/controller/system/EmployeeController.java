package controller.system;

import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Employee;
import service.EmployeeService;
import javax.servlet.http.HttpSession;
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

}
