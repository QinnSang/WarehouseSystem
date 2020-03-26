package service;

import org.springframework.stereotype.Service;
import pojo.ExpenseDetail;

import java.util.List;

public interface ExpenseDetailService {
    List<ExpenseDetail> queryByOrderId(Integer orderId);
}
