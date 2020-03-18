package controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.Company;
import pojo.Contract;
import pojo.Employee;
import service.ContractService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @Autowired
    ContractService contractService;

    @RequestMapping("/index")
    public String index(){
        return "contract/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Contract contract, @RequestParam Integer page, @RequestParam Integer limit){
        PageInfo<Contract> pageInfo=contractService.query(contract,page,limit);
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

    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        return "contract/add";
    }

    @RequestMapping("/toEdit/{contractId}")
    public String toEdit(){
        return "contract/edit";
    }

    @RequestMapping("/contractDetail/{contractId}")
    public String contractDetail(@PathVariable("contractId")int contractId){
        return "contract/detail";
    }


}
