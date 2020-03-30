package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import dto.SettleDto;
import mapper.ExpenseDetailMapper;
import mapper.SettleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Employee;
import pojo.ExpenseDetail;
import pojo.Settle;
import pojo.Storage;
import service.SettleService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("settleService")
public class SettleServiceImpl implements SettleService {

    @Autowired
    SettleMapper settleMapper;

    @Autowired
    ExpenseDetailMapper expenseDetailMapper;

    @Override
    public StateType addStatement(SettleDto settleDto, Employee employee) {
        Settle settle = new Settle();
        //设置结算起止日期
        String seDate = settleDto.getSeDate();
        if(seDate !=null && seDate!=""){
            SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd" );
            try {
                settle.setCheckStartDate(sdf.parse(seDate.substring(0,10)));
                settle.setCheckEndDate(sdf.parse(seDate.substring(13,23)));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        settle.setStorageId(settleDto.getStorageId());
        //利用Map传输入参和存储出参
        Map<String,String> params=new HashMap<>();
        params.put("orderNamePre","SE");
        params.put("settleCode","");
        //调用存储过程生成对账单流水号
        settleMapper.generateSettleCode(params);
        //取得流水号
        String settleCode = params.get("settleCode");
        settle.setSettleCode(settleCode);
        settle.setCreateBy(employee.getEmployeeId());
        settle.setCreateDate(new Date());
        settle.setSettleName(settleDto.getStorageName()+"["+seDate+"]收入对账单");
        settle.setStatus(1);
        int addRow1=settleMapper.addStatement(settle);
        if(addRow1 == 1){
            //根据对账单流水号查询对账单主键，设置费用明细关联的对账单编号，防止对账单金额因确认出入库而发生变化
            int settleId=settleMapper.querySettleId(settleCode);
            settle.setSettleId(settleId);
            expenseDetailMapper.updateSettleId(settle);  //根据仓储订单、结算起止日期设置
            double totalPrice = expenseDetailMapper.sumOfStorage(settle);  //根据对账单编号合计费用
            settle.setTotalPrice(totalPrice);
            int updateRow1 = settleMapper.updateTotalPrice(settle);
            //如果更新合计费用成功
            if(updateRow1==1)
                return  StateType.getStateType(22);
            return  StateType.getStateType(23);
        }
        return  StateType.getStateType(23);
    }

    @Override
    public PageInfo<Settle> query(Settle settle, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Settle> list=settleMapper.query(settle);
        PageInfo<Settle> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType del(Settle settle) {
        //如果对账单名词已结算，则不可删除
        if(settle.getStatus() == 2)
            return StateType.getStateType(35);
        //先删除费用明细关联的对账单编号
        expenseDetailMapper.delSettleId(settle.getSettleId());
        int delRow2=settleMapper.del(settle.getSettleId());
         if(delRow2 ==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }

    @Override
    public StateType settleStatement(Settle settle,Employee employee) {
        //如果对账单名词已结算，则不可再次结算
        if(settle.getStatus() == 2)
            return StateType.getStateType(38);
        //更新对账单关联的费用明细状态为已结算
        expenseDetailMapper.settleExpense(settle.getSettleId());
        //更新对账单状态
        settle.setCheckDate(new Date());
        settle.setCheckBy(employee.getEmployeeId());
        int updateRow1=settleMapper.updateSettle(settle);
        if (updateRow1 == 1)
            return StateType.getStateType(37);
        return StateType.getStateType(39);
    }

    @Override
    public PageInfo<ExpenseDetail> queryStatement(Settle settle, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<ExpenseDetail> list=expenseDetailMapper.queryStatement(settle);
        PageInfo<ExpenseDetail> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

}
