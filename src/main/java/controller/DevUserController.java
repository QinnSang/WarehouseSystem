package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/warehouse")
public class DevUserController {
    @RequestMapping("/index")
    public String index(){
        return "warehouse/index";
    }
}
