package pojo;

import java.util.Date;

public class Shipping {
    private Integer shippingId;

    private String shippingName;

    private String shippingCode;

    private Integer storageId;

    private Integer warehouseId;

    private Integer locationId;

    private Integer goodsTypeId;

    private Integer goodsNameId;

    private Double shippingNumber;

    private String transType;

    private String carno;

    private String shippingByname;

    private Date shippingTime;

    private Integer status;

    private String remark;

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

    public String getCarno() {
        return carno;
    }

    public void setCarno(String carno) {
        this.carno = carno == null ? null : carno.trim();
    }

    public String getShippingByname() {
        return shippingByname;
    }

    public void setShippingByname(String shippingByname) {
        this.shippingByname = shippingByname == null ? null : shippingByname.trim();
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
}