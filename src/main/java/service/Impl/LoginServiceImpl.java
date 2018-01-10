package main.java.service.Impl;

import main.java.dao.ILoginDao;
import main.java.service.ILoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
@SuppressWarnings({"rawtypes"})
public class LoginServiceImpl implements ILoginService {
	
	@Autowired
	ILoginDao loginDao;

	/**
	 * 查询账户信息
	 * @param map
	 * @return
	 */
	@Override
	public List<Map> checkUser(Map map) {
		return loginDao.checkUser(map);
	}

	/**
	 * 查询状态
	 * @param map
	 * @return
	 */
	@Override
	public List<Map> select(Map map) {
		return loginDao.select(map);
	}

	/**
	 * 更新
	 * @param map
	 * @return
	 */
	@Override
	public int update(Map map) {
		return loginDao.update(map);
	}

	/**
	 * 锁定
	 * @param map
	 * @return
	 */
	@Override
	public int updateStatus(Map map) {
		return loginDao.updateStatus(map);
	}
	
}
