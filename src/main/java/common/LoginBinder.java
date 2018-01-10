package main.java.common;

import main.java.entity.SubAcco;

/**
 * 登录用户工具类
 * @author shenda20467
 * 20170921
 */
public class LoginBinder { 

    private static final ThreadLocal<SubAcco> loginLocal = new ThreadLocal<>();
     
	public static void bind(SubAcco subAcco){
		loginLocal.set(subAcco);
	} 

	public static void unbind(){
		loginLocal.remove();
	} 

	public static SubAcco get() {
		return loginLocal.get();
	}
 
	
}
