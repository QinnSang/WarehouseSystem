package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.ExpenseDetail;
import pojo.Receiving;

import java.util.List;

@Mapper
public interface ExpenseDetailMapper {
    int add(Receiving receiving);

    List<ExpenseDetail> queryByOrderId(@Param("orderId") Integer orderId);

    int deleteByOrderId(@Param("orderId")Integer orderId);
}
