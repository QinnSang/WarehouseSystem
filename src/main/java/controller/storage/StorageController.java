package controller.storage;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.*;
import service.ContractService;
import service.StorageService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/storage")
public class StorageController {

    @Autowired
    StorageService storageService;

    @Autowired
    ContractService contractService;

    @RequestMapping("/index")
    public String index(Model model){
        List<Contract> contractList=contractService.queryAllValidContract();
        model.addAttribute("contractList",contractList);
        return "storage/storage/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Storage storage,  Integer page,  Integer limit){
        PageInfo<Storage> pageInfo=storageService.query(storage,page,limit);
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

    @RequestMapping("/add")
    @ResponseBody
    public StateType add(@ModelAttribute Storage storage,HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=storageService.add(storage,employee);
        return stateType;
    }

    @RequestMapping("/del")
    @ResponseBody
    public StateType del(@RequestParam int storageId){
        return storageService.del(storageId);
    }

    @RequestMapping("/invalid/{storageId}")
    @ResponseBody
    public StateType invalid(@PathVariable("storageId")int storageId){
        StateType stateType=storageService.invalid(storageId);
        return stateType;
    }

    @RequestMapping("/confirm/{storageId}")
    @ResponseBody
    public StateType confirm(@PathVariable("storageId")int storageId){
        StateType stateType=storageService.confirm(storageId);
        return stateType;
    }

    @RequestMapping("/archive/{storageId}")
    @ResponseBody
    public StateType archive(@PathVariable("storageId")int storageId){
        StateType stateType=storageService.archive(storageId);
        return stateType;
    }



}
