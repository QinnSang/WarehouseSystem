package mapper;

import dto.WarehouseLocationDto;
import org.apache.ibatis.annotations.Param;
import pojo.Location;
import pojo.Warehouse;

import java.util.List;

public interface WarehouseMapper {
    List<Warehouse> queryWarehouseLocation(WarehouseLocationDto warehouseLocationDto);

    List<Warehouse> queryAllWarehouse();

    List<Location> queryLocationByWarehouseId(@Param("warehouseId") int warehouseId);

    int addWarehouse(Warehouse warehouse);

    int updateWarehouse(Warehouse warehouse);

    int delWarehouse(@Param("warehouseId") int warehouseId);

    int addLocation(Location location);

    int updateLocation(Location location);

    int delLocation(@Param("locationId")int locationId);

    int delLocationByWarehouseId(@Param("warehouseId") int warehouseId);

    List<Location> queryAllLocation();


}
