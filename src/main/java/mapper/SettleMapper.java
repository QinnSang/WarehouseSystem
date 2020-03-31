package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.ExpenseDetail;
import pojo.Settle;

import java.util.List;
import java.util.Map;

@Mapper
public interface SettleMapper {
    int addStatement(Settle settle);

    Map generateSettleCode(Map<String, String> params);

    List<Settle> query(Settle settle);

    int del(@Param("settleId") Integer settleId);

    int updateSettle(Settle settle);

    int querySettleId(@Param("settleCode")String settleCode);

    int updateTotalPrice(Settle settle);
}
