package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface ILoginDao {

	 List<Map> checkUser(Map map);

	 List<Map> select(Map map);

	 int update(Map map);
	 int updateStatus(Map map);
}
