package service;

import com.github.pagehelper.PageInfo;
import dto.LogDto;
import pojo.Log;

public interface LogService {
    PageInfo<Log> query(LogDto logDto, Integer page, Integer limit);

    int addShippingLog(Integer storageId, Integer shippingId);

     int addReceivingLog(Integer storageId, Integer receivingId);

    }
