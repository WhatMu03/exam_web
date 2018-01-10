package main.java.service;

import java.util.List;
import java.util.Map; 

@SuppressWarnings({"rawtypes"})
public interface IDictionaryService {

    public List<Map> eventStatus(); 
    public List<Map> EVENT_TYPE(); 
    public List<Map> requestStatus(); 
    
}
