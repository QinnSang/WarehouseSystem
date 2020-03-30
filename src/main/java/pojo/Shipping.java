package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class Shipping {
    private Integer shippingId;

    private String shippingName;

    private String shippingCode;

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

    private Double shippingNumber;

    private String transType;

    private DataDictionary shippingTransType;

    private String carNo;

    private Integer shippingBy;

    private Employee shippingByUser;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date shippingTime;

    private Integer status;

    private DataDictionary shippingStatus;

    private String remark;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date createDate;

    private List<ExpenseDetail> expenseDetailList;

    public Integer getShippingId() {
        return shippingId;
    }

    public void setShippingId(Integer shippingId) {
        this.shippingId = shippingId;
    }

    public String getShippingName() {
        return shippingName;
    }

    public void setShippingName(String shippingName) {
        this.shippingName = shippingName == null ? null : shippingName.trim();
    }

    public String getShippingCode() {
        return shippingCode;
    }

    public void setShippingCode(String shippingCode) {
        this.shippingCode = shippingCode == null ? null : shippingCode.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
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

    public Double getShippingNumber() {
        return shippingNumber;
    }

    public void setShippingNumber(Double shippingNumber) {
        this.shippingNumber = shippingNumber;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType == null ? null : transType.trim();
    }

    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public Integer getShippingBy() {
        return shippingBy;
    }

    public void setShippingBy(Integer shippingBy) {
        this.shippingBy = shippingBy;
    }

    public Date getShippingTime() {
        return shippingTime;
    }

    public void setShippingTime(Date shippingTime) {
        this.shippingTime = shippingTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

    public DataDictionary getShippingTransType() {
        return shippingTransType;
    }

    public void setShippingTransType(DataDictionary shippingTransType) {
        this.shippingTransType = shippingTransType;
    }

    public Employee getShippingByUser() {
        return shippingByUser;
    }

    public void setShippingByUser(Employee shippingByUser) {
        this.shippingByUser = shippingByUser;
    }

    public DataDictionary getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(DataDictionary shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public List<ExpenseDetail> getExpenseDetailList() {
        return expenseDetailList;
    }

    public void setExpenseDetailList(List<ExpenseDetail> expenseDetailList) {
        this.expenseDetailList = expenseDetailList;
    }
}