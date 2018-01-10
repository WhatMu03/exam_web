package main.java.test;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;

@SuppressWarnings({"rawtypes","unused"})
public class TestObject {

	public static void main(String[] args) {
		
		String str = "{\"flag\":0,\"obj\":{\"id\":\"201709011016024797647128\"},\"msg\":\"新增成功!\"}";
		JSONObject jsStr = JSONObject.parseObject(str);  
		String id = "";
		String msg = "";
		if("0".equals(jsStr.get("flag"))){//成功
			Map map = (Map) jsStr.get("obj");
			id = map.get("id").toString();
		} else {//失败 
			msg = jsStr.get("msg").toString();
		}
		
	}

}
