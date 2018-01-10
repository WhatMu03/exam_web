package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings({"rawtypes"})
public interface IRequestService {
 
	public List<Map> selectPage(Map map);
	public Integer selectCount(Map map);
	public List<Map<String,String>> selectExport(Map map);
	public Map<String,String> selectDetail(Map map);
	public void synchronous(Map map);
    public boolean existRequestAppraise(Map map);
    public List<Map> unsolved(Map map);
	public Map next(Map map);
	public Integer setTop(Map map);
	public Integer cancelTop(Map map);
}
