package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface IRequestDao {
	
	List<Map> selectPage(Map map);
	Integer selectCount(Map map);
	List<Map<String,String>> selectExport(Map map);
	List<Map<String,String>> selectDetail(Map map);
	void synchronous(Map map);
    List<Map> unsolved(Map map);
    List<Map> select(Map map);
	Integer top(Map map);
	Integer cancelTop(Map map);
}
