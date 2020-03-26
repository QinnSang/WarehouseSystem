package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.WarehouseLocationDto;
import pojo.Employee;
import pojo.Location;
import pojo.Warehouse;

import java.util.List;

public interface WarehouseService {
     PageInfo<Warehouse> queryWarehouseLocation(WarehouseLocationDto warehouseLocationDto) ;

    StateType addWarehouse(Warehouse warehouse, Employee employee);

    StateType addLocation(Location location, Employee employee);

    List<Warehouse> queryAllWarehouse();

    StateType updateWarehouse(Warehouse warehouse, Employee employee);

    StateType delWarehouse(int warehouseId);

    StateType updateLocation(Location location, Employee employee);

    StateType delLocation(int locationId);

    PageInfo<Location> queryAllLocation();

    List<Location> queryLocationByWarehouseId(int warehouseId);
}
