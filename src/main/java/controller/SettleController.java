package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/settle")
public class SettleController {

    @RequestMapping("/index")
    public String index(){
        return "settle/index";
    }
}
