package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Contract;
import pojo.Storage;
import pojo.StorageGoods;

import java.util.List;
import java.util.Map;

@Mapper
public interface StorageMapper {
    List<Storage> query(Storage storage);

    void generateStorageCode(Map<String, String> params);

    int add(Storage storage);

    List<StorageGoods> queryGoodsNumberByStorageId(@Param("storageId") int storageId);

    Storage queryStatusByContractId(@Param("storageId")int storageId);

    int updateStatus(Storage storage);
}
