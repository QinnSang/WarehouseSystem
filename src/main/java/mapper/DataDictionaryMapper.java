package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.DataDictionary;

import java.util.List;

@Mapper
public interface DataDictionaryMapper {
    List<DataDictionary> queryExpense(DataDictionary dataDictionary);
}
