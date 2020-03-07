package controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/role")
public class RoleController {

    @RequestMapping("/index")
    public String index(){
        return "system/role/index";
    }
}
