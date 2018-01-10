package main.java.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import main.java.common.DateChange;
import main.java.util.MySessionContext;

/**
 * session监听器
 * @author shenda20467
 * 20170906
 */
@WebListener()
public class ResetLoginHelper implements HttpSessionListener {
    
	@Override
    public void sessionCreated(HttpSessionEvent se) {
    	System.out.println("session创建:" + DateChange.getDateTime() + "   " + se.getSession().getId());
        MySessionContext.AddSession(se.getSession());
    }
    
	@Override
    public void sessionDestroyed(HttpSessionEvent se) {  
    	HttpSession session = se.getSession();
        MySessionContext.DelSession(session);
    	System.out.println("session销毁:" + DateChange.getDateTime() + "   " + se.getSession().getId());      
    }
}