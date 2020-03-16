package pojo;

import java.util.Date;

public class ExpenseDetail {
    private Integer expenseDetailId;

    private Integer orderId;

    private Integer orderType;

    private String expenseName;

    private Integer amount;

    private Double price;

    private Integer contractId;

    private Integer storageId;

    private Integer checkStatus;

    private String remark;

    private String createByname;

    private Date createDate;

    private String checkByname;

    private Date checkDate;

    public Integer getExpenseDetailId() {
        return expenseDetailId;
    }

    public void setExpenseDetailId(Integer expenseDetailId) {
        this.expenseDetailId = expenseDetailId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public String getExpenseName() {
        return expenseName;
    }

    public void setExpenseName(String expenseName) {
        this.expenseName = expenseName == null ? null : expenseName.trim();
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
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

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
    }

    public Integer getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(Integer checkStatus) {
        this.checkStatus = checkStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getCreateByname() {
        return createByname;
    }

    public void setCreateByname(String createByname) {
        this.createByname = createByname == null ? null : createByname.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCheckByname() {
        return checkByname;
    }

    public void setCheckByname(String checkByname) {
        this.checkByname = checkByname == null ? null : checkByname.trim();
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }
}