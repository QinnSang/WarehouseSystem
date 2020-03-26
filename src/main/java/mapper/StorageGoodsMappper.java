package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.Receiving;
import pojo.StorageGoods;

@Mapper
public interface StorageGoodsMappper {
    StorageGoods queryGoods(StorageGoods storageGoods);

    int add(StorageGoods storageGoods);

    int update(StorageGoods storageGoods);
}
