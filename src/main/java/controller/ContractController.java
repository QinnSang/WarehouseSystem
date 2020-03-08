package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @RequestMapping("/index")
    public String index(){
        return "contract/index";
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "contract/addContract";
    }

}
