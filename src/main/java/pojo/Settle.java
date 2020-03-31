package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class Settle {
    private Integer settleId;

    private String settleCode;

    private String settleName;

    private Integer storageId;

    private Storage storage;

    private Double totalPrice;

    private Integer checkBy;

    private Employee checkByUser;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date checkStartDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date checkEndDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date checkDate;

    private Integer status;

    private DataDictionary checkStatus;

    private Date createDate;

    private Integer createBy;

    private Employee createByUser;

    private List<ExpenseDetail> expenseDetailList;

    public Integer getSettleId() {
        return settleId;
    }

    public void setSettleId(Integer settleId) {
        this.settleId = settleId;
    }

    public String getSettleCode() {
        return settleCode;
    }

    public void setSettleCode(String settleCode) {
        this.settleCode = settleCode == null ? null : settleCode.trim();
    }

    public String getSettleName() {
        return settleName;
    }

    public void setSettleName(String settleName) {
        this.settleName = settleName == null ? null : settleName.trim();
    }

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Integer getCheckBy() {
        return checkBy;
    }

    public void setCheckBy(Integer checkBy) {
        this.checkBy = checkBy;
    }

    public Date getCheckStartDate() {
        return checkStartDate;
    }

    public void setCheckStartDate(Date checkStartDate) {
        this.checkStartDate = checkStartDate;
    }

    public Date getCheckEndDate() {
        return checkEndDate;
    }

    public void setCheckEndDate(Date checkEndDate) {
        this.checkEndDate = checkEndDate;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public DataDictionary getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(DataDictionary checkStatus) {
        this.checkStatus = checkStatus;
    }

    public Employee getCreateByUser() {
        return createByUser;
    }

    public void setCreateByUser(Employee createByUser) {
        this.createByUser = createByUser;
    }

    public Employee getCheckByUser() {
        return checkByUser;
    }

    public void setCheckByUser(Employee checkByUser) {
        this.checkByUser = checkByUser;
    }

    public List<ExpenseDetail> getExpenseDetailList() {
        return expenseDetailList;
    }

    public void setExpenseDetailList(List<ExpenseDetail> expenseDetailList) {
        this.expenseDetailList = expenseDetailList;
    }
}