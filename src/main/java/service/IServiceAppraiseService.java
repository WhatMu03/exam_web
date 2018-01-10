package main.java.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface IServiceAppraiseService {

    public List<Map> selectPage(Map map);
    public Integer selectCount(Map map);
    public void insert(Map map);
	public List<Map> haveEvaluated(Map map);
	public List<Map> notEvaluated(Map map);
    public Integer haveEvaluatedCount(Map map);
    public Integer notEvaluatedCount(Map map);

}