package pojo;

public class StorageGoods {
    private Integer storageGoodsId;

    private Integer storageId;

    private Integer goodsTypeId;

    private Goods goodsType;

    private Integer goodsNameId;

    private Goods goodsName;

    private Integer warehouseId;

    private Warehouse warehouse;

    private Integer locationId;

    private Location location;

    private Double goodsNumber;

    public Integer getStorageGoodsId() {
        return storageGoodsId;
    }

    public void setStorageGoodsId(Integer storageGoodsId) {
        this.storageGoodsId = storageGoodsId;
    }

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
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

    public Double getGoodsNumber() {
        return goodsNumber;
    }

    public void setGoodsNumber(Double goodsNumber) {
        this.goodsNumber = goodsNumber;
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
}