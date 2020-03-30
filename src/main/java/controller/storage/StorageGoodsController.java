package controller.storage;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.Goods;
import pojo.Location;
import pojo.StorageGoods;
import pojo.Warehouse;
import service.StorageGoodsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/storageGoods")
public class StorageGoodsController {

    @Autowired
    StorageGoodsService storageGoodsService;

    //根据仓储订单查找货物库存
    @RequestMapping("/queryGoodsNumberByStorageId/{storageId}")
    @ResponseBody
    public Map<String,Object> queryGoodsNumberByStorageId(@PathVariable int storageId, @RequestParam Integer page, @RequestParam Integer limit){
        PageInfo<StorageGoods> pageInfo=storageGoodsService.queryGoodsNumberByStorageId(storageId,page,limit);
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

    //根据仓储订单查找货物类型
    @RequestMapping("/queryGoodsTypeByStorage/{storageId}")
    @ResponseBody
    public List<Goods> queryGoodsTypeByStorage(@PathVariable("storageId") int storageId){
        return storageGoodsService.queryGoodsTypeByStorage(storageId);
    }

    //根据仓储订单和货物类型查找货物名称
    @RequestMapping("/queryNameByTypeStorage")
    @ResponseBody
    public List<Goods> queryNameByTypeStorage(@ModelAttribute StorageGoods storageGoods){
        return storageGoodsService.queryNameByTypeStorage(storageGoods);
    }

    //根据所选货物名称加载货物存放的仓库
    @RequestMapping("/queryWarehouseByGoods")
    @ResponseBody
    public List<Warehouse> queryWarehouseByGoods(@ModelAttribute StorageGoods storageGoods){
        return storageGoodsService.queryWarehouseByGoods(storageGoods);
    }

    //根据仓储订单和货物类型查找货物名称
    @RequestMapping("/queryLocationByGoods")
    @ResponseBody
    public List<Location> queryLocationByGoods(@ModelAttribute StorageGoods storageGoods){
        return storageGoodsService.queryLocationByGoods(storageGoods);
    }

    //查找仓储订单的位置货物库存
    @RequestMapping("/queryGoodsNumber")
    @ResponseBody
    public Double queryGoodsNumber(@ModelAttribute StorageGoods storageGoods){
        return storageGoodsService.queryGoodsNumber(storageGoods);
    }


}
