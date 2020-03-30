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

    Map generateStorageCode(Map<String, String> params);

    int add(Storage storage);

    Storage queryStatusByContractId(@Param("storageId")int storageId);

    int updateStatus(Storage storage);

    List<Storage> queryAllValidStorage();
}
