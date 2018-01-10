package main.java.dao;

import java.util.List;
import java.util.Map;
 
@SuppressWarnings({"rawtypes"})
public interface IDictionaryDao { 
	
    List<Map> eventStatus();
    List<Map> EVENT_TYPE();
    List<Map> requestStatus();
    
}
