package pojo;

import java.util.Date;

public class Recieving {
    private Integer recievingId;

    private String recievingName;

    private String recievingCode;

    private Integer storageId;

    private Integer warehouseId;

    private Integer locationId;

    private Integer goodsTypeId;

    private Integer goodsNameId;

    private Double recievingNumber;

    private Integer transType;

    private String carno;

    private String origin;

    private Date arriveTime;

    private Integer takingType;

    private Integer status;

    private Integer receivingBy;

    private Date receivingDate;

    private String remark;

    public Integer getRecievingId() {
        return recievingId;
    }

    public void setRecievingId(Integer recievingId) {
        this.recievingId = recievingId;
    }

    public String getRecievingName() {
        return recievingName;
    }

    public void setRecievingName(String recievingName) {
        this.recievingName = recievingName == null ? null : recievingName.trim();
    }

    public String getRecievingCode() {
        return recievingCode;
    }

    public void setRecievingCode(String recievingCode) {
        this.recievingCode = recievingCode == null ? null : recievingCode.trim();
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

    public Double getRecievingNumber() {
        return recievingNumber;
    }

    public void setRecievingNumber(Double recievingNumber) {
        this.recievingNumber = recievingNumber;
    }

    public Integer getTransType() {
        return transType;
    }

    public void setTransType(Integer transType) {
        this.transType = transType;
    }

    public String getCarno() {
        return carno;
    }

    public void setCarno(String carno) {
        this.carno = carno == null ? null : carno.trim();
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
}