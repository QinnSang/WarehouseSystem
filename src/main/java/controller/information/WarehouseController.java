package controller.information;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.Contract;
import pojo.Location;
import pojo.Warehouse;
import service.WarehouseService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

    @Autowired
    WarehouseService warehouseService;

    @RequestMapping("/index")
    public String index(){
        return "information/warehouse/index";
    }

    @RequestMapping("/queryWarehouse")
    @ResponseBody
    public Map<String,Object> queryWarehouse(@ModelAttribute Warehouse warehouse, @RequestParam Integer page, @RequestParam Integer limit){
        PageInfo<Warehouse> pageInfo=warehouseService.queryWarehouse(warehouse,page,limit);
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

    @RequestMapping("/queryLocationByWarehouseId/{warehouseId}")
    @ResponseBody
    public Map<String,Object> queryLocationByWarehouseId(@PathVariable("warehouseId")int warehouseId){
        Location location =new Location();
        location.setWarehouseId(warehouseId);
        List<Location> locationList=warehouseService.queryLocationByWarehouseId(location);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", locationList);
        return tableData;
    }
}
