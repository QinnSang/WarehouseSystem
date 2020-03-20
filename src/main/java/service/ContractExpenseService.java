package service;

import pojo.ContractExpense;
import pojo.DataDictionary;

import java.util.List;

public interface ContractExpenseService {
    List<ContractExpense> queryByContractId(Integer contractId);

    List<DataDictionary> queryAllExpense();
}
