package main.java.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IESubmitterDao;
import main.java.dao.IEventDao;
import main.java.dao.IServiceAppraiseDao;
import main.java.service.IEventService;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 */
@Service
@SuppressWarnings({"rawtypes", "unchecked"})
public class EventServiceImpl implements IEventService {

    @Autowired
    IEventDao eventDao; 
    @Autowired
    IESubmitterDao eSubmitterDao;
    @Autowired
    IServiceAppraiseDao serviceAppraiseDao;

    @Override
    public List<Map> selectPage(Map map) {
        return eventDao.selectPage(map);
    }

    @Override
    public int selectCount(Map map) {
        return eventDao.selectCount(map);
    }

    @Override
    public Map<String, String> selectDetail(Map map) {
    	List<Map<String, String>> list = eventDao.selectDetail(map);
    	if(list.size() == 0){
    		return null;
    	} else {
            return eventDao.selectDetail(map).get(0);
    	}
    }

    @Override
    public List<Map<String, String>> selectExport(Map p) {
        return eventDao.selectExport(p);
    }
    
    /**
     * 插入
     */
	@Override
    public Map insert(Map map) { 
		Map returnMap = new HashMap<>();
		eventDao.insert(map);//临时记录数据在本库
		Integer id = eventDao.maxId();
		
		Map param = new HashMap<>();
		param.put("id", id);
		param.put("loginNo", map.get("loginNo").toString());
		param.put("loginName", map.get("loginName").toString());
		eSubmitterDao.insert(param);//键入关系
		
		for(int i=0;i<1000000;i++){
			Map m = eventDao.selectById(id);
			if (m.get("eventNo") == null){//返回事件编号为空,等待下次返回
				try {
					Thread.sleep(1000);//睡眠一秒钟
					continue;
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} else if("false".equals(m.get("eventNo"))){//插入数据出错,返回存入在description的错误信息
				eventDao.deleteById(id);//删除那条在本库插入的错误数据
				eSubmitterDao.delete(map);//删除事件id和提交人的关系
				returnMap.put("msg", m.get("description"));
				break;
			} else {//返回数据,正常情况
				break;
			}
		}
		return returnMap;
    }

/*	//根据受理人编号获取受理人名称
	public String getDealingUserName(String dealingUserNo){
		Map map = new HashMap<>();
		map.put("dealingUserNo", dealingUserNo);
		List<Map<String,String>> list = dealingUserDao.selectAll(map);
		String dealingUserName = list.get(0).get("dealingUserName").toString();
		return dealingUserName;
	}*/
	
    @Override
    public Map<String, String> selectSubAccount(Map map) {
        return eventDao.selectSubAccount(map).get(0);
    }

    @Override
    public Map<String, String> selectCustomer(Map map) {
        return eventDao.selectCustomer(map).get(0);
    }

    @Override
    public Map<String, String> selectFormInit(Map map) {
        return eventDao.selectFormInit(map).get(0);
    }

    /**
     * 获取固定月的事件
     */
	@Override
	public List<Map> monthEvent(Map map) {
		return eventDao.monthEvent(map);
	}

	/**
	 * 是否存在具体事件评价
	 */
	@Override
	public boolean existEventAppraise(Map map) {
		Integer count = serviceAppraiseDao.eventCount(map);
		if(count > 0){
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 查询未解决事件
	 */
	@Override
	public List<Map> unsolved(Map map) {
		return eventDao.unsolved(map);
	}

	/**
	 * 获取(上)下一条短信
	 */
	@Override
	public Map next(Map map) {
		List<Map> list = eventDao.select(map);
		if(list.size() == 0){
			return null;
		} else {
			String idExp = map.get("idExp").toString();
			if(idExp.contains("<")){//小于则获取该集合数据的最大一条
				return list.get(list.size() - 1);
			} else {//大于则获取该集合的第一条
				return list.get(0);
			}
		}
	}
}
