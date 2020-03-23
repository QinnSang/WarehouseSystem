package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.CompanyMapper;
import mapper.ContractExpenseMapper;
import mapper.ContractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Company;
import pojo.Contract;
import pojo.ContractExpense;
import pojo.Employee;
import service.ContractService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("contractService")
public class ContractServiceImpl implements ContractService {

    @Autowired
    ContractMapper contractMapper;

    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    ContractExpenseMapper contractExpenseMapper;

    @Override
    public PageInfo<Contract> query(Contract contract, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Contract> list=contractMapper.query(contract);
        PageInfo<Contract> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType add(Contract contract, Employee employee) {
        //利用Map传输入参和存储出参
        Map<String,String> params=new HashMap<>();
        params.put("orderNamePre","CO");
        params.put("contractCode","");
        //调用存储过程生成合同流水号
        contractMapper.generateContractCode(params);
        //取得流水号
        String contractCode = params.get("contractCode");
        contract.setContractCode(contractCode);
        contract.setCreateBy(employee.getEmployeeId());
        contract.setCreateDate(new Date());
        int addRow1=contractMapper.add(contract);
        //如果添加成功
        if(addRow1==1){
            //则添加合同费用明细
            //先根据合同流水号查询合同信息
            Contract contract1=new Contract();
            contract1.setContractCode(contractCode);
            contract1=contractMapper.query(contract1).get(0);
            //遍历设置合同费用中的关联合同id
            for (ContractExpense contractExpense:contract.getContractExpenseList()) {
                contractExpense.setContractId(contract1.getContractId());
            }
            //增加合同费用明细
            int addRow2=contractExpenseMapper.add(contract);
            if(addRow2>=1)
                return  StateType.getStateType(22);
            return  StateType.getStateType(23);
        }
        return  StateType.getStateType(23);
    }

    @Override
    public StateType update(Contract contract) {
        int updateRow1=contractMapper.update(contract);
        //如果修改合同信息成功
        if(updateRow1==1){
            //则先删除相关合同的费用明细，再添加相关合同费用明细，防止前台删除而后台不了解情况
            contractExpenseMapper.deleteByContractId(contract.getContractId());
            //遍历设置合同费用中的关联合同id
            for (ContractExpense contractExpense:contract.getContractExpenseList()) {
                contractExpense.setContractId(contract.getContractId());
            }
            //增加合同费用明细
            int addRow2=contractExpenseMapper.add(contract);
            if(addRow2>=1)
                return  StateType.getStateType(20);
            return  StateType.getStateType(21);
        }
        return  StateType.getStateType(21);
    }

    @Override
    public StateType invalid(int contractId) {
        Contract contract=contractMapper.queryStatusByContractId(contractId);
        //如果合同已作废或归档，则不可作废
        if(contract.getStatus()== 4 || contract.getStatus()== 3)
            return StateType.getStateType(33);
        contract.setStatus(3);
        int updateRow=contractMapper.updateStatus(contract);
        //作废成功
        if(updateRow==1)
            return StateType.getStateType(26);
        return StateType.getStateType(27);
    }

    @Override
    public StateType confirm(int contractId) {
        Contract contract=contractMapper.queryStatusByContractId(contractId);
        //合同仅在审核中状态才可确认
        if(contract.getStatus() != 1 )
            return StateType.getStateType(30);
        contract.setStatus(2);
        int updateRow=contractMapper.updateStatus(contract);
        //确认成功
        if(updateRow==1)
            return StateType.getStateType(28);
        return StateType.getStateType(29);
    }

    @Override
    public StateType archive(int contractId) {
        Contract contract=contractMapper.queryStatusByContractId(contractId);
        //合同仅在归档、作废状态才不可归档
        if(contract.getStatus()== 4 || contract.getStatus()== 3)
            return StateType.getStateType(33);
        contract.setStatus(4);
        int updateRow=contractMapper.updateStatus(contract);
        //归档成功
        if(updateRow==1)
            return StateType.getStateType(31);
        return StateType.getStateType(32);
    }

    @Override
    public Contract queryByContractId(int contractId) {
        return contractMapper.queryByContractId(contractId);
    }

    @Override
    public List<Contract> queryAllContract() {
        return contractMapper.queryAllContract();
    }

}
