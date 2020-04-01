package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import pojo.Company;

import java.util.List;

@Mapper
public interface CompanyMapper {
    List<Company> query(Company company);

    int addCompany(Company addCompany);

    int updateCompany(Company company);

    int delete(int companyId);
}
