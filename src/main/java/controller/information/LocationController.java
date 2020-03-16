package controller.information;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/location")
public class LocationController {

    @RequestMapping("/index")
    public String index(){
        return "information/location/index";
    }
}