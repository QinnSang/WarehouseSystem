package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @RequestMapping("/index")
    public String index(){
        return "contract/index";
    }
}
