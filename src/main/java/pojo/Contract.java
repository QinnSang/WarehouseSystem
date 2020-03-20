package pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class Contract {
    private Integer contractId;

    private String contractName;

    private String contractCode;

    private Integer companyId;

    private Company company;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date signDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date startDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date endDate;

    private String content;

    private Integer createBy;

    private Employee createByEmployee;

//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createDate;

    private String annexid;

    private Integer status;

    private DataDictionary contractStatus;

    private String remark;

    private List<ContractExpense> contractExpenseList;

    public Integer getContractId() {
        return contractId;
    }

    public void setContractId(Integer contractId) {
        this.contractId = contractId;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName == null ? null : contractName.trim();
    }

    public String getContractCode() {
        return contractCode;
    }

    public void setContractCode(String contractCode) {
        this.contractCode = contractCode == null ? null : contractCode.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Date getSignDate() {
        return signDate;
    }

    public void setSignDate(Date signDate) {
        this.signDate = signDate;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getAnnexid() {
        return annexid;
    }

    public void setAnnexid(String annexid) {
        this.annexid = annexid == null ? null : annexid.trim();
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
        this.remark = remark;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Employee getCreateByEmployee() {
        return createByEmployee;
    }

    public void setCreateByEmployee(Employee createByEmployee) {
        this.createByEmployee = createByEmployee;
    }

    public DataDictionary getContractStatus() {
        return contractStatus;
    }

    public void setContractStatus(DataDictionary contractStatus) {
        this.contractStatus = contractStatus;
    }

    public List<ContractExpense> getContractExpenseList() {
        return contractExpenseList;
    }

    public void setContractExpenseList(List<ContractExpense> contractExpenseList) {
        this.contractExpenseList = contractExpenseList;
    }
}