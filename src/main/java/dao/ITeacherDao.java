package main.java.dao;

import java.util.List;
import java.util.Map;

/**
 * Created by yan on 2018/01/10.
 * 事件mapper
 */
@SuppressWarnings({"rawtypes"})
public interface ITeacherDao {
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
     * 新增
     * @param map
     * @return
     */
    int insert(Map map);

    /**
     * 新增
     * @param id
     * @return
     */
    void deleteById(Integer id);

    
}
