package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/receiving")
public class ReceivingController {

    @RequestMapping("/index")
    public String index(){
        return "storage/receiving/index";
    }
}
