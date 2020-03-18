package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.Contract;

import java.util.List;

@Mapper
public interface ContractMapper {
    List<Contract> query(Contract contract);
}
