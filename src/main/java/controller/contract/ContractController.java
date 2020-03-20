package controller.contract;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.*;
import service.CompanyService;
import service.ContractService;
import service.DataDictionaryService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @Autowired
    ContractService contractService;

    @Autowired
    CompanyService companyService;

    @Autowired
    DataDictionaryService dataDictionaryService;

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

    //将重复查询的信息封装成方法
    public void containsInformation(Model model) {
        //获取公司
        List<Company> companies=companyService.query(new Company()).getList();
        //获取费用
        List<DataDictionary> expenses=dataDictionaryService.queryExpense(new DataDictionary());
//        JsonArray expenseList = JSONArray(JSON.toJSONString(expenses));
        //将费用转化为json格式以便js获取
        JSONArray expenseList= JSONArray.parseArray(JSON.toJSONString(expenses));
        model.addAttribute("expenseList",expenseList);
        model.addAttribute("companies",companies);
    }


    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        containsInformation(model);
        return "contract/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public StateType add(@RequestBody Contract contract,HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=contractService.add(contract,employee);
        return stateType;
    }

    @RequestMapping("/toEdit/{contractId}")
    public String toEdit(@PathVariable("contractId")int contractId, Model model){
        //设置合同对象id，利用已有的查询
        Contract contract=new Contract();
        contract.setContractId(contractId);
        contract=contractService.query(contract,null,null).getList().get(0);
        model.addAttribute("contract",contract);
        containsInformation(model);
        return "contract/edit";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public StateType update(@RequestBody Contract contract){
        StateType stateType=contractService.update(contract);
        return stateType;
    }

    @RequestMapping("/invalid/{contractId}")
    @ResponseBody
    public StateType invalid(@PathVariable("contractId")int contractId){
        StateType stateType=contractService.invalid(contractId);
        return stateType;
    }

    @RequestMapping("/confirm/{contractId}")
    @ResponseBody
    public StateType confirm(@PathVariable("contractId")int contractId){
        StateType stateType=contractService.confirm(contractId);
        return stateType;
    }

    @RequestMapping("/archive/{contractId}")
    @ResponseBody
    public StateType archive(@PathVariable("contractId")int contractId){
        StateType stateType=contractService.archive(contractId);
        return stateType;
    }

}
