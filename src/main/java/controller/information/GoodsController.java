package controller.information;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.GoodTypeNameDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pojo.Employee;
import pojo.Goods;
import pojo.Location;
import pojo.Warehouse;
import service.GoodsService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    GoodsService goodsService;

    @RequestMapping("/index")
    public String index(Model model){
        List<Goods> goodsTypeList=goodsService.queryAllGoodsType();
        model.addAttribute("goodsTypeList",goodsTypeList);
        return "information/goods";
    }

    //查询货物类型、货物名称信息
    @RequestMapping("/queryGoodTypeName")
    @ResponseBody
    public Map<String,Object> queryGoodTypeName(@ModelAttribute GoodTypeNameDto goodTypeNameDto, Integer page, Integer limit){
        goodTypeNameDto.setLimit(limit);
        goodTypeNameDto.setPage(page);
        PageInfo<Goods> pageInfo=goodsService.queryGoodTypeName(goodTypeNameDto);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    //查询所有货物名称信息，用于导出货物名称表
    @RequestMapping("/queryAllGoodsName")
    @ResponseBody
    public Map<String,Object> queryAllGoodsName(){
        PageInfo<Goods> pageInfo=goodsService.queryAllGoodsName();
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    //根据类型查找货物名称
    @RequestMapping("/queryNameByType/{goodsTypeId}")
    @ResponseBody
    public List<Goods> queryNameByType(@PathVariable("goodsTypeId") int goodsTypeId){
        return goodsService.queryNameByType(goodsTypeId);
    }


    //货物类型维护
    @RequestMapping("/goodsTypeInfo")
    @ResponseBody
    public StateType goodsTypeInfo(@ModelAttribute Goods goodsType, String goodsTypeType, HttpSession session){
        if(goodsTypeType.equals("insert")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=goodsService.addGoodType(goodsType,employee);
            return stateType;
        } else if(goodsTypeType.equals("update")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=goodsService.updateGoodType(goodsType,employee);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    //货物名称信息维护
    @RequestMapping("/goodsNameInfo")
    @ResponseBody
    public StateType goodsNameInfo(@ModelAttribute Goods goodsName, String goodsNameType, HttpSession session){
        if(goodsNameType.equals("insert")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=goodsService.addGoodsName(goodsName,employee);
            return stateType;
        } else if(goodsNameType.equals("update")){
            Employee employee= (Employee) session.getAttribute("employee");
            StateType stateType=goodsService.updateGoodsName(goodsName,employee);
            return stateType;
        }else
            return StateType.getStateType(34);
    }

    @RequestMapping("/delGoodsType")
    @ResponseBody
    public StateType delGoodsType(@RequestParam int goodsTypeId){
        StateType stateType=goodsService.delGoodsType(goodsTypeId);
        return stateType;
    }

    @RequestMapping("/delGoodsName")
    @ResponseBody
    public StateType delGoodsName(@RequestParam int goodsNameId){
        StateType stateType=goodsService.delGoodsName(goodsNameId);
        return stateType;
    }

}
