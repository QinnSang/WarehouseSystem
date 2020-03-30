package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Employee;
import pojo.Shipping;
import pojo.StorageGoods;

public interface ShippingService {
    PageInfo<Shipping> query(Shipping shipping, Integer page, Integer limit);

    StateType add(Shipping shipping, Employee employee);

    StateType confirm(Shipping shipping);

    StateType del(Shipping shipping);

    StateType update(Shipping shipping, Employee employee);
}
