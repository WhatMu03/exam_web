package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IRequestDao;
import main.java.dao.IServiceAppraiseDao;
import main.java.service.IRequestService;


@Service
@SuppressWarnings({"rawtypes"})
public class RequestServiceImpl implements IRequestService {
	
	@Autowired
	IRequestDao requestDao;
    @Autowired
    IServiceAppraiseDao serviceAppraiseDao;

	@Override
	public List<Map> selectPage(Map map) {
		return requestDao.selectPage(map);
	}

	@Override
	public Integer selectCount(Map map) {
		return requestDao.selectCount(map);
	}

	@Override
	public List<Map<String,String>> selectExport(Map map) {
		return requestDao.selectExport(map); 
	}

	@Override
	public Map<String, String> selectDetail(Map map) {
    	List<Map<String, String>> list = requestDao.selectDetail(map);
    	if(list.size() == 0){
    		return null;
    	} else {
            return requestDao.selectDetail(map).get(0);
    	}
	}

	@Override
	public void synchronous(Map map) {

	}

	/**
	 * 是否存在具体需求评价
	 */
	@Override
	public boolean existRequestAppraise(Map map) {
		Integer count = serviceAppraiseDao.eventCount(map);
		if(count > 0){
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 查询未解决需求
	 */
	@Override
	public List<Map> unsolved(Map map) {
		return requestDao.unsolved(map);
	}

	/**
	 * 获取(上)下一条短信
	 */
	@Override
	public Map next(Map map) {
		List<Map> list = requestDao.select(map);
		if(list.size() == 0){
			return null;
		} else {
			String idExp = map.get("idExp").toString();
			if(idExp.contains("<")){//小于则获取该集合数据的最大一条
				return list.get(list.size() - 1);
			} else {//大于则获取该集合的第一条
				return list.get(0);
			}
		}
	}

	/**
	 * 置顶
	 * @param map
	 * @return
	 */
	@Override
	public Integer setTop(Map map) {
		return requestDao.top(map);
	}

	/**
	 * 取消置顶
	 * @param map
	 * @return
	 */
	@Override
	public Integer cancelTop(Map map) {
		return requestDao.cancelTop(map);
	}

}
