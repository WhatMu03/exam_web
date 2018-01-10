package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface IStationMessageService {
 
	public List<Map> selectPage(Map map);
	public Integer selectCount(Map map); 
	public Map<String,String> selectDetail(Map map);
	public void updateStatus(Map map);
	public void delete(Map map);
	public void setRead(Map map);
	public Map next(Map map);
	public List<Map> noRead(Map map);
	
}
