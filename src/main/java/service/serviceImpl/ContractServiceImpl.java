package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import mapper.CompanyMapper;
import mapper.ContractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Company;
import pojo.Contract;
import service.ContractService;

import java.util.List;

@Service("contractService")
public class ContractServiceImpl implements ContractService {

    @Autowired
    ContractMapper contractMapper;

    @Autowired
    CompanyMapper companyMapper;

    @Override
    public PageInfo<Contract> query(Contract contract, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Contract> list=contractMapper.query(contract);
        PageInfo<Contract> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }
}
