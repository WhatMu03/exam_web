package main.java.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import main.java.dto.IEnum;
import main.java.util.EnumUtil;
import main.java.util.ExcelUtil;
import main.java.validate.ValidatePassword;

/**
 * 一些简单的公共方法
 * @author shenda20467
 * 20170817
 */
@SuppressWarnings({"rawtypes","unchecked"})
public class CommonMethod{
	
	/**
	 * 前台传参进行处理
	 * @param parameterMap
	 * @return
	 */
    public static Map<String, String> newParam(Map<String, String[]> parameterMap) {
        Map<String, String> param = new HashMap<String, String>();
        for(String paramName : parameterMap.keySet()) {
            String[] paramValues = parameterMap.get(paramName);
            if(paramValues!=null && paramValues.length==1) {
                param.put(paramName, paramValues[0]);
            }
        }
        return param;
    } 
    
    /**
     * 自动生成密码
     * @return
     */
    public static String autoPassword(){
        char[] charAndnum = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".toCharArray();
        Random random = new Random(); //用于产生随机数
        ValidatePassword vp = new ValidatePassword();
        String str = "";
        do{
        	str = "";
            for (int j = 0; j < 8; j++) {
            	str += charAndnum[random.nextInt(51)];
            }
        }while(!vp.pwdComplexity(str));
    	return str;
    }
    
    /**
     * 导出方法封装
     * @param list
     * @throws Exception 
     */
    public static void export(List<Map<String,String>> list,HttpServletResponse response,Class cls) throws Exception{
		List<Map<String,String>> listMap = new ArrayList<>();
		String name = "";
		
		if(list.size() == 0){ 
			return;
		} else { 
			for(int i=1;i<= list.get(0).size();i++){
		        for ( Map.Entry entry : list.get(0).entrySet()) { 
		        	Map map = new HashMap<>();
		        	String key = entry.getKey().toString(); 
		        	IEnum er = (IEnum)(EnumUtil.valOf(key, cls)); 
		        	if("".equals(name)) {
						name = name + er.fileName();
					}
		        	if(er != null && i == er.getOrder()){
			        	map.put("name", er.getName());
			        	map.put("label", er.getLabel()); 
			        	listMap.add(map);
		        	}
		        }
			}
		} 
		
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");//可以方便地修改日期格式
        String date = dateFormat.format(now);
        name = name + "_" + date; 
        ExcelUtil.exportExcel(response,name,listMap,list); 
    }
    
    public static void main(String[] args) { 
        String str = CommonMethod.autoPassword();
        System.out.println(str);
	}

}
