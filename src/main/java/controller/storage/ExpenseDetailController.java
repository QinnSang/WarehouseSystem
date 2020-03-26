package controller.storage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.ContractExpense;
import pojo.ExpenseDetail;
import service.ExpenseDetailService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/expenseDetail")
public class ExpenseDetailController {

    @Autowired
    ExpenseDetailService expenseDetailService;

    @RequestMapping("/queryByOrderId/{orderId}")
    @ResponseBody
    public Map<String,Object> queryByOrderId(@PathVariable Integer orderId){
        List<ExpenseDetail> expenseDetailList=expenseDetailService.queryByOrderId(orderId);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", expenseDetailList);
        return tableData;
    }

}
