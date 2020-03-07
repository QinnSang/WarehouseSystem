package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

    @RequestMapping("/index")
    public String index(){
        return "storage/warehouse/index";
    }
}
