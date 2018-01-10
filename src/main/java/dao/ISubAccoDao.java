package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface ISubAccoDao {

	List<Map> select(Map map);
	void updatePassword(Map map);
	void updateStatus(Map map);
	void update(Map map);
	List<Map<String,String>> selectDetail(Map map);
}
