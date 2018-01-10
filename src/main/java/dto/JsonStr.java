package main.java.dto;

import net.sf.json.JSONObject;

import java.util.List;

/**
 * json字符串构建
 * @author shenda20467
 *
 */
public class JsonStr {
	
	private Integer total;
	
	private List<?> rows;

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	//返回的json字符串
	public static String jsonStr(List<?> list,Integer count){
		JsonStr jsonStr = new JsonStr();
		jsonStr.setRows(list);
		jsonStr.setTotal(count);
    	JSONObject result = JSONObject.fromObject(jsonStr); 
		return result.toString();
	}
	
}
