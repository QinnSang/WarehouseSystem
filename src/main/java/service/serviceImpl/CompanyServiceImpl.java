package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import mapper.CompanyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Company;
import service.CompanyService;

import java.util.List;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    CompanyMapper companyMapper;

    @Override
    public PageInfo<Company> query(Company company) {
        //简单设置起始页和分页大小，还要再做修改，参考app项目的app查询query2方法
        //可能需要增加界面界面的companydto或者在company实体类中增加分页属性
        List<Company> list=companyMapper.query(company);
        PageInfo<Company> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public Company queryById(Integer companyId) {
        return companyMapper.queryById(companyId);
    }
}
