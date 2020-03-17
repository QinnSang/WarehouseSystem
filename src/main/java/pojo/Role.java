package pojo;

public class Role {
    private Integer roleId;

    private String roleName;

    private String remark;
    //table自带的分页、排序数据
    private Integer page;
    private Integer limit;
    private String field;
    private String order;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }


    public Integer getPage() {
        return page;
    }

    public Integer getLimit() {
        return limit;
    }
}