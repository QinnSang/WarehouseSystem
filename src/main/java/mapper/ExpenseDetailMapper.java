package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.ExpenseDetail;
import pojo.Receiving;
import pojo.Settle;
import pojo.Shipping;

import java.util.List;

@Mapper
public interface ExpenseDetailMapper {
    int addReceiving(Receiving receiving);

    List<ExpenseDetail> queryByOrderId(ExpenseDetail expenseDetail);

    int deleteByOrderId(@Param("orderId")Integer orderId);

    int addShipping(Shipping shipping);

    int updateStatusConfirm(@Param("orderId")Integer orderI);

    List<ExpenseDetail> queryStatement(Settle settle);

    int updateSettleId(Settle settle);

    double sumOfStorage(Settle settle);

    int delSettleId(@Param("settleId") Integer settleId);

    int settleExpense(@Param("settleId") Integer settleId);
}
