package controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/client")
public class ClientController {

    @RequestMapping("/index")
    public String index(){
        return "system/client/index";
    }
}
