package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import mapper.WarehouseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Contract;
import pojo.Location;
import pojo.Warehouse;
import service.WarehouseService;

import java.util.List;

@Service("warehouseService")
public class WarehouseServiceImpl implements WarehouseService {

    @Autowired
    WarehouseMapper warehouseMapper;

    @Override
    public PageInfo<Warehouse> queryWarehouse(Warehouse warehouse, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Warehouse> list=warehouseMapper.queryWarehouse(warehouse);
        PageInfo<Warehouse> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Location> queryLocationByWarehouseId(Location location) {
        return warehouseMapper.queryLocationByWarehouseId(location);
    }


}
