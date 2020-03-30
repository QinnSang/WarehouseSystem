package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.*;

import java.util.List;

@Mapper
public interface StorageGoodsMappper {
    StorageGoods queryGoods(StorageGoods storageGoods);

    int add(StorageGoods storageGoods);

    int update(StorageGoods storageGoods);

    List<StorageGoods> queryGoodsNumberByStorageId(@Param("storageId") int storageId);

    List<Goods> queryGoodsTypeByStorage(@Param("storageId") int storageId);

    List<Goods> queryNameByTypeStorage(StorageGoods storageGoods);

    List<Location> queryLocationByGoods(StorageGoods storageGoods);

    List<Warehouse> queryWarehouseByGoods(StorageGoods storageGoods);
}
