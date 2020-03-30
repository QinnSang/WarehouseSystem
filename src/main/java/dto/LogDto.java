package dto;

import java.util.Date;

//接收仓储订单日志界面的查询参数
public class LogDto {

    private String storageCode;

    private Integer orderType;

    private String orderCode;

    private String orderSEDate;

    private Date startDate;

    private Date endDate;

    public String getStorageCode() {
        return storageCode;
    }

    public void setStorageCode(String storageCode) {
        this.storageCode = storageCode;
    }

    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getOrderSEDate() {
        return orderSEDate;
    }

    public void setOrderSEDate(String orderSEDate) {
        this.orderSEDate = orderSEDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
