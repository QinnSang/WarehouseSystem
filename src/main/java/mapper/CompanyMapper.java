package mapper;

import org.apache.ibatis.annotations.Mapper;
import pojo.Company;

import java.util.List;

@Mapper
public interface CompanyMapper {
    List<Company> query(Company company);
}
