package service;

import com.github.pagehelper.PageInfo;
import pojo.Contract;

public interface ContractService {

    PageInfo<Contract> query(Contract contract, Integer page, Integer limit);
}
