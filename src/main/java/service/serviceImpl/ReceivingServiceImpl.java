package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.ExpenseDetailMapper;
import mapper.ReceivingMapper;
import mapper.StorageGoodsMappper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.*;
import service.ReceivingService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("receivingService")
public class ReceivingServiceImpl implements ReceivingService {

    @Autowired
    ReceivingMapper receivingMapper;

    @Autowired
    ExpenseDetailMapper expenseDetailMapper;

    @Autowired
    StorageGoodsMappper storageGoodsMappper;

    @Override
    public PageInfo<Receiving> query(Receiving receiving, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Receiving> list=receivingMapper.query(receiving);
        PageInfo<Receiving> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType add(Receiving receiving, Employee employee) {
        //利用Map传输入参和存储出参
        Map<String,String> params=new HashMap<>();
        params.put("orderNamePre","RE");
        params.put("receivingCode","");
        //调用存储过程生成入库单流水号
        receivingMapper.generateReceivingCode(params);
        //取得流水号
        String receivingCode = params.get("receivingCode");
        receiving.setReceivingCode(receivingCode);
        receiving.setReceivingBy(employee.getEmployeeId());
        receiving.setReceivingDate(new Date());
        int addRow1=receivingMapper.add(receiving);
        //如果添加成功
        if(addRow1==1){
            //1添加入库单费用明细
            //先根据入库单流水号查询入库单主键
            Receiving receiving1 =receivingMapper.queryByCode(receivingCode);
            //遍历设置合同费用中关联的入库单、仓储订单id
            for (ExpenseDetail expenseDetail: receiving.getExpenseDetailList()) {
                expenseDetail.setOrderId(receiving1.getReceivingId()); //设置关联的入库单主键
                expenseDetail.setStorageId(receiving.getStorageId());
                expenseDetail.setOrderType(1); //设置费用明细关联单位入库单类型
                expenseDetail.setCheckStatus(1); //设置费用状态为未结算
                expenseDetail.setCreateDate(receiving.getReceivingDate());
                expenseDetail.setIsConfirm(1); //设置费用状态为未确认，不可用于结算
            }
            //增加入库单费用明细
            int addRow2=expenseDetailMapper.addReceiving(receiving);
            if(addRow2>=1)
                return  StateType.getStateType(22);
            return  StateType.getStateType(23);
        }
        return  StateType.getStateType(23);
    }

    @Override
    public StateType update(Receiving receiving,Employee employee) {
        receiving.setReceivingBy(employee.getEmployeeId());
        receiving.setReceivingDate(new Date());
        int updateRow1=receivingMapper.update(receiving);
        //如果修改合同信息成功
        if(updateRow1==1){
            //则先删除相关合同的费用明细，再添加相关合同费用明细，防止前台删除而后台不了解情况
            expenseDetailMapper.deleteByOrderId(receiving.getReceivingId());
            //遍历设置合同费用中关联的入库单、仓储订单id
            for (ExpenseDetail expenseDetail: receiving.getExpenseDetailList()) {
                expenseDetail.setOrderId(receiving.getReceivingId()); //设置关联的入库单主键
                expenseDetail.setStorageId(receiving.getStorageId());
                expenseDetail.setOrderType(1); //设置费用明细关联单位入库单类型
                expenseDetail.setCheckStatus(1); //设置费用状态为未结算
                expenseDetail.setCreateDate(receiving.getReceivingDate());
                expenseDetail.setIsConfirm(1); //设置费用状态为未确认，不可用于结算
            }
            //增加入库单费用明细
            int addRow2=expenseDetailMapper.addReceiving(receiving);
            if(addRow2>=1)
                return  StateType.getStateType(20);
            return  StateType.getStateType(21);
        }
        return  StateType.getStateType(21);
    }

    @Override
    public StateType confirm(Receiving receiving) {
        //入库单仅在未入库状态才可确认
        if(receiving.getStatus()!= 1 )
            return StateType.getStateType(30);
        receiving.setStatus(2);
        int updateRow=receivingMapper.updateStatus(receiving);
        //确认成功
        if(updateRow==1){
            //只有在确认入库操作中才更新相应的仓储订单货物库存，根据仓库、库位、货物类型和名称进行区分
            //如果查找到货物，那么就更新库存，查不到就新增
            StorageGoods storageGoods = new StorageGoods();
            storageGoods.setGoodsNameId(receiving.getGoodsNameId());
            storageGoods.setGoodsTypeId(receiving.getGoodsTypeId());
            storageGoods.setWarehouseId(receiving.getWarehouseId());
            storageGoods.setLocationId(receiving.getLocationId());
            storageGoods.setStorageId(receiving.getStorageId());
            StorageGoods  result = storageGoodsMappper.queryGoods(storageGoods);
            if (result == null) {
                storageGoods.setGoodsNumber(receiving.getReceivingNumber());
                int addRow3 = storageGoodsMappper.add(storageGoods);
                //更新费用明细 确认状态为已确认
                expenseDetailMapper.updateStatusConfirm(receiving.getReceivingId());
                if (addRow3 == 1)
                    return StateType.getStateType(28);
                return StateType.getStateType(29);
            } else {
                storageGoods.setStorageGoodsId(result.getStorageGoodsId());
                storageGoods.setGoodsNumber(result.getGoodsNumber()+receiving.getReceivingNumber());
                int updateRow1 = storageGoodsMappper.update(storageGoods);
                //更新费用明细 确认状态为已确认
                expenseDetailMapper.updateStatusConfirm(receiving.getReceivingId());
                if (updateRow1 == 1)
                    return StateType.getStateType(28);
                return StateType.getStateType(29);
            }
        }
        return StateType.getStateType(29);
    }

    @Override
    public StateType del(Receiving receiving) {
        //如果入库单已经确认，则不可删除
        if(receiving.getStatus() == 2)
            return StateType.getStateType(35);
        //先删除关联的费用明细
        int receivingId=receiving.getReceivingId();
        expenseDetailMapper.deleteByOrderId(receivingId);
        //再删除入库单
        int delRow=receivingMapper.delByReceivingId(receivingId);
        if(delRow == 1){
            return StateType.getStateType(24);
        }
        return StateType.getStateType(25);
    }

}
