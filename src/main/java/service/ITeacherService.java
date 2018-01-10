package main.java.service;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@SuppressWarnings({"rawtypes"})
public interface ITeacherService {

    public List<Map> selectPage(Map map);

    public int selectCount(Map map);

    public void insert(Map map);

}
