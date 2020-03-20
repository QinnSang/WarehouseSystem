package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Contract;
import pojo.ContractExpense;

import java.util.List;

@Mapper
public interface ContractExpenseMapper {
    int add(Contract contract);

    List<ContractExpense> queryByContractId(@Param("contractId") Integer contractId);

    void deleteByContractId(@Param("contractId")Integer contractId);
}
