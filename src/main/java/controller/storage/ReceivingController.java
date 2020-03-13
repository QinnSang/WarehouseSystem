package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/receiving")
public class ReceivingController {

    @RequestMapping("/index")
    public String index(){
        return "storage/receiving/index";
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "storage/receiving/add";
    }

    @RequestMapping("/receivingDetail/{receivingId}")
    public String receivingDetail(@PathVariable("receivingId")int receivingId){
        return "storage/receiving/detail";
    }
}
