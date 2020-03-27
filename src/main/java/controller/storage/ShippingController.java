package controller.storage;

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
@RequestMapping("/shipping")
public class ShippingController {

    @Autowired
    ShippingService shippingService;

    @Autowired
    StorageService storageService;

    @Autowired
    WarehouseService warehouseService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    ContractExpenseService contractExpenseService;

    @RequestMapping("/index")
    public String index(){
        return "storage/shipping/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(@ModelAttribute Shipping shipping, Integer page, Integer limit){
        PageInfo<Shipping> pageInfo=shippingService.query(shipping,page,limit);
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
        model.addAttribute("storageList",storageList);
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        containsInformation(model);
        return "storage/shipping/add";
    }

    @RequestMapping("/toAdd/{storageId}")
    public String toAddByStorage(@PathVariable("storageId")int storageId,  Model model){
        model.addAttribute("storageId",storageId);
        containsInformation(model);
        return "storage/shipping/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public StateType add(@RequestBody Shipping shipping, HttpSession session){
        Employee employee= (Employee) session.getAttribute("employee");
        StateType stateType=shippingService.add(shipping,employee);
        return stateType;
    }

    @RequestMapping("/toEdit/{shippingId}")
    public String toEdit(@PathVariable("shippingId")int shippingId, Model model) {
        Shipping shipping = new Shipping();
        shipping.setShippingId(shippingId);
        shipping = shippingService.query(shipping, null, null).getList().get(0);
        model.addAttribute("shipping", shipping);
        containsInformation(model);
        return "storage/shipping/edit";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public StateType update(@RequestBody Shipping shipping,Employee employee){
        StateType stateType=shippingService.update(shipping,employee);
        return stateType;
    }


    @RequestMapping("/confirm")
    @ResponseBody
    public StateType confirm(@ModelAttribute Shipping shipping){
        StateType stateType=shippingService.confirm(shipping);
        return stateType;
    }

    @RequestMapping("/del")
    @ResponseBody
    public StateType del( @ModelAttribute Shipping shipping){
        StateType stateType=shippingService.del(shipping);
        return stateType;
    }

}
