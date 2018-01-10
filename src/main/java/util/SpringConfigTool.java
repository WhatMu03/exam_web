package main.java.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.ContextLoader;

/**
 * 工具包
 * @author shenda20467
 *
 */
public class SpringConfigTool implements ApplicationContextAware{

	 private static ApplicationContext ac = ContextLoader.getCurrentWebApplicationContext();
	 private static SpringConfigTool springConfigTool = null;
     private String pwdComplexity;
     private String canLogin;
    
	 public String getPwdComplexity() {
		return pwdComplexity;
	 }

	 public void setPwdComplexity(String pwdComplexity) {
		 this.pwdComplexity = pwdComplexity;
	 }	 
	 
	 public String getCanLogin() {
		return canLogin;
	}

	public void setCanLogin(String canLogin) {
		this.canLogin = canLogin;
	}

	public synchronized static SpringConfigTool init() {
		 if (springConfigTool == null) {
			 springConfigTool = new SpringConfigTool();
		 }
		 return springConfigTool;
	 }
	 
	 @Override
	 public void setApplicationContext(ApplicationContext applicationContext)throws BeansException {
		 ac = applicationContext;
	 }
	 
	 public synchronized static Object getBean(String beanName) {
		 return ac.getBean(beanName);
	 }

}
