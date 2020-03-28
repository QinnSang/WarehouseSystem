package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.ExpenseDetail;
import pojo.Receiving;
import pojo.Shipping;

import java.util.List;

@Mapper
public interface ExpenseDetailMapper {
    int addReceiving(Receiving receiving);

    List<ExpenseDetail> queryByOrderId(ExpenseDetail expenseDetail);

    int deleteByOrderId(@Param("orderId")Integer orderId);

    int addShipping(Shipping shipping);


}
