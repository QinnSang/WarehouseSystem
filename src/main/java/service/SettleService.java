package service;

import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.SettleDto;
import pojo.Employee;
import pojo.ExpenseDetail;
import pojo.Settle;

public interface SettleService {
    StateType addStatement(SettleDto settleDto, Employee employee);

    PageInfo<Settle> query(Settle settle, Integer page, Integer limit);

    StateType del(Settle settle);

    StateType settleStatement(Settle settle,Employee employee);

    PageInfo<ExpenseDetail> queryStatement(Settle settle, Integer page, Integer limit);
}
