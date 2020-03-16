package controller.information;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    @RequestMapping("/index")
    public String index(){
        return "information/goods/index";
    }
}
