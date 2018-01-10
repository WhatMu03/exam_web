package main.java.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.common.LoginBinder;
import main.java.dao.IHelpDao;
import main.java.service.IHelpService;

@Service
@SuppressWarnings({"rawtypes","unchecked"})
public class HelpServiceImpl implements IHelpService{

	@Autowired
	IHelpDao helpDao; 


	@Override
	public List<Map> selectPage(Map map) {
		return helpDao.selectPage(map);
	}

	@Override
	public Integer selectCount(Map map) {
		return helpDao.selectCount(map);
	} 

	@Override
	public Map<String, String> selectDetail(Map map) {
		click(map);//打开详情,即调用点击量
		List<Map<String, String>> list = helpDao.selectDetail(map);
		if(list.size() == 0){//没取到详情,则赋予空对象
			return new HashMap<>();
		} else {
			return list.get(0);
		}
	}  
	
	/**
	 * 插入
	 */
	@Override
	public void insert(Map map) {
		helpDao.insert(map);
	} 

	/**
	 * 删除
	 */
	@Override
	public void delete(Map map) {
		helpDao.delete(map);
	}

	/**
	 * 更新
	 */
	@Override
	public void update(Map map) {
		helpDao.update(map);
	}

	/**
	 * 赞
	 */
	@Override
	public void good(Map map) {
		map.put("status", "1");
		updateStatus(map);
	}

	/**
	 * 踩
	 */
	@Override
	public void bad(Map map) {
		map.put("status", "0");
		updateStatus(map);
	} 

	/**
	 * 点击量
	 */
	@Override
	public void click(Map map) {
		helpDao.click(map);
	}

	/**
	 * 最新插入的数据id
	 */
	@Override
	public int maxId() {
		return helpDao.maxId();
	} 

	/**
	 * 获取(上)下一条短信
	 */
	@Override
	public Map next(Map map) {
		List<Map> list = helpDao.select(map);
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

	/**
	 *获取明细数据(仅仅一条)
	 */
	@Override
	public Map select_detail(Map map){
		List<Map> list = helpDao.select_detail(map);
		if(list.size() > 0){
			return list.get(0);
		} else {
			return null;
		}
	}
	 
	//明细表更新 
	public void updateStatus(Map map) {
		map.put("loginNo", LoginBinder.get().getLoginNo());
		map.put("help_center_id", map.get("id").toString());
		map.put("numExp", "+1");
		String status = map.get("status").toString();
		Map m = select_detail(map);
		if(m == null){//没有数据则插入
			helpDao.insert_detail(map);
			if("0".equals(status)){//踩
				helpDao.bad(map);
			} else {//赞
				helpDao.good(map);
			}
		} else {
			helpDao.update_detail(map);
			if("0".equals(m.get("status")) && "1".equals(status)){//如果本来是踩,现在点了赞，则总数中踩-1 ，赞+1
				helpDao.good(map);
				map.put("numExp", "-1");
				helpDao.bad(map);
			} else if("1".equals(m.get("status")) && "0".equals(status)){//如果本来是赞,现在点了踩，则总数中踩+1 ，赞-1
				helpDao.bad(map);
				map.put("numExp", "-1");
				helpDao.good(map);
			} else { //其他2种情况不做处理！
				
			}
		}
	}

	/**
	 * 热门
	 */
	@Override
	public List<Map> hotPage(Map map) {
		return helpDao.hotPage(map);
	}

	/**
	 * 最新
	 */
	@Override
	public List<Map> newPage(Map map) {
		return helpDao.newPage(map);
	}

	/**
	 * 常见list
	 */
	@Override
	public List<Map> commonPage(Map map) {
		return helpDao.commonPage(map);
	}

	/**
	 * 常见count
	 */
	@Override
	public Integer commonCount(Map map) {
		return helpDao.commonCount(map);
	}

}
