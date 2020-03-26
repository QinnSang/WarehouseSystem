package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class Receiving {
    private Integer receivingId;

    private String receivingName;

    private String receivingCode;

    private Integer storageId;

    private Storage storage;

    private Integer warehouseId;

    private Warehouse warehouse;

    private Integer locationId;

    private Location location;

    private Integer goodsTypeId;

    private Goods goodsType;

    private Integer goodsNameId;

    private Goods goodsName;

    private Double receivingNumber;

    private Integer transType;

    private DataDictionary receivingTransType;

    private String carNo;

    private String origin;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date arriveTime;

    private Integer takingType;

    private DataDictionary receivingTakingType;

    private Integer status;

    private DataDictionary receivingStatus;

    private Integer receivingBy;

    private Employee receivingByUser;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date receivingDate;

    private String remark;

    private List<ExpenseDetail>  expenseDetailList;

    public Integer getReceivingId() {
        return receivingId;
    }

    public void setReceivingId(Integer receivingId) {
        this.receivingId = receivingId;
    }

    public String getReceivingName() {
        return receivingName;
    }

    public void setReceivingName(String receivingName) {
        this.receivingName = receivingName;
    }

    public String getReceivingCode() {
        return receivingCode;
    }

    public void setReceivingCode(String receivingCode) {
        this.receivingCode = receivingCode;
    }

    public Double getReceivingNumber() {
        return receivingNumber;
    }

    public void setReceivingNumber(Double receivingNumber) {
        this.receivingNumber = receivingNumber;
    }

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getLocationId() {
        return locationId;
    }

    public void setLocationId(Integer locationId) {
        this.locationId = locationId;
    }

    public Integer getGoodsTypeId() {
        return goodsTypeId;
    }

    public void setGoodsTypeId(Integer goodsTypeId) {
        this.goodsTypeId = goodsTypeId;
    }

    public Integer getGoodsNameId() {
        return goodsNameId;
    }

    public void setGoodsNameId(Integer goodsNameId) {
        this.goodsNameId = goodsNameId;
    }

    public Integer getTransType() {
        return transType;
    }

    public void setTransType(Integer transType) {
        this.transType = transType;
    }

    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin == null ? null : origin.trim();
    }

    public Date getArriveTime() {
        return arriveTime;
    }

    public void setArriveTime(Date arriveTime) {
        this.arriveTime = arriveTime;
    }

    public Integer getTakingType() {
        return takingType;
    }

    public void setTakingType(Integer takingType) {
        this.takingType = takingType;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getReceivingBy() {
        return receivingBy;
    }

    public void setReceivingBy(Integer receivingBy) {
        this.receivingBy = receivingBy;
    }

    public Date getReceivingDate() {
        return receivingDate;
    }

    public void setReceivingDate(Date receivingDate) {
        this.receivingDate = receivingDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Goods getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(Goods goodsType) {
        this.goodsType = goodsType;
    }

    public Goods getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(Goods goodsName) {
        this.goodsName = goodsName;
    }

    public DataDictionary getReceivingStatus() {
        return receivingStatus;
    }

    public void setReceivingStatus(DataDictionary receivingStatus) {
        this.receivingStatus = receivingStatus;
    }

    public Employee getReceivingByUser() {
        return receivingByUser;
    }

    public void setReceivingByUser(Employee receivingByUser) {
        this.receivingByUser = receivingByUser;
    }

    public DataDictionary getReceivingTransType() {
        return receivingTransType;
    }

    public void setReceivingTransType(DataDictionary receivingTransType) {
        this.receivingTransType = receivingTransType;
    }

    public DataDictionary getReceivingTakingType() {
        return receivingTakingType;
    }

    public void setReceivingTakingType(DataDictionary receivingTakingType) {
        this.receivingTakingType = receivingTakingType;
    }

    public List<ExpenseDetail> getExpenseDetailList() {
        return expenseDetailList;
    }

    public void setExpenseDetailList(List<ExpenseDetail> expenseDetailList) {
        this.expenseDetailList = expenseDetailList;
    }
}