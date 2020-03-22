package mapper;

import dto.GoodTypeNameDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Goods;

import java.util.List;

@Mapper
public interface GoodsMapper {
    List<Goods> queryGoodTypeName(GoodTypeNameDto goodTypeNameDto);

    List<Goods> queryAllGoodsType();

    List<Goods> queryAllGoodsName();

    int addGoodType(Goods goodsType);

    int updateGoodType(Goods goodsType);

    int addGoodsName(Goods goodsName);

    int updateGoodsName(Goods goodsName);

    void delGoodsNameByTypeId(@Param("goodsTypeId") int goodsTypeId);

    int delGoodsType(@Param("goodsTypeId")int goodsTypeId);

    int delGoodsName(@Param("goodsNameId")int goodsNameId);
}
