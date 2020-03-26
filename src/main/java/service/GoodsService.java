package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.GoodTypeNameDto;
import pojo.Employee;
import pojo.Goods;

import java.util.List;

public interface GoodsService {
    PageInfo<Goods> queryGoodTypeName(GoodTypeNameDto goodTypeNameDto);

    List<Goods> queryAllGoodsType();

    PageInfo<Goods> queryAllGoodsName();

    StateType addGoodType(Goods goodsType, Employee employee);

    StateType updateGoodType(Goods goodsType, Employee employee);

    StateType addGoodsName(Goods goodsName, Employee employee);

    StateType updateGoodsName(Goods goodsName, Employee employee);

    StateType delGoodsType(int goodsTypeId);

    StateType delGoodsName(int goodsNameId);

    List<Goods> queryNameByType(int goodsTypeId);
}
