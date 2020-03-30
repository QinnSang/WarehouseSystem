package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.Receiving;
import pojo.Shipping;

import java.util.List;
import java.util.Map;

@Mapper
public interface ShippingMapper {
    List<Shipping> query(Shipping shipping);

    int add(Shipping shipping);

    Shipping queryByCode(String shippingCode);

    void generateShippingCode(Map<String, String> params);

    int updateStatus(Shipping shipping);

    int delByShippingId(int shippingId);

    int update(Shipping shipping);
}
