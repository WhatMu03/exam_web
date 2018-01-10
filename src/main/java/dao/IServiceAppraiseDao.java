package main.java.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface IServiceAppraiseDao {

    List<Map> selectPage(Map map);
    Integer selectCount(Map map);
    void insert(Map map);
    Integer eventCount(Map map);
    Integer requestCount(Map map);
    List<Map> haveEvaluated(Map map);
    List<Map> notEvaluated(Map map);
    Integer haveEvaluatedCount(Map map);
    Integer notEvaluatedCount(Map map); 
    
}
