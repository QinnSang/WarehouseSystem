package controller.information;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.WarehouseLocationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.Employee;
import pojo.Goods;
import pojo.Location;
import pojo.Warehouse;
import service.WarehouseService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

    @Autowired
    WarehouseService warehouseService;

    @RequestMapping("/index")
    public String index(Model model){
        List<Warehouse> warehouseList=warehouseService.queryAllWarehouse();
        model.addAttribute("warehouseList",warehouseList);
        return "information/warehouse";
    }

    //查询仓库库位信息
    @RequestMapping("/queryWarehouseLocation")
    @ResponseBody
    public Map<String,Object> queryWarehouseLocation(@ModelAttribute WarehouseLocationDto warehouseLocationDto,Integer page, Integer limit){
        warehouseLocationDto.setLimit(limit);
        warehouseLocationDto.setPage(page);
        PageInfo<Warehouse> pageInfo=warehouseService.queryWarehouseLocation(warehouseLocationDto);
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

    //查询所有库位信息，用于导出库位表
    @RequestMapping("/queryAllLocation")
    @ResponseBody
    public Map<String,Object> queryAllLocation(){
        PageInfo<Location> pageInfo=warehouseService.queryAllLocation();
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    //根据仓库查找所属库位名称
    @RequestMapping("/queryLocationByWarehouseId/{warehouseId}")
    @ResponseBody
    public List<Location> queryLocationByWarehouseId(@PathVariable int warehouseId){
        List<Location> locationList=warehouseService.queryLocationByWarehouseId(warehouseId);
        return locationList;
    }


    @RequestMapping("/warehouseInfo")
    @ResponseBody
    public StateType warehouseInfo(@ModelAttribute Warehouse warehouse, String warehouseType,HttpSession session){
        if(warehouseType.equals("insert")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=warehouseService.addWarehouse(warehouse,employee);
            return stateType;
        } else if(warehouseType.equals("update")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=warehouseService.updateWarehouse(warehouse,employee);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    @RequestMapping("/locationInfo")
    @ResponseBody
    public StateType locationInfo(@ModelAttribute Location location, String locationType,HttpSession session){
        if(locationType.equals("insert")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=warehouseService.addLocation(location,employee);
            return stateType;
        } else if(locationType.equals("update")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=warehouseService.updateLocation(location,employee);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    @RequestMapping("/delWarehouse")
    @ResponseBody
    public StateType delWarehouse(@RequestParam int warehouseId){
        StateType stateType=warehouseService.delWarehouse(warehouseId);
        return stateType;
    }

    @RequestMapping("/delLocation")
    @ResponseBody
    public StateType delLocation(@RequestParam int locationId){
        StateType stateType=warehouseService.delLocation(locationId);
        return stateType;
    }


}
