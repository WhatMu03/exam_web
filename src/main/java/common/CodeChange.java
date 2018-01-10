package main.java.common;

import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * 转换编码
 * @author shenda20467
 *
 */
@SuppressWarnings({"rawtypes"})
public class CodeChange {
	
	/**
	 * iso8859-1 to utf-8 
	 * @param param
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Map toUtf8(Map<Object,Object> param) throws UnsupportedEncodingException{
        for ( Map.Entry entry : param.entrySet()) { 
        	String key = entry.getKey().toString();
        	if(entry.getValue() != null){
            	param.put(key,new String(entry.getValue().toString().getBytes("iso8859-1"),"utf-8"));
        	}
        }
		return param;
	}
	
}
