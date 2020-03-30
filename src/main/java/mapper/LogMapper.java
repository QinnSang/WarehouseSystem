package mapper;

import dto.LogDto;
import org.apache.ibatis.annotations.Mapper;
import pojo.Log;

import java.util.List;

@Mapper
public interface LogMapper {
    List<Log> query(LogDto logDto);

    int add(Log log);
}
