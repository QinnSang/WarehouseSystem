package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/log")
public class LogController {

    @RequestMapping("/index")
    public String index(){
        return "storage/log/index";
    }

    @RequestMapping("/logDetail/{logId}")
    public String logDetail(@PathVariable("logId")int logId){
        return "storage/log/detail";
    }
}
