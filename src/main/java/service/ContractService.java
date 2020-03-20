package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Contract;
import pojo.Employee;

public interface ContractService {

    PageInfo<Contract> query(Contract contract, Integer page, Integer limit);

    StateType add(Contract contract, Employee employee);

    StateType update(Contract contract);

    StateType invalid(int contractId);

    StateType confirm(int contractId);

    StateType archive(int contractId);
}
