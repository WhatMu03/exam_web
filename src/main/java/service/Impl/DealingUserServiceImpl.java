package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IDealingUserDao;
import main.java.service.IDealingUserService;

@Service
@SuppressWarnings({"rawtypes"})
public class DealingUserServiceImpl implements IDealingUserService{

	@Autowired
	IDealingUserDao dealingUserDao; 
	
	@Override
	public List<Map> selectAll(Map map) {
		return dealingUserDao.selectAll(map);
	}

}
