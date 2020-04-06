package service.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import constant.StateType;
import mapper.StorageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.*;
import service.StorageService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("storageService")
public class StorageServiceImpl implements StorageService {

    @Autowired
    StorageMapper storageMapper;
    @Override
    public PageInfo<Storage> query(Storage storage, Integer page, Integer limit) {
        //防止导出功能没有分页的需求
        if(page!=null&&limit!=null)
            PageHelper.startPage(page,limit);
        List<Storage> list=storageMapper.query(storage);
        PageInfo<Storage> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public StateType add(Storage storage, Employee employee) {
        //利用Map传输入参和存储出参
        Map<String,String> params=new HashMap<>();
        params.put("orderNamePre","ST");
        params.put("storageCode","");
        //调用存储过程生成合同流水号
        storageMapper.generateStorageCode(params);
        //取得流水号
        String storageCode = params.get("storageCode");
        storage.setStorageCode(storageCode);
        storage.setCreateBy(employee.getEmployeeId());
        storage.setCreateTime(new Date());
        storage.setGoodsNumber(0.0);
        int addRow1=storageMapper.add(storage);
        //如果添加成功
        if(addRow1==1)
            return  StateType.getStateType(22);
        return  StateType.getStateType(23);
    }

    @Override
    public StateType invalid(int storageId) {
        Storage storage=storageMapper.queryStatusByStorageId(storageId);
        //如果合同已作废或归档，则不可作废
        if(storage.getStatus()== 4 || storage.getStatus()== 3)
            return StateType.getStateType(33);
        storage.setStatus(3);
        int updateRow=storageMapper.updateStatus(storage);
        //作废成功
        if(updateRow==1)
            return StateType.getStateType(26);
        return StateType.getStateType(27);
    }

    @Override
    public StateType confirm(int storageId) {
        Storage storage=storageMapper.queryStatusByStorageId(storageId);
        //合同仅在审核中状态才可确认
        if(storage.getStatus() != 1 )
            return StateType.getStateType(30);
        storage.setStatus(2);
        int updateRow=storageMapper.updateStatus(storage);
        //确认成功
        if(updateRow==1)
            return StateType.getStateType(28);
        return StateType.getStateType(29);
    }

    @Override
    public StateType archive(int storageId) {
        Storage storage=storageMapper.queryStatusByStorageId(storageId);
        //合同仅在归档、作废状态才不可归档
        if(storage.getStatus()== 4 || storage.getStatus()== 3)
            return StateType.getStateType(33);
        storage.setStatus(4);
        int updateRow=storageMapper.updateStatus(storage);
        //归档成功
        if(updateRow==1)
            return StateType.getStateType(31);
        return StateType.getStateType(32);
    }

    @Override
    public List<Storage> queryAllValidStorage() {
        return storageMapper.queryAllValidStorage();
    }

    @Override
    public StateType del(int storageId) {
        //只有在审核中才可删除
        Storage storage=storageMapper.queryStatusByStorageId(storageId);
        if(storage.getStatus() != 1 )
            return StateType.getStateType(30);
        int delRow=storageMapper.del(storageId);
        if(delRow==1)
            return StateType.getStateType(24);
        return StateType.getStateType(25);
    }
}
