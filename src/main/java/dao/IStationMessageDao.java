package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface IStationMessageDao {
	
	List<Map> selectPageRequest(Map map);
	Integer selectCountRequest(Map map); 
	List<Map> selectPageEvent(Map map);
	Integer selectCountEvent(Map map); 
	List<Map> selectPageSystem(Map map);
	Integer selectCountSystem(Map map); 
	List<Map<String,String>> selectDetail(Map map);
	void updateStatus(Map map);
	void delete(Map map);
	void setRead(Map map);
	List<Map> select(Map map);
	List<Map> noRead(Map map);
}
