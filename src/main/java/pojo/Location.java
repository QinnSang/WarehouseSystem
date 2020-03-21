package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Location {
    private Integer locationId;

    private String locationName;

    private Integer locationArea;

    private Integer createBy;

    private Employee createByUser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    private Integer warehouseId;

    private Warehouse warehouse;

    public Integer getLocationId() {
        return locationId;
    }

    public void setLocationId(Integer locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName == null ? null : locationName.trim();
    }

    public Integer getLocationArea() {
        return locationArea;
    }

    public void setLocationArea(Integer locationArea) {
        this.locationArea = locationArea;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Employee getCreateByUser() {
        return createByUser;
    }

    public void setCreateByUser(Employee createByUser) {
        this.createByUser = createByUser;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }
}