package pojo;

import java.util.Date;

public class ExpenseDetail {
    private Integer expenseDetailId;

    private Integer orderId;

    private Shipping shipping;

    private Receiving receiving;

    private Integer orderType;

    private DataDictionary expenseOrderType;

    private Integer expenseId;

    private String expenseName;

    private Integer amount;

    private Double price;

    private Integer storageId;

    private Storage storage;

    private Integer checkStatus;

    private DataDictionary checkStatusData;

    private String remark;

    private Integer isConfirm;

    private Date createDate;

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

    public DataDictionary getCheckStatusData() {
        return checkStatusData;
    }

    public void setCheckStatusData(DataDictionary checkStatusData) {
        this.checkStatusData = checkStatusData;
    }

    public Employee getCheckByUser() {
        return checkByUser;
    }

    public void setCheckByUser(Employee checkByUser) {
        this.checkByUser = checkByUser;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getIsConfirm() {
        return isConfirm;
    }

    public void setIsConfirm(Integer isConfirm) {
        this.isConfirm = isConfirm;
    }

    public Shipping getShipping() {
        return shipping;
    }

    public void setShipping(Shipping shipping) {
        this.shipping = shipping;
    }

    public Receiving getReceiving() {
        return receiving;
    }

    public void setReceiving(Receiving receiving) {
        this.receiving = receiving;
    }

    public DataDictionary getExpenseOrderType() {
        return expenseOrderType;
    }

    public void setExpenseOrderType(DataDictionary expenseOrderType) {
        this.expenseOrderType = expenseOrderType;
    }

    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }
}