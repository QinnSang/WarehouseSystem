package pojo;

import java.util.List;

public class Employee {

    private Integer employeeId;

    private String loginCode;

    private String password;

    private String salt;

    private String workNo;

    private String realName;

    private String email;

    private String phone;

    private Integer sex;

    private DataDictionary employeeSex;

    private Integer status;

    private DataDictionary employeeStatus;

    private String remark;

    private List<Role> roleList;

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public String getLoginCode() {
        return loginCode;
    }

    public void setLoginCode(String loginCode) {
        this.loginCode = loginCode == null ? null : loginCode.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    public String getWorkNo() { return workNo; }
    public void setWorkNo(String workNo) {
        this.workNo = workNo == null ? null : workNo.trim();
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
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

    public DataDictionary getEmployeeSex() {
        return employeeSex;
    }

    public void setEmployeeSex(DataDictionary employeeSex) {
        this.employeeSex = employeeSex;
    }

    public DataDictionary getEmployeeStatus() {
        return employeeStatus;
    }

    public void setEmployeeStatus(DataDictionary employeeStatus) {
        this.employeeStatus = employeeStatus;
    }

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }
}