package controller.storage;

import com.github.pagehelper.PageInfo;
import dto.LogDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Log;
import pojo.Storage;
import service.LogService;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/log")
public class LogController {

    @Autowired
    LogService logService;

    @RequestMapping("/index")
    public String index(){
        return "storage/log/index";
    }

    @RequestMapping("/toIndex/{storageCode}")
    public String toIndex(@PathVariable String storageCode, Model model){
        model.addAttribute("storageCode",storageCode);
        return "storage/log/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute LogDto logDto, Integer page, Integer limit){
        PageInfo<Log> pageInfo=logService.query(logDto,page,limit);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将全部数据的条数作为count传给前台（一共多少条）
        tableData.put("count", pageInfo.getTotal());
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    @RequestMapping("/logDetail/{logId}")
    public String logDetail(@PathVariable("logId")int logId){
        return "storage/log/detail";
    }
}
