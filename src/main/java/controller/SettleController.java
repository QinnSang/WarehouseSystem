package controller;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.SettleDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.*;
import service.SettleService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/settle")
public class SettleController {

    @Autowired
    SettleService settleService;

    @RequestMapping("/index")
    public String index(){
        return "settle/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Settle Settle, Integer page, Integer limit){
        PageInfo<Settle> pageInfo=settleService.query(Settle,page,limit);
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

    @RequestMapping("/addStatement")
    @ResponseBody
    public StateType addStatement(@ModelAttribute SettleDto settleDto, HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=settleService.addStatement(settleDto,employee);
        return stateType;
    }

    @RequestMapping("/del")
    @ResponseBody
    public StateType del(@ModelAttribute Settle settle){
        StateType stateType=settleService.del(settle);
        return stateType;
    }

    @RequestMapping("/settleStatement")
    @ResponseBody
    public StateType settleStatement(@ModelAttribute Settle settle, HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=settleService.settleStatement(settle, employee);
        return stateType;
    }

    @RequestMapping("/queryStatement")
    @ResponseBody
    public Map<String,Object> queryStatement(@ModelAttribute Settle Settle, Integer page, Integer limit){
        PageInfo<ExpenseDetail> pageInfo=settleService.queryStatement(Settle,page,limit);
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

}
