package service;

import pojo.ContractExpense;

import java.util.List;

public interface ContractExpenseService {
    List<ContractExpense> queryByContractId(Integer contractId);
}
