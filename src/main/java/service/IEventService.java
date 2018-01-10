package main.java.service;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@SuppressWarnings({"rawtypes"})
public interface IEventService {

    public List<Map> selectPage(Map map);

    public int selectCount(Map map);

    public Map<String,String> selectDetail(Map map);

    public List<Map<String,String>> selectExport(Map p);

    public Map insert(Map map);

    public Map<String ,String> selectSubAccount(Map map);

    public Map<String ,String> selectCustomer(Map map);

    public Map<String,String> selectFormInit(Map map);
    public List<Map> monthEvent(Map map);
    public boolean existEventAppraise(Map map);
    public List<Map> unsolved(Map map);
	public Map next(Map map);
}
