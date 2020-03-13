package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shipping")
public class ShippingController {

    @RequestMapping("/index")
    public String index(){
        return "storage/shipping/index";
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "storage/shipping/add";
    }

    @RequestMapping("/shippingDetail/{shippingId}")
    public String shippingDetail(@PathVariable("shippingId")int shippingId){
        return "storage/shipping/detail";
    }
}
