package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class Goods {
    private Integer goodsId;

    private String goodsName;

    private String goodsCode;

    private Integer classify;

    private Integer parentId;

    private Goods belongType;  //所属货物类型

    private List<Goods> goodsNameList; //货物类型中拥有的货物名称

    private Integer createdBy;

    private Employee createByUser;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName == null ? null : goodsName.trim();
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode == null ? null : goodsCode.trim();
    }

    public Integer getClassify() {
        return classify;
    }

    public void setClassify(Integer classify) {
        this.classify = classify;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<Goods> getGoodsNameList() {
        return goodsNameList;
    }

    public void setGoodsNameList(List<Goods> goodsNameList) {
        this.goodsNameList = goodsNameList;
    }

    public Employee getCreateByUser() {
        return createByUser;
    }

    public void setCreateByUser(Employee createByUser) {
        this.createByUser = createByUser;
    }

    public Goods getBelongType() {
        return belongType;
    }

    public void setBelongType(Goods belongType) {
        this.belongType = belongType;
    }
}