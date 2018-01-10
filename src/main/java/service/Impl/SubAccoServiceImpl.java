package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.ISubAccoDao;
import main.java.service.ISubAccoService;

@Service
@SuppressWarnings({"rawtypes"})
public class SubAccoServiceImpl implements ISubAccoService {

    @Autowired
    ISubAccoDao subAccoDao;

    @Override
    public List<Map> select(Map map) {
        return subAccoDao.select(map);
    }

    /**
     * 更新密码
     */
    @Override
    public void updatePassword(Map map) {
        subAccoDao.updatePassword(map);
    }

    /**
     * 更新账户状态
     */
    @Override
    public void updateStatus(Map map) {
        subAccoDao.updateStatus(map);
    }

    /**
     * 更新子账户数据
     */
    @Override
    public void update(Map map) {
        subAccoDao.update(map);
    }

	@Override
	public Map<String, String> selectDetail(Map map) {
        List<Map<String, String>> list = subAccoDao.selectDetail(map);
        if (list.size() == 0){
            return null;
        } else {
            return list.get(0);
        }
	}


}
