package main.java.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.dao.IDictionaryDao;
import main.java.service.IDictionaryService;
 
/**
 * 字典
 * @author shenda20467
 * 20170925
 */
@Service
@SuppressWarnings({"rawtypes"})
public class DictionaryServiceImpl implements IDictionaryService {

    @Autowired
    IDictionaryDao dictionaryDao;   

	@Override
	public List<Map> eventStatus() {
        return dictionaryDao.eventStatus(); 
	}

	@Override
	public List<Map> EVENT_TYPE() {
        return dictionaryDao.EVENT_TYPE(); 
	}

	@Override
	public List<Map> requestStatus() {
        return dictionaryDao.requestStatus(); 
	}
	
}
