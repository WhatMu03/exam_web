package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface ISubAccoService {

    public List<Map> select(Map map);

    public void updatePassword(Map map);

    public void updateStatus(Map map);

    public void update(Map map);
	public Map<String,String> selectDetail(Map map);


}
