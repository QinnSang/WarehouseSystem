package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Storage {
    private Integer storageId;

    private String storageName;

    private String storageCode;

    private Double goodsNumber;

    private Integer contractId;

    private Contract contract;

    private Integer status;

    private DataDictionary storageStatus;

    private Integer createBy;

    private Employee createByUser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    private String remark;

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
    }

    public String getStorageName() {
        return storageName;
    }

    public void setStorageName(String storageName) {
        this.storageName = storageName == null ? null : storageName.trim();
    }

    public String getStorageCode() {
        return storageCode;
    }

    public void setStorageCode(String storageCode) {
        this.storageCode = storageCode == null ? null : storageCode.trim();
    }

    public Double getGoodsNumber() {
        return goodsNumber;
    }

    public void setGoodsNumber(Double goodsNumber) {
        this.goodsNumber = goodsNumber;
    }

    public Integer getContractId() {
        return contractId;
    }

    public void setContractId(Integer contractId) {
        this.contractId = contractId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Employee getCreateByUser() {
        return createByUser;
    }

    public void setCreateByUser(Employee createByUser) {
        this.createByUser = createByUser;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public DataDictionary getStorageStatus() {
        return storageStatus;
    }

    public void setStorageStatus(DataDictionary storageStatus) {
        this.storageStatus = storageStatus;
    }
}