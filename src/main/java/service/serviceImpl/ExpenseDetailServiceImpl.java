package service.serviceImpl;

import mapper.ExpenseDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.ExpenseDetail;
import service.ExpenseDetailService;

import java.util.List;

@Service("expenseDetailService")
public class ExpenseDetailServiceImpl implements ExpenseDetailService {

    @Autowired
    ExpenseDetailMapper expenseDetailMapper;

    @Override
    public List<ExpenseDetail> queryByOrderId(Integer orderId) {
        return expenseDetailMapper.queryByOrderId(orderId);
    }
}
