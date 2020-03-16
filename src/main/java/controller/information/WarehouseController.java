package controller.information;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

    @RequestMapping("/index")
    public String index(){
        return "information/warehouse/index";
    }
}
