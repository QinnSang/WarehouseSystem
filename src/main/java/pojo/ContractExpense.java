package pojo;

import java.util.Date;

public class ContractExpense {
    private Integer expenseId;

    private Integer expenseDictionaryValueId;

    private DataDictionary expenseDictionary;

    private Double price;

    private Integer contractId;

    private Contract contract;

    private String remark;

    public Integer getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(Integer expenseId) {
        this.expenseId = expenseId;
    }

    public Integer getExpenseDictionaryValueId() {
        return expenseDictionaryValueId;
    }

    public void setExpenseDictionaryValueId(Integer expenseDictionaryValueId) {
        this.expenseDictionaryValueId = expenseDictionaryValueId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getContractId() {
        return contractId;
    }

    public void setContractId(Integer contractId) {
        this.contractId = contractId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public DataDictionary getExpenseDictionary() {
        return expenseDictionary;
    }

    public void setExpenseDictionary(DataDictionary expenseDictionary) {
        this.expenseDictionary = expenseDictionary;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

}