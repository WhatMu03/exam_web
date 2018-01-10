package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IServiceAppraiseDao;
import main.java.service.IServiceAppraiseService;


@Service
@SuppressWarnings("rawtypes")
public class ServiceAppraiseServiceImpl implements IServiceAppraiseService {

    @Autowired
    IServiceAppraiseDao serviceAppraiseDao;


    @Override
    public List<Map> selectPage(Map map) {
        return serviceAppraiseDao.selectPage(map);
    }

    @Override
    public Integer selectCount(Map map) {
        return serviceAppraiseDao.selectCount(map);
    }

    @Override
    public void insert(Map map) {
        serviceAppraiseDao.insert(map);
    }

    /**
     * 已评价
     */
	@Override
	public List<Map> haveEvaluated(Map map) {
		return serviceAppraiseDao.haveEvaluated(map);
	}

	/**
	 * 待评价
	 */
	@Override
	public List<Map> notEvaluated(Map map) {
		return serviceAppraiseDao.notEvaluated(map);
	}

	/**
	 * 已评价数量
	 */
	@Override
	public Integer haveEvaluatedCount(Map map) {
		return serviceAppraiseDao.haveEvaluatedCount(map);
	}

	/**
	 * 待评价数量
	 */
	@Override
	public Integer notEvaluatedCount(Map map) {
		return serviceAppraiseDao.notEvaluatedCount(map);
	} 

}
