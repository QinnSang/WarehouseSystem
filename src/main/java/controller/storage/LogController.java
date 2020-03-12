package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/log")
public class LogController {

    @RequestMapping("/index")
    public String index(){
        return "storage/log/index";
    }
}
