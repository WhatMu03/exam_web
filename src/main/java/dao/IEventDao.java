package main.java.dao;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 * 事件mapper
 */
@SuppressWarnings({"rawtypes"})
public interface IEventDao {
    /**
     * 查询
     * @param map
     * @return
     */
    List<Map> selectPage(Map map);

    /**
     *计数
     * @param map
     * @return
     */
    Integer selectCount(Map map);

    /**
     *详情
     * @param map
     * @return
     */
    List<Map<String,String>> selectDetail(Map map);

    /**
     * 导出
     * @param map
     * @return
     */
    List<Map<String,String>> selectExport(Map map);

    /**
     * 新增
     * @param map
     * @return
     */
    int insert(Map map);

    /**
     * 查询子账户信息
     * @param map 子账户loginNo
     * @return
     */
    List<Map<String,String>> selectSubAccount(Map map);

    /**
     * 查询客户信息
     * @param map customerNo
     * @return
     */
    List<Map<String ,String>> selectCustomer(Map map);

    /**
     * 新建事件表单初始化
     * @param map
     * @return
     */
    List<Map> selectFormInit(Map map);
    Integer maxId();
    Map<String,String> selectById(Integer id);
    void deleteById(Integer id);
    List<Map> monthEvent(Map map);
    List<Map> unsolved(Map map);
    List<Map> select(Map map);
    
}
