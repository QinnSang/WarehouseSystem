package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.Location;
import pojo.Warehouse;

import java.util.List;

public interface WarehouseMapper {
    List<Warehouse> queryWarehouse(Warehouse warehouse);

    List<Location> queryLocationByWarehouseId(Location location);
}
