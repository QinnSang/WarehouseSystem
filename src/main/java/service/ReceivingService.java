package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Employee;
import pojo.Receiving;

public interface ReceivingService {
    PageInfo<Receiving> query(Receiving receiving, Integer page, Integer limit);

    StateType add(Receiving receiving, Employee employee);

    StateType update(Receiving receiving, Employee employee);

    StateType confirm(Receiving receiving);

    StateType del(int receivingId);
}
