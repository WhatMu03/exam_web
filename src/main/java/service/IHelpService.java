package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface IHelpService {

	public List<Map> selectPage(Map map);
	public Integer selectCount(Map map);  
	public Map<String,String> selectDetail(Map map); 
	public void insert(Map map);
	public void delete(Map map);
	public void update(Map map);
	public void good(Map map);
	public void bad(Map map); 
	public void click(Map map); 
	public int maxId(); 
	public Map next(Map map);
	public Map select_detail(Map map);
	public List<Map> hotPage(Map map);
	public List<Map> newPage(Map map);
	public List<Map> commonPage(Map map);
	public Integer commonCount(Map map);  
	
}
