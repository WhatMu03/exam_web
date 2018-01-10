package main.java.service.Impl;

import main.java.dao.IESubmitterDao;
import main.java.dao.IEventDao;
import main.java.dao.IServiceAppraiseDao;
import main.java.dao.ITeacherDao;
import main.java.service.IEventService;
import main.java.service.ITeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@Service
@SuppressWarnings({"rawtypes", "unchecked"})
public class TeacherServiceImpl implements ITeacherService {

    @Autowired
	ITeacherDao teacherDao;
    @Autowired
    IESubmitterDao eSubmitterDao;
    @Autowired
    IServiceAppraiseDao serviceAppraiseDao;

    @Override
    public List<Map> selectPage(Map map) {
        return teacherDao.selectPage(map);
    }

    @Override
    public int selectCount(Map map) {
        return teacherDao.selectCount(map);
    }

    /**
     * 插入
     */
	@Override
    public void insert(Map map) {
		teacherDao.insert(map);
    }
}
