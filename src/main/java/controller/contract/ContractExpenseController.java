package controller.contract;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.Contract;
import pojo.ContractExpense;
import service.ContractExpenseService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/contractExpense")
public class ContractExpenseController {

    @Autowired
    ContractExpenseService contractExpenseService;

    @RequestMapping("/queryByContractId/{contractId}")
    @ResponseBody
    public Map<String,Object> queryByContractId(@PathVariable Integer contractId){
        List<ContractExpense> contractExpenseList=contractExpenseService.queryByContractId(contractId);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", contractExpenseList);
        return tableData;
    }

    @RequestMapping("/queryListByStorageId/{storageId}")
    @ResponseBody
    public  List<ContractExpense> queryListByStorageId(@PathVariable Integer storageId){
        return contractExpenseService.queryListByStorageId(storageId);
    }
}
