package service.serviceImpl;

import mapper.ContractExpenseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.ContractExpense;
import service.ContractExpenseService;

import java.util.List;

@Service("contractExpenseService")
public class ContractExpenseServiceImpl implements ContractExpenseService {

    @Autowired
    ContractExpenseMapper contractExpenseMapper;
    @Override
    public List<ContractExpense> queryByContractId(Integer contractId) {

        return contractExpenseMapper.queryByContractId(contractId);
    }
}
