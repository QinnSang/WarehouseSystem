package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import pojo.Company;
import pojo.Employee;

public interface CompanyService {

    PageInfo<Company> query(Company company, Integer page, Integer limit);

    Company queryById(Integer companyId);

    StateType addCompany(Company company, Employee employee);

    StateType updateCompany(Company company, Employee employee);

    StateType delete(int companyId);
}
