package controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @RequestMapping("/index")
    public String index(){
        return "system/employee/index";
    }
}
