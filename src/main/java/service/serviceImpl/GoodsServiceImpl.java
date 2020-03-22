package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.GoodTypeNameDto;
import mapper.GoodsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import pojo.Goods;
import pojo.Location;
import pojo.Warehouse;
import service.GoodsService;

import java.util.Date;
import java.util.List;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    GoodsMapper goodsMapper;
    @Override
    public PageInfo<Goods> queryGoodTypeName(GoodTypeNameDto goodTypeNameDto) {
        //防止导出功能没有分页的需求
        Integer page = goodTypeNameDto.getPage();
        Integer limit = goodTypeNameDto.getLimit();
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Goods> list=goodsMapper.queryGoodTypeName(goodTypeNameDto);
        PageInfo<Goods> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Goods> queryAllGoodsType() {
        return goodsMapper.queryAllGoodsType();
    }

    @Override
    public PageInfo<Goods> queryAllGoodsName() {
        List<Goods> list=goodsMapper.queryAllGoodsName();
        PageInfo<Goods> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType addGoodType(Goods goodsType, Employee employee) {
        goodsType.setCreatedBy(employee.getEmployeeId());
        goodsType.setCreateTime(new Date());
        goodsType.setClassify(1);
        int addRow=goodsMapper.addGoodType(goodsType);
        if(addRow==1)
            return StateType.getStateType(22);
        return StateType.getStateType(23);
    }

    @Override
    public StateType updateGoodType(Goods goodsType, Employee employee) {
        goodsType.setCreatedBy(employee.getEmployeeId());
        goodsType.setCreateTime(new Date());
        int updateRow=goodsMapper.updateGoodType(goodsType);
        if(updateRow==1)
            return StateType.getStateType(20);
        return StateType.getStateType(21);
    }

    @Override
    public StateType addGoodsName(Goods goodsName, Employee employee) {
        goodsName.setCreatedBy(employee.getEmployeeId());
        goodsName.setCreateTime(new Date());
        goodsName.setClassify(2);
        int addRow=goodsMapper.addGoodsName(goodsName);
        if(addRow==1)
            return StateType.getStateType(22);
        return StateType.getStateType(23);
    }

    @Override
    public StateType updateGoodsName(Goods goodsName, Employee employee) {
        goodsName.setCreatedBy(employee.getEmployeeId());
        goodsName.setCreateTime(new Date());
        int updateRow=goodsMapper.updateGoodsName(goodsName);
        if(updateRow==1)
            return StateType.getStateType(20);
        return StateType.getStateType(21);
    }

    @Override
    public StateType delGoodsType(int goodsTypeId) {
        //首先删除货物类型下的所有货物名称，防止外键约束不可删除
        goodsMapper.delGoodsNameByTypeId(goodsTypeId);
        //然后再删除货物类型
        int delRow=goodsMapper.delGoodsType(goodsTypeId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public StateType delGoodsName(int goodsNameId) {
        int delRow=goodsMapper.delGoodsName(goodsNameId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

}
