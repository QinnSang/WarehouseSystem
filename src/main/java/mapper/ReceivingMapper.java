package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Receiving;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReceivingMapper {

    List<Receiving> query(Receiving receiving);

    Map generateReceivingCode(Map<String, String> params);

    int add(Receiving receiving);

    Receiving queryByCode(@Param("receivingCode") String receivingCode);

    int update(Receiving receiving);

    int updateStatus(Receiving receiving);

    int delByReceivingId(@Param("receivingId") Integer receivingId);
}
