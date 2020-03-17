package service;

import com.github.pagehelper.PageInfo;
import pojo.Company;

public interface CompanyService {

    PageInfo<Company> query(Company company);
}
