package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface IHelpDao {

	List<Map> selectPage(Map map);
	Integer selectCount(Map map);  
	List<Map<String,String>> selectDetail(Map map); 
	void insert(Map map); 
	void delete(Map map); 
	void update(Map map); 
	void good(Map map); 
	void bad(Map map);  
	void click(Map map); 
	Integer maxId(); 
	List<Map> select(Map map);
	List<Map> select_detail(Map map);
	void insert_detail(Map map); 
	void update_detail(Map map); 
	List<Map> hotPage(Map map);
	List<Map> newPage(Map map);
	List<Map> commonPage(Map map);
	Integer commonCount(Map map);  
	
}
