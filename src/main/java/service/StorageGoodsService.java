package service;

import com.github.pagehelper.PageInfo;
import pojo.Goods;
import pojo.Location;
import pojo.StorageGoods;
import pojo.Warehouse;

import java.util.List;

public interface StorageGoodsService {
    PageInfo<StorageGoods> queryGoodsNumberByStorageId(int storageId, Integer page, Integer limit);

    List<Goods> queryGoodsTypeByStorage(int storageId);

    List<Goods> queryNameByTypeStorage(StorageGoods storageGoods);

    List<Warehouse> queryWarehouseByGoods(StorageGoods storageGoods);

    List<Location> queryLocationByGoods(StorageGoods storageGoods);

    Double queryGoodsNumber(StorageGoods storageGoods);
}
