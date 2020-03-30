package service.serviceImpl;

import com.github.pagehelper.PageInfo;
import mapper.StorageGoodsMappper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Goods;
import pojo.Location;
import pojo.StorageGoods;
import pojo.Warehouse;
import service.StorageGoodsService;

import java.util.List;

@Service("storageGoodsService")
public class StorageGoodsServiceImpl implements StorageGoodsService {

    @Autowired
    StorageGoodsMappper storageGoodsMappper;

    @Override
    public PageInfo<StorageGoods> queryGoodsNumberByStorageId(int storageId, Integer page, Integer limit) {
        List<StorageGoods> list=storageGoodsMappper.queryGoodsNumberByStorageId(storageId);
        PageInfo<StorageGoods> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Goods> queryGoodsTypeByStorage(int storageId) {
        return storageGoodsMappper.queryGoodsTypeByStorage(storageId);
    }

    @Override
    public List<Goods> queryNameByTypeStorage(StorageGoods storageGoods) {
        return storageGoodsMappper.queryNameByTypeStorage(storageGoods);
    }

    @Override
    public List<Warehouse> queryWarehouseByGoods(StorageGoods storageGoods) {
        return storageGoodsMappper.queryWarehouseByGoods(storageGoods);
    }

    @Override
    public List<Location> queryLocationByGoods(StorageGoods storageGoods) {
        return storageGoodsMappper.queryLocationByGoods(storageGoods);
    }

    @Override
    public Double queryGoodsNumber(StorageGoods storageGoods) {
        storageGoods = storageGoodsMappper.queryGoods(storageGoods);
        if (storageGoods == null )
            return 0.0;
        else
            return storageGoods.getGoodsNumber();
    }

}
