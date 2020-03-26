package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Contract;
import pojo.ContractExpense;
import pojo.DataDictionary;

import java.util.List;
import java.util.Map;

@Mapper
public interface ContractMapper {
    List<Contract> query(Contract contract);

    Map generateContractCode(Map<String,String> params);

    int add(Contract contract);

    int update(Contract contract);

    Contract queryByContractId(@Param("contractId") int contractId);

    List<Contract> queryAllValidContract();

    Contract queryStatusByContractId(@Param("contractId") int contractId);

    int updateStatus(Contract contract);

    Contract queryByCode(@Param("contractCode") String contractCode);

}
