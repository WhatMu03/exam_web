package main.java.common.commonMap;

import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/22.
 */
public class LoginMap {
    /**
     * string 登录账户的ID
     * integer 当前登录次数
     */
    public static  Map<String,Integer> countMap = new HashMap<>();
    /**
     * 最大登录次数
     */
    public static final Integer MAX_ACCESS_TIMES = 6;
    /**
     * 登录账户的sessionid
     */
    public static final Map<String,String> user_sessionId = new HashMap<>();
    

}
