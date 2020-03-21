package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.WarehouseLocationDto;
import mapper.WarehouseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Contract;
import pojo.Employee;
import pojo.Location;
import pojo.Warehouse;
import service.WarehouseService;

import java.util.Date;
import java.util.List;

@Service("warehouseService")
public class WarehouseServiceImpl implements WarehouseService {

    @Autowired
    WarehouseMapper warehouseMapper;

    @Override
    public PageInfo<Warehouse> queryWarehouseLocation(WarehouseLocationDto warehouseLocationDto) {
        //防止导出功能没有分页的需求
        Integer page = warehouseLocationDto.getPage();
        Integer limit = warehouseLocationDto.getLimit();
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Warehouse> list=warehouseMapper.queryWarehouseLocation(warehouseLocationDto);
        PageInfo<Warehouse> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Location> queryAllLocation() {
        //防止导出功能没有分页的需求
        List<Location> list=warehouseMapper.queryAllLocation();
        PageInfo<Location> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Warehouse> queryAllWarehouse() {
        return warehouseMapper.queryAllWarehouse();
    }

    @Override
    public StateType addWarehouse(Warehouse warehouse, Employee employee) {
        warehouse.setCreateBy(employee.getEmployeeId());
        warehouse.setCreateTime(new Date());
        int addRow=warehouseMapper.addWarehouse(warehouse);
        if(addRow==1)
            return StateType.getStateType(22);
        return StateType.getStateType(23);
    }

    @Override
    public StateType updateWarehouse(Warehouse warehouse, Employee employee) {
        warehouse.setCreateBy(employee.getEmployeeId());
        warehouse.setCreateTime(new Date());
        int updateRow=warehouseMapper.updateWarehouse(warehouse);
        if(updateRow==1)
            return StateType.getStateType(20);
        return StateType.getStateType(21);
    }

    @Override
    public StateType delWarehouse(int warehouseId) {
        //首先删除仓库下的所有库位，防止外键约束不可删除
        warehouseMapper.delLocationByWarehouseId(warehouseId);
        //然后再删除仓库
        int delRow=warehouseMapper.delWarehouse(warehouseId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public StateType addLocation(Location location, Employee employee) {
        location.setCreateBy(employee.getEmployeeId());
        location.setCreateTime(new Date());
        int addRow=warehouseMapper.addLocation(location);
        if(addRow==1)
            return StateType.getStateType(22);
        return StateType.getStateType(23);
    }

    @Override
    public StateType updateLocation(Location location, Employee employee) {
        location.setCreateBy(employee.getEmployeeId());
        location.setCreateTime(new Date());
        int updateRow=warehouseMapper.updateLocation(location);
        if(updateRow==1)
            return StateType.getStateType(20);
        return StateType.getStateType(21);
    }

    @Override
    public StateType delLocation(int locationId) {
        int delRow=warehouseMapper.delLocation(locationId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

}
