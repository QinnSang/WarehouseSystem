package controller.storage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.*;
import service.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/receiving")
public class ReceivingController {

    @Autowired
    ReceivingService receivingService;

    @Autowired
    StorageService storageService;

    @Autowired
    WarehouseService warehouseService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    ContractExpenseService contractExpenseService;

    @Autowired
    LogService logService;

    @RequestMapping("/index")
    public String index(){
        return "storage/receiving/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Receiving receiving, Integer page, Integer limit){
        PageInfo<Receiving> pageInfo=receivingService.query(receiving,page,limit);
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
        //获取所有仓储订单
        List<Storage> storageList=storageService.queryAllValidStorage();
        //获取所有仓库
        List<Warehouse> warehouseList=warehouseService.queryAllWarehouse();
        //获取所有货物类型
        List<Goods> goodsTypeList = goodsService.queryAllGoodsType();
        model.addAttribute("storageList",storageList);
        model.addAttribute("warehouseList",warehouseList);
        model.addAttribute("goodsTypeList",goodsTypeList);
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        containsInformation(model);
        return "storage/receiving/add";
    }

    @RequestMapping("/toAdd/{storageId}")
    public String toAddByStorage(@PathVariable("storageId")int storageId,  Model model){
        model.addAttribute("storageId",storageId);
        containsInformation(model);
        return "storage/receiving/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public StateType add(@RequestBody Receiving receiving, HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=receivingService.add(receiving,employee);
        return stateType;
    }

    @RequestMapping("/toEdit/{receivingId}")
    public String toEdit(@PathVariable("receivingId")int receivingId, Model model){
        Receiving receiving = new Receiving();
        receiving.setReceivingId(receivingId);
         receiving=receivingService.query(receiving,null,null).getList().get(0);
         model.addAttribute("receiving",receiving);
        containsInformation(model);
        return "storage/receiving/edit";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public StateType update(@RequestBody Receiving receiving,Employee employee){
        StateType stateType=receivingService.update(receiving,employee);
        return stateType;
    }

    @RequestMapping("/confirm")
    @ResponseBody
    public StateType confirm(@ModelAttribute Receiving receiving){
        StateType stateType=receivingService.confirm(receiving);
        if(stateType == StateType.getStateType(28)){
            //只有审核通过才可增加出库日志记录
            logService.addReceivingLog(receiving.getStorageId(),receiving.getReceivingId());
        }
        return stateType;
    }

    @RequestMapping("/del")
    @ResponseBody
    public StateType del( @ModelAttribute Receiving receiving){
        StateType stateType=receivingService.del(receiving);
        return stateType;
    }


}
