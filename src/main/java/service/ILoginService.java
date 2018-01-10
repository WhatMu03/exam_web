package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface ILoginService {

	public List<Map> checkUser(Map map);


	public List<Map> select(Map map);


	public int update(Map map);
	public int updateStatus(Map map);
}
