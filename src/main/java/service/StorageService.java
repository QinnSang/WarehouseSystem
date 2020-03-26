package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Contract;
import pojo.Employee;
import pojo.Storage;
import pojo.StorageGoods;

import java.util.List;

public interface StorageService {
    PageInfo<Storage> query(Storage storage, Integer page, Integer limit);

    StateType add(Storage storage, Employee employee);

    PageInfo<StorageGoods> queryGoodsNumberByStorageId(int storageId, Integer page, Integer limit);

    StateType invalid(int storageId);

    StateType confirm(int storageId);

    StateType archive(int storageId);

    List<Storage> queryAllValidStorage();
}
