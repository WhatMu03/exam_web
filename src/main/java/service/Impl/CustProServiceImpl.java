package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.ICustProDao;
import main.java.service.ICustProService;
 
/**
 * 字典
 * @author shenda20467
 * 20170925
 */
@Service
@SuppressWarnings({"rawtypes"})
public class CustProServiceImpl implements ICustProService {

    @Autowired
    ICustProDao custProDao;

	@Override
	public List<Map> select(Map map) {
		return custProDao.select(map);
	}   
 
	
}
