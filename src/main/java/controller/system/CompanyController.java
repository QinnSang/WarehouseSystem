package controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @RequestMapping("/index")
    public String index(){
        return "system/company/index";
    }
}
