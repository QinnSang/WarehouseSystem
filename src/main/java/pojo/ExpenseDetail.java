package pojo;

import java.util.Date;

public class ExpenseDetail {
    private Integer expenseDetailId;

    private Integer orderId;

    private Integer orderType;

    private Integer expenseId;

    private String expenseName;

    private Integer amount;

    private Double price;

    private Integer storageId;

    private Integer checkStatus;

    private DataDictionary receivingCheckStatus;

    private String remark;

    private Integer checkBy;

    private Employee checkByUser;

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

    public Integer getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(Integer expenseId) {
        this.expenseId = expenseId;
    }

    public String getExpenseName() {
        return expenseName;
    }

    public void setExpenseName(String expenseName) {
        this.expenseName = expenseName;
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

    public Integer getCheckBy() {
        return checkBy;
    }

    public void setCheckBy(Integer checkBy) {
        this.checkBy = checkBy;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public DataDictionary getReceivingCheckStatus() {
        return receivingCheckStatus;
    }

    public void setReceivingCheckStatus(DataDictionary receivingCheckStatus) {
        this.receivingCheckStatus = receivingCheckStatus;
    }

    public Employee getCheckByUser() {
        return checkByUser;
    }

    public void setCheckByUser(Employee checkByUser) {
        this.checkByUser = checkByUser;
    }
}