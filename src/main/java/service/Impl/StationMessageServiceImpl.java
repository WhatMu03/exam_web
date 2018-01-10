package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IStationMessageDao;
import main.java.service.IStationMessageService;


@Service
@SuppressWarnings("rawtypes")
public class StationMessageServiceImpl implements IStationMessageService {
	
	@Autowired
	IStationMessageDao stationMessageDao;

	@Override
	public List<Map> selectPage(Map map) {
		if("需求".equals(map.get("obj"))){
			return stationMessageDao.selectPageRequest(map);
		} else if("事件".equals(map.get("obj"))){
			return stationMessageDao.selectPageEvent(map);
		} else {
			return stationMessageDao.selectPageSystem(map);
		} 
	}

	@Override
	public Integer selectCount(Map map) {
		if("需求".equals(map.get("obj"))){
			return stationMessageDao.selectCountRequest(map);
		} else if("事件".equals(map.get("obj"))){
			return stationMessageDao.selectCountEvent(map);
		} else {
			return stationMessageDao.selectCountSystem(map);
		} 
	}

	@Override
	public Map<String, String> selectDetail(Map map) {
		List<Map<String, String>> list = stationMessageDao.selectDetail(map);
		if (list.size() == 0){
			return null;
		} else {
			return list.get(0);
		}

	}

	@Override
	public void updateStatus(Map map) {
		stationMessageDao.updateStatus(map);
	}

	/**
	 * 删除短信
	 * @param map
	 */
	@Override
	public void delete(Map map) {
		stationMessageDao.delete(map);
	}

	/**
	 * 设为已读
	 * @param map
	 */
	@Override
	public void setRead(Map map) {
		stationMessageDao.setRead(map);
	}

	/**
	 * 获取(上)下一条短信
	 */
	@Override
	public Map next(Map map) {
		List<Map> list = stationMessageDao.select(map);
		if(list.size() == 0){
			return null;
		} else {
			String messageNoExp = map.get("messageNoExp").toString();
			if(messageNoExp.contains("<")){//小于则获取该集合数据的最大一条
				return list.get(list.size() - 1);
			} else {//大于则获取该集合的第一条
				return list.get(0);
			}
		}
	}

	/**
	 * 未读
	 */
	@Override
	public List<Map> noRead(Map map) {
		return stationMessageDao.noRead(map);
	} 
	
}
