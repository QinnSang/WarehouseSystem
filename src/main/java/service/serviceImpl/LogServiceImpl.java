package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dto.LogDto;
import mapper.LogMapper;
import mapper.ReceivingMapper;
import mapper.ShippingMapper;
import mapper.StorageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Log;
import pojo.Receiving;
import pojo.Shipping;
import pojo.Storage;
import service.LogService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("logService")
public class LogServiceImpl implements LogService {

    @Autowired
    LogMapper logMapper;

    @Autowired
    StorageMapper storageMapper;

    @Autowired
    ShippingMapper shippingMapper;

    @Autowired
    ReceivingMapper receivingMapper;

    @Override
    public PageInfo<Log> query(LogDto logDto, Integer page, Integer limit) {
        if(logDto.getOrderSEDate() !=null && logDto.getOrderSEDate()!=""){
            SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
            try {
                logDto.setStartDate(sdf.parse(logDto.getOrderSEDate().substring(0,19)));
                logDto.setEndDate(sdf.parse(logDto.getOrderSEDate().substring(22,41)));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Log> list=logMapper.query(logDto);
        PageInfo<Log> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int addShippingLog(Integer storageId, Integer shippingId) {
        //获取仓储订单和出入库单信息
        Storage storage=new Storage();
        storage.setStorageId(storageId);
        storage=storageMapper.query(storage).get(0);
        Shipping shipping = new Shipping();
        shipping.setShippingId(shippingId);
        shipping=shippingMapper.query(shipping).get(0);
        //订单日志信息
        Log log=new Log();
        log.setStorageCode(storage.getStorageCode());
        log.setCreateDate(storage.getCreateTime());
        log.setGoodsNumber(storage.getGoodsNumber());
        log.setOrderBy(shipping.getShippingByUser().getRealName());
        log.setGoodsName(shipping.getGoodsName().getGoodsName());
        log.setOrderCode(shipping.getShippingCode());
        log.setOrderAmount(shipping.getShippingNumber());
        log.setOrderType(2);
        log.setOrderId(shippingId);
        log.setRemark(shipping.getRemark());
        log.setOrderName(shipping.getShippingName());
        log.setOrderDate(shipping.getCreateDate());
        return logMapper.add(log);
    }

    @Override
    public int addReceivingLog(Integer storageId, Integer receivingId) {
        //获取仓储订单和出入库单信息
        Storage storage=new Storage();
        storage.setStorageId(storageId);
        storage=storageMapper.query(storage).get(0);
        Receiving receiving = new Receiving();
        receiving.setReceivingId(receivingId);
        receiving=receivingMapper.query(receiving).get(0);
        //订单日志信息
        Log log=new Log();
        log.setStorageCode(storage.getStorageCode());
        log.setCreateDate(storage.getCreateTime());
        log.setGoodsNumber(storage.getGoodsNumber());
        log.setOrderBy(receiving.getReceivingByUser().getRealName());
        log.setGoodsName(receiving.getGoodsName().getGoodsName());
        log.setOrderCode(receiving.getReceivingCode());
        log.setOrderAmount(receiving.getReceivingNumber());
        log.setOrderType(1);
        log.setOrderId(receivingId);
        log.setRemark(receiving.getRemark());
        log.setOrderName(receiving.getReceivingName());
        log.setOrderDate(receiving.getReceivingDate());
        return logMapper.add(log);
    }

}
