package pojo;

import java.util.List;

public class Permission {
    //权限id
    private Integer id;
    //权限名称
    private String title;
    //权限类型
    private Integer permissionType;

    private String permission;
//    //是否默认展开
    private boolean spread = true;
//  复选框是否选中
    private boolean checked;

//    //树形节点连接，设置点击打开，未设置不会跳转
//    private String href;
//
//    //菜单图标，图片链搂或是图片附件UUID
//    private String menuIcon;

    //父级菜单ID
    private String superId;

    //子菜单集合
    private List<Permission> children;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean isSpread() {
        return spread;
    }

    public void setSpread(boolean spread) {
        this.spread = spread;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getPermissionType() {
        return permissionType;
    }

    public void setPermissionType(Integer permissionType) {
        this.permissionType = permissionType;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public List<Permission> getChildren() {
        return children;
    }

    public void setChildren(List<Permission> children) {
        this.children = children;
    }
}