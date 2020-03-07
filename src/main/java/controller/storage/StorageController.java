package controller.storage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/storage")
public class StorageController {

    @RequestMapping("/index")
    public String index(){
        return "storage/storage/index";
    }
}
