package service;

import com.github.pagehelper.PageInfo;
import pojo.Location;
import pojo.Warehouse;

import java.util.List;

public interface WarehouseService {
     PageInfo<Warehouse> queryWarehouse(Warehouse warehouse, Integer page, Integer limit) ;

    List<Location> queryLocationByWarehouseId(Location location);
}
