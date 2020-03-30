package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.ExpenseDetailMapper;
import mapper.LogMapper;
import mapper.ShippingMapper;
import mapper.StorageGoodsMappper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.*;
import service.ShippingService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("shippingService")
public class ShippingServiceImpl implements ShippingService {

    @Autowired
    ShippingMapper shippingMapper;

    @Autowired
    ExpenseDetailMapper expenseDetailMapper;

    @Autowired
    StorageGoodsMappper storageGoodsMappper;

    @Override
    public PageInfo<Shipping> query(Shipping shipping, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Shipping> list=shippingMapper.query(shipping);
        PageInfo<Shipping> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType add(Shipping shipping, Employee employee) {
        //利用Map传输入参和存储出参
        Map<String,String> params=new HashMap<>();
        params.put("orderNamePre","SH");
        params.put("shippingCode","");
        //调用存储过程生成出库单流水号
        shippingMapper.generateShippingCode(params);
        //取得流水号
        String shippingCode = params.get("shippingCode");
        shipping.setShippingCode(shippingCode);
        shipping.setShippingBy(employee.getEmployeeId());
        shipping.setCreateDate(new Date());
        int addRow1=shippingMapper.add(shipping);
        //如果添加成功
        if(addRow1==1){
            //1添加出库单费用明细
            //先根据出库单流水号查询出库单主键
            Shipping shipping1 =shippingMapper.queryByCode(shippingCode);
            //遍历设置费用明细中关联的出库单、仓储订单id
            for (ExpenseDetail expenseDetail: shipping.getExpenseDetailList()) {
                expenseDetail.setOrderId(shipping1.getShippingId()); //设置关联的出库单主键
                expenseDetail.setStorageId(shipping.getStorageId());
                expenseDetail.setOrderType(2); //设置费用明细关联单位出库单类型
                expenseDetail.setCheckStatus(1); //设置费用状态为未结算
                expenseDetail.setCreateDate(shipping.getCreateDate());
                expenseDetail.setIsConfirm(1); //设置费用状态为未确认，不可用于结算
            }
            //增加入库单费用明细
            int addRow2=expenseDetailMapper.addShipping(shipping);
            if(addRow2>=1)
                return  StateType.getStateType(22);
            return  StateType.getStateType(23);
        }
        return  StateType.getStateType(23);
    }

    @Override
    public StateType update(Shipping shipping, Employee employee) {
        shipping.setShippingBy(employee.getEmployeeId());
        shipping.setShippingTime(new Date());
        int updateRow1=shippingMapper.update(shipping);
        //如果修改合同信息成功
        if(updateRow1==1){
            //则先删除相关合同的费用明细，再添加相关合同费用明细，防止前台删除而后台不了解情况
            expenseDetailMapper.deleteByOrderId(shipping.getShippingId());
            //遍历设置费用明细中关联的出库单、仓储订单id
            for (ExpenseDetail expenseDetail: shipping.getExpenseDetailList()) {
                expenseDetail.setOrderId(shipping.getShippingId()); //设置关联的出库单主键
                expenseDetail.setStorageId(shipping.getStorageId());
                expenseDetail.setOrderType(2); //设置费用明细关联单位出库单类型
                expenseDetail.setCheckStatus(1); //设置费用状态为未结算
                expenseDetail.setCreateDate(shipping.getCreateDate());
                expenseDetail.setIsConfirm(1); //设置费用状态为未确认，不可用于结算
            }
            //增加入库单费用明细
            int addRow2=expenseDetailMapper.addShipping(shipping);
            if(addRow2>=1)
                return  StateType.getStateType(20);
            return  StateType.getStateType(21);
        }
        return  StateType.getStateType(21);
    }

    @Override
    public StateType confirm(Shipping shipping) {
        //出库单仅在未出库状态才可确认
        if(shipping.getStatus()!= 1 )
            return StateType.getStateType(30);
        shipping.setStatus(2);
        int updateRow=shippingMapper.updateStatus(shipping);
        //确认成功
        if(updateRow==1){
            //只有在确认出库操作中才更新相应的仓储订单货物库存，根据仓库、库位、货物类型和名称进行区分
            //如果查找到货物，那么就更新库存，查不到就新增
            StorageGoods storageGoods = new StorageGoods();
            storageGoods.setGoodsNameId(shipping.getGoodsNameId());
            storageGoods.setGoodsTypeId(shipping.getGoodsTypeId());
            storageGoods.setWarehouseId(shipping.getWarehouseId());
            storageGoods.setLocationId(shipping.getLocationId());
            storageGoods.setStorageId(shipping.getStorageId());
            StorageGoods  result = storageGoodsMappper.queryGoods(storageGoods);
            //如果不存在该货物或货物库存不足，则确认审核失败
            if (result == null || result.getGoodsNumber()<shipping.getShippingNumber()) {
                return StateType.getStateType(36);
            } else {
                storageGoods.setStorageGoodsId(result.getStorageGoodsId());
                storageGoods.setGoodsNumber(result.getGoodsNumber()-shipping.getShippingNumber());
                int updateRow1 = storageGoodsMappper.update(storageGoods);
                //更新费用明细 确认状态为已确认
                expenseDetailMapper.updateStatusConfirm(shipping.getShippingId());
                if (updateRow1 == 1)
                    return StateType.getStateType(28);
                return StateType.getStateType(29);
            }
        }
        return StateType.getStateType(29);
    }

    @Override
    public StateType del(Shipping shipping) {
        //如果出库单已经确认，则不可删除
        if(shipping.getStatus() == 2)
            return StateType.getStateType(35);
        //先删除关联的费用明细
        int shippingId=shipping.getShippingId();
        expenseDetailMapper.deleteByOrderId(shippingId);
        //再删除入库单
        int delRow=shippingMapper.delByShippingId(shippingId);
        if(delRow == 1){
            return StateType.getStateType(24);
        }
        return StateType.getStateType(25);
    }

}
